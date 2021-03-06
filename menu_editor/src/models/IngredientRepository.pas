unit IngredientRepository;

interface

uses
	Ingredient;

type
	TIngredientRepository = class
	public
		class function GetAll(ABaseName: string): TIngredientArray;
		class function GetAllWithoutCheck(ABaseName: string): TIngredientArray;
		class function GetPeriodHistory(
			ABaseName: string; AStart: TDateTime; AEnd: TDateTime;
			AChecked: array of integer
		): THistoryIngredientArray;
	end;

implementation

uses
	SysUtils, db_comps_additional, Measure;
{ TIngredientRepository }

class function TIngredientRepository.GetAll(ABaseName: string): TIngredientArray;
var
	adc: TDBCompsAddit;
begin
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TIngredientRepository.GetAll(); Can not init adc');
		adc.Destroy;
		Exit;
	end;
	with adc.query do
	begin
		SQL.Text :=
			'SELECT ' +
				'i.id as i_id, i.caption as i_caption, i.createdAt as i_createdAt, ' +
				'm.id as m_id, m.caption as m_caption ' +
			'FROM ' +
				'ingredients i INNER JOIN measures m ON i.measure_id = m.id ' +
			'WHERE i.expiredAt is null ' +
			'ORDER BY i.id';
		try
			Open;
		except
			on E:Exception do
			begin
				result := nil;
				raise Exception.Create(
					'TIngredientRepository.GetAll(); Can not execute query! Error: ' + E.Message
				);
				adc.Destroy;
				Exit;
			end;
		end;
		while not eof do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := TIngredient.Create(
				FieldByName('i_id').AsInteger,
				FieldByName('i_caption').AsString,
				TMeasure.Create(
					FieldByName('m_id').AsInteger,
					FieldByName('m_caption').AsString
				)
			);
			Next;
		end;
	end;
	adc.Destroy;
end;

class function TIngredientRepository.GetAllWithoutCheck(
  ABaseName: string): TIngredientArray;
var
	adc: TDBCompsAddit;
begin
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TIngredientRepository.GetAllWithoutCheck(); Can not init adc');
		adc.Destroy;
		Exit;
	end;
	with adc.query do
	begin
		SQL.Text :=
		'SELECT ' +
			'i.id, i.caption ' +
		'FROM ' +
			'Ingredients i ' +
		'ORDER BY i.id';
		try
			Open;
		except
			on E:Exception do
			begin
				raise Exception.Create(
					'TIngredientRepository.GetAllWithoutCheck(); Can not execute query! Error: ' + E.Message
				);
				adc.Destroy;
				Exit;
			end;
		end;
		while not eof do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := TIngredient.Create(
				FieldByName('id').AsInteger,
				FieldByName('caption').AsString
			);
			Next;
		end;
	end;
	adc.Destroy;
end;
class function TIngredientRepository.GetPeriodHistory(ABaseName: string; AStart,
  AEnd: TDateTime; AChecked: array of integer): THistoryIngredientArray;
var
	adc: TDBCompsAddit;
	idStr: string;
	i: integer;
begin
	if (length(AChecked) = 0) then
	begin
        exit;
	end;
	for i := 0 to high(AChecked) do
	begin
		if i > 0 then
		begin
			idStr := idStr + ', ';
		end;
		idStr := idStr + IntToStr(AChecked[i]);
	end;
	idStr := '(' + idStr + ') ';
	adc := TDBCompsAddit.Create(ABaseName);
	if not adc.Init then
	begin
		result := nil;
		raise Exception.Create('TIngredientRepository.GetPeriodHistory(); Can not init adc');
		adc.Destroy;
		Exit;
	end;
	with adc.query do
	begin
		SQL.Text :=
			'SELECT ' +
			'    i2.id as i2_id, i2.caption as i2_caption, i_info.cnt as cnt, i2.createdAt as i2_ca, i2.expiredAt as i2_ea, m.id as m_id, m.caption as m_caption ' +
			'FROM ' +
			'    (SELECT  ' +
			'        i.id as i_id, ' +
			'        sum((sold_pg.amount + sold_pg.action_amount) * r.AMOUNT) as cnt ' +
			'    FROM  ' +
			'        (SELECT  ' +
			'            pg.id as id, SUM(sg.amount) as amount, SUM(sg.action_amount) as action_amount ' +
			'        FROM  ' +
			'            Sales s INNER JOIN Sale_goods sg ON sg.sale_id = s.id ' +
			'            INNER JOIN Priced_goods pg ON sg.good_id = pg.id ' +
			'        WHERE ' +
			'            s.dt >= :date_start AND s.dt <= :date_end ' +
			'        GROUP BY ' +
			'            id ' +
			'        ) as sold_pg ' +
			'            INNER JOIN priced_goods pg2 ON pg2.id = sold_pg.id ' +
			'            INNER JOIN Goods g ON pg2.good_id = g.id ' +
			'            INNER JOIN Recipes r ON r.good_id = g.id ' +
			'            INNER JOIN Ingredients i ON r.INGR_ID  = i.id ' +
			'        GROUP BY i.id ' +
			'    ) as i_info ' +
			'    INNER JOIN ingredients i2 ON i_info.i_id = i2.id ' +
			'    INNER JOIN measures m ON i2.MEASURE_ID = m.id';
		ParamByName('date_start').AsDateTime := AStart;
		ParamByName('date_end').AsDateTime := AEnd;
		try
			Open;
		except
			on E:Exception do
			begin
				result := nil;
				raise Exception.Create(
					'TIngredientRepository.GetPeriodHistory(); Can not execute query! Error: ' + E.Message
				);
				adc.Destroy;
				Exit;
			end;
		end;
		while not EOF do
		begin
			setlength(result, length(result) + 1);
			result[high(result)] := THistoryIngredient.Create(
				FieldByName('i2_id').AsInteger,
				FieldByName('i2_caption').AsString,
				FieldByName('i2_ca').AsDateTime,
				FieldByName('i2_ea').AsDateTime,
				TMeasure.Create(
					FieldByName('m_id').AsInteger,
					FieldByName('m_caption').AsString
				),
				FieldByName('cnt').AsFloat
			);
			Next;
		end;
	end;
	adc.Destroy;
end;

end.
