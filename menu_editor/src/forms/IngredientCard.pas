unit IngredientCard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Measure, Vcl.StdCtrls, Vcl.ExtCtrls, Ingredient,
  Vcl.Grids, IngredientRecipe;

type
	TfmIngredientCard = class(TForm)
		leCaption: TLabeledEdit;
		pnlBtns: TPanel;
		btnSave: TButton;
		btnCancel: TButton;
		cbMeasure: TComboBox;
		lbMeasure: TLabel;
		pnlIngredientInfo: TPanel;
		pnlRecipe: TPanel;
		pnlRecipeBtns: TPanel;
		btnRecipeCreate: TButton;
		btnRecipeDelete: TButton;
		btnRecipeEdit: TButton;
		sgRecipes: TStringGrid;
		procedure leCaptionClick(Sender: TObject);
		procedure btnSaveClick(Sender: TObject);
		procedure btnCancelClick(Sender: TObject);
    procedure btnRecipeCreateClick(Sender: TObject);
    procedure btnRecipeEditClick(Sender: TObject);
    procedure btnRecipeDeleteClick(Sender: TObject);
	private
	{ Private declarations }
	public
		BaseName: string;
		measures: TMeasureArray;
		recipes: TIngredientRecipeArray;
		PIngredient: TPIngredient;
		procedure prepare();
		procedure resetRecipes();
	{ Public declarations }
	end;

function show(APIngredient: TPIngredient; ABaseName: string): boolean;

var
  fmIngredientCard: TfmIngredientCard;

implementation

{$R *.dfm}

uses ValInput, MeasureRepository, IngredientRecipeRepository, vars, RecipeCard;

function show(APIngredient: TPIngredient; ABaseName: string): boolean;
begin
	if (fmIngredientCard = nil) then
	begin
        fmIngredientCard := TfmIngredientCard.Create(nil);
	end;
	fmIngredientCard.BaseName := ABaseName;
	fmIngredientCard.PIngredient := APIngredient;
	fmIngredientCard.prepare();
	fmIngredientCard.ShowModal();
	result := fmIngredientCard.ModalResult = mrOk;
end;

{ TfmIngredientCard }

procedure TfmIngredientCard.btnCancelClick(Sender: TObject);
begin
	ModalResult := mrCancel;
	CloseModal;
end;

procedure TfmIngredientCard.btnRecipeCreateClick(Sender: TObject);
var
	Recipe: TIngredientRecipe;
begin
	Recipe := TIngredientRecipe.Create(
		TIngredient.Create(PIngredient^.Id)
	);
	if (RecipeCard.show(@Recipe, BaseName)) then
	begin
	   Recipe.Insert(BaseName);
	   resetRecipes();
	end;
end;

procedure TfmIngredientCard.btnRecipeDeleteClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgRecipes.Selection.Top;
	if (selected > 0) and (length(recipes) >= selected) then
	begin
		recipes[selected - 1].Delete(BaseName);
		resetRecipes();
    end;
end;

procedure TfmIngredientCard.btnRecipeEditClick(Sender: TObject);
var
	selected: integer;
begin
	selected := sgRecipes.Selection.Top;
	if (selected > 0) and (length(recipes) >= selected) then
	begin
		if (RecipeCard.show(@recipes[selected - 1], BaseName)) then
		begin
			recipes[selected - 1].Update(BaseName);
			resetRecipes();
        end;
    end;
end;

procedure TfmIngredientCard.btnSaveClick(Sender: TObject);
var
	selMeasure: integer;
begin
	selMeasure := cbMeasure.ItemIndex;
	if (selMeasure < 0) or (selMeasure >= length(measures)) then
	begin
		ShowMessage('�������� ������� ���������!');
		Exit;
	end;
	if (PIngredient^.Id > 0) and (PIngredient^.Measure.Id = measures[selMeasure].Id)
		and (PIngredient^.Caption =  leCaption.Text) then
	begin
		ModalResult := mrCancel;
		CloseModal;
		exit;
    end;
    PIngredient^.Measure := measures[selMeasure];
	PIngredient^.Caption := leCaption.Text;
	ModalResult := mrOk;
	CloseModal;
end;

procedure TfmIngredientCard.leCaptionClick(Sender: TObject);
var
	s: string;
begin
	s := GetText(false, '�������� �����������', '������� ��������');
	leCaption.Text := s;
end;

procedure TfmIngredientCard.prepare;
var
	i: integer;
	idx: integer;
begin
	leCaption.Text := PIngredient^.Caption;
	cbMeasure.Items.Clear;
	cbMeasure.Text := '';
	measures := TMeasureRepository.GetAll(BaseName);
	for i := 0 to high(measures) do
	begin
		if (PIngredient^.Id > 0) then
		begin
			if (PIngredient^.Measure.Id = measures[i].Id) then
			begin
                idx := i;
            end;
        end;
		cbMeasure.Items.Add(measures[i].Caption);
	end;
	cbMeasure.ItemIndex := idx;
	cbMeasure.Update;
	if (PIngredient^.Id > 0) then
	begin
		pnlRecipe.Enabled := true;
		with sgRecipes do
		begin
			RowCount := 1;
			ColCount := 4;
			FixedCols := 1;
			Cells[0, 0] := 'Id';
			Cells[1, 0] := '����������';
			Cells[2, 0] := '����������';
			Cells[3, 0] := '��. ���������';
			ColWidths[0] := 50;
			ColWidths[1] := 200;
			ColWidths[2] := 150;
			ColWidths[3] := 150;
		end;
        resetRecipes();
	end
end;

procedure TfmIngredientCard.resetRecipes;
var
	i: integer;
begin
	for i := 0 to high(recipes) do
	begin
		FreeAndNil(recipes[i]);
	end;
	setlength(recipes, 0);
	recipes := TIngredientRecipeRepository.GetAllForIngredient(BaseName, PIngredient^.Id);
	with sgRecipes do
	begin
		RowCount := 1;
		for i := 0 to high(recipes) do
		begin
			RowCount := RowCount + 1;
			Cells[0, i + 1] := IntToStr(recipes[i].Id);
			Cells[1, i + 1] := recipes[i].Part.Caption;
			Cells[2, i + 1] := AmountToStr(recipes[i].Amount);
			Cells[3, i + 1] := recipes[i].Part.Measure.Caption;
		end;
	end;
end;

end.
