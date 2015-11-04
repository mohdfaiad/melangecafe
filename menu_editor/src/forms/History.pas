unit History;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Session, Sale;

type
  TfmHistory = class(TForm)
    pnlLayout: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
	pnlLeftLeft: TPanel;
    pnlLeftRight: TPanel;
    pnlRightLeft: TPanel;
    pnlRightRight: TPanel;
    sgSession: TStringGrid;
    sgSales: TStringGrid;
    sgGoods: TStringGrid;
    sgIngredients: TStringGrid;
    splRight: TSplitter;
    splLeft: TSplitter;
    splMiddle: TSplitter;
    procedure sgSessionClick(Sender: TObject);
  private
	sessions: TSessionArray;
	sales: TSalesArray;

	
	procedure clear;
	
	procedure setupSessions;
	procedure clearSessions;
	procedure initSessionsGrid;
	procedure redrawSessions;

	procedure setupSales(ASession: TSession);
	procedure clearSales;
	procedure initSalesGrid;
	procedure redrawSales;

	function getGridSelectedRowIdx(Obj: TObject): integer;
  public
	BaseName: string;
	procedure prepare;
  end;

  procedure show(dbname: string);

var
  fmHistory: TfmHistory;

implementation

uses SessionRepository, SaleRepository;

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
end;

procedure TfmHistory.clearSales;
begin

end;

procedure TfmHistory.clearSessions;
var
	i: integer;
begin
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

procedure TfmHistory.initSalesGrid;
begin
	with sgSession do
	begin
		RowCount := 1;
		ColCount := 4;
		Cells[0, 0] := 'ID';
		Cells[1, 0] := '�����';
		Cells[2, 0] := '���';
		Cells[3, 0] := '������?';
		ColWidths[0] := 0;
		ColWidths[1] := 110;
		ColWidths[2] := 55;
		ColWidths[3] := 55;
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

procedure TfmHistory.redrawSales;
var
	i: integer;
begin
	initSalesGrid();
	sgSales.RowCount := length(sales) + 1;
	for i := 0 to high(sales) do
	begin
		with sgSales do
		begin
//            Cells
        end;
	end;

end;

procedure TfmHistory.redrawSessions;
var
	i: integer;
begin
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

procedure TfmHistory.setupSales(Session: TSession);
begin
	if (length(sales) > 0) then
	begin
        clearSales();
	end;
	sales := TSaleRepository.GetAllForSession(Session);
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
end;

end.