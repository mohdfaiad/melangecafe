unit History;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Session, Sale, SaleGood,
  Vcl.StdCtrls;

type
  TfmHistory = class(TForm)
    pnlLayout: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
	pnlLeftLeft: TPanel;
    pnlLeftRight: TPanel;
    sgSession: TStringGrid;
    sgSales: TStringGrid;
    sgGoods: TStringGrid;
    splLeft: TSplitter;
    splMiddle: TSplitter;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure sgSessionClick(Sender: TObject);
    procedure sgSalesClick(Sender: TObject);
  private
	sessions: TSessionArray;
	sales: TSalesArray;
	goods: TSaleGoodArray;

	
	procedure clear;
	
	procedure setupSessions;
	procedure clearSessions;
	procedure initSessionsGrid;
	procedure redrawSessions;

	procedure setupSales(ASession: TSession);
	procedure clearSales;
	procedure initSalesGrid;
	procedure redrawSales;

	procedure setupGoods(ASale: TSale); overload;
	procedure setupGoods(ASession: TSession); overload;
	procedure clearGoods;
	procedure initGoodsGrid;
	procedure redrawGoods;

	function getGridSelectedRowIdx(Obj: TObject): integer;
  public
	BaseName: string;
	procedure prepare;
  end;

  procedure show(dbname: string);

var
  fmHistory: TfmHistory;

implementation

uses SessionRepository, SaleRepository, PricedGoodRepository, SaleGoodRepository, common_functions;

{$R *.dfm}

procedure show(dbname: string);
begin
	if (fmHistory = nil) then
	begin
        fmHistory := TfmHistory.Create(nil);
	end;
	fmHistory.BaseName := dbname;
	fmHistory.prepare();
	fmHistory.Show();
end;

{ TfmHistory }

procedure TfmHistory.clear;
begin
	clearSessions();
	clearGoods();
	clearSales();
end;

procedure TfmHistory.clearGoods;
var
	i: integer;
begin
	for i := 0 to high(goods) do
	begin
        FreeAndNil(goods[i]);
	end;
	setlength(goods, 0);
end;

procedure TfmHistory.clearSales;
var
	i: integer;
begin
	clearGoods();
	for i := 0 to high(sales) do
	begin
		FreeAndNil(sales[i]);
	end;
	setlength(sales, 0);
end;

procedure TfmHistory.clearSessions;
var
	i: integer;               	
begin
	clearSales();
	for i := 0 to high(sessions) do
	begin
		FreeAndNil(sessions[i]);
	end;
	setlength(sessions, 0);
end;

function TfmHistory.getGridSelectedRowIdx(Obj: TObject): integer;
var
	grid: TStringGrid;
begin
	grid := TStringGrid(Obj);
	result := grid.Selection.Top;
	if not((result > 0) and (result < grid.RowCount)) then
	begin
		result := -1;
	end;
end;

procedure TfmHistory.initGoodsGrid;
begin
	with sgGoods do
	begin
		RowCount := 1;
		ColCount := 6;
		Cells[0, 0] := 'ID';
		Cells[1, 0] := '��������';
		Cells[2, 0] := '����';
		Cells[3, 0] := '��/�';
		Cells[4, 0] := '���/�';
		Cells[5, 0] := '����';
		ColWidths[0] := 0;
		ColWidths[1] := 150;
		ColWidths[2] := 50;
		ColWidths[3] := 50;
		ColWidths[4] := 50;
		ColWidths[5] := 50;
    end;
end;

procedure TfmHistory.initSalesGrid;
begin
	with sgSales do
	begin
		RowCount := 1;
		ColCount := 5;
		Cells[0, 0] := 'ID';
		Cells[1, 0] := '�����';
		Cells[2, 0] := '���';
		Cells[3, 0] := '������?';
		Cells[4, 0] := '�����';
		ColWidths[0] := 0;
		ColWidths[1] := 110;
		ColWidths[2] := 55;
		ColWidths[3] := 55;
		ColWidths[4] := 100;
	end;
end;

procedure TfmHistory.initSessionsGrid;
begin
	with sgSession do
	begin
		RowCount := 1;
		ColCount := 3;
		Cells[0, 0] := 'ID';
		Cells[1, 0] := '�';
		Cells[2, 0] := '��';
		ColWidths[0] := 0;
		ColWidths[1] := 110;
		ColWidths[2] := 110;
	end;
end;

procedure TfmHistory.prepare;
var
	i: integer;
begin
	clear();
	initSessionsGrid();
	setupSessions();
end;

procedure TfmHistory.redrawGoods;
var
	i: integer;
begin
	initGoodsGrid();
	sgGoods.RowCount := length(goods) + 1;
	for i := 0 to high(goods) do
	begin
		with sgGoods do
		begin
			Cells[1, i + 1] := goods[i].PricedGood.Good.Caption;
			Cells[2, i + 1] := FltToStr(goods[i].PricedGood.Price);
			Cells[3, i + 1] := FltToStr(goods[i].Amount);
			Cells[4, i + 1] := FltToStr(goods[i].ActionAmount);
			Cells[5, i + 1] := FltToStr(goods[i].Amount * goods[i].PricedGood.Price);
        end;
	end;
end;

procedure TfmHistory.redrawSales;
var
	i: integer;
begin
	redrawGoods();
	initSalesGrid();
	sgSales.RowCount := length(sales) + 1;
	for i := 0 to high(sales) do
	begin
		with sgSales do
		begin
			Cells[0, i + 1] := IntToStr(sales[i].id);
			Cells[1, i + 1] := DateTimeToStr(sales[i].dt);
			Cells[2, i + 1] := sales[i].GetStringifiedSaleType();
			Cells[3, i + 1] := sales[i].GetStringifiedIsHasDiscount();
			Cells[4, i + 1] := FltToStr(sales[i].getRealMoney);
        end;
	end;
end;

procedure TfmHistory.redrawSessions;
var
	i: integer;
begin
	redrawSales();
	initSessionsGrid();
	sgSession.RowCount := length(sessions) + 1;
	for i := 0 to high(sessions) do
	begin
		with sgSession do
		begin
			Cells[0, i + 1] := IntToStr(sessions[i].Id);
			Cells[1, i + 1] := DateTimeToStr(sessions[i].DtStart);
			Cells[2, i + 1] := DateTimeToStr(sessions[i].DtEnd);
		end;
	end;
end;

procedure TfmHistory.setupGoods(ASale: TSale);
begin
	if (length(goods) > 0) then
	begin
		clearGoods();
	end;
	goods := TSaleGoodRepository.GetAllForSale(BaseName, ASale);
	redrawGoods();
end;

procedure TfmHistory.setupGoods(ASession: TSession);
begin
	if (length(goods) > 0) then
	begin
		clearGoods();
	end;
	goods := TSaleGoodRepository.GetAllForSession(BaseName, ASession);
	redrawGoods();
end;

procedure TfmHistory.setupSales(ASession: TSession);
begin
	if (length(sales) > 0) then
	begin
		clearGoods();
        clearSales();
	end;
	sales := TSaleRepository.GetAllForSession(BaseName, ASession);
	redrawSales();
end;

procedure TfmHistory.setupSessions;
begin
	if (length(sessions) > 0) then
	begin
		clearSessions();
	end;
	sessions := TSessionRepository.GetAll(BaseName);
	redrawSessions();
end;


procedure TfmHistory.sgSalesClick(Sender: TObject);
var
	selectedRowIdx: integer;
begin
	selectedRowIdx := getGridSelectedRowIdx(Sender);
	if (selectedRowIdx < 0) then
	begin
        exit;
	end;
	initGoodsGrid();
	setupGoods(sales[selectedRowIdx - 1]);
end;

procedure TfmHistory.sgSessionClick(Sender: TObject);
var
	selectedRowIdx: integer;
begin
	selectedRowIdx := getGridSelectedRowIdx(Sender);
	if (selectedRowIdx < 0) then
	begin
        exit;
	end;
	initSalesGrid();
	setupSales(sessions[selectedRowIdx - 1]);
	setupGoods(sessions[selectedRowIdx - 1]);	
end;

end.
