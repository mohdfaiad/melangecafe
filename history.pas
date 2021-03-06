unit history;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ComCtrls, Vcl.ExtCtrls, vars;

type
   TfmHistory = class(TForm)
      pnlFilters: TPanel;
      dtpStart: TDateTimePicker;
      dtpEnd: TDateTimePicker;
      btnView: TButton;
      lstActions: TCheckListBox;
      pnlView: TPanel;
      sgView: TStringGrid;
      procedure btnViewClick(Sender: TObject);
      procedure sgViewClick(Sender: TObject);
   private
      procedure InitCtrls;
      procedure SortActions;
      procedure FindSales;
      procedure FindSessions;
      procedure FindCashActions;
      procedure View;
      procedure ClearActions;
      procedure AddAction(AId: integer; AAType: TEActionType; ADt: TDateTime; AMoney: double);
      procedure ShowExtInfo(AActionId: integer);
   private
      grid: TStringGrid;
      actions: array of TRAction;
   public
      constructor Create;
  end;

var
  fmHistory: TfmHistory;

implementation

uses
  db_comps_additional, ext_info;
var
   SGVIEW_COL_COUNT: integer;
   SGVIEW_CAPS: array of string;
   SGVIEW_WIDTHS: array of integer;
   ATCaps: array of string;

{$R *.dfm}

{ TfmHistory }

procedure TfmHistory.AddAction(AId: integer; AAType: TEActionType;
  ADt: TDateTime; AMoney: double);
begin
   setlength(actions, length(actions) + 1);
   with actions[high(actions)] do
   begin
      id := AId;
      actionType := AAType;
      dt := ADt;
      money := AMoney;
   end;
end;

procedure TfmHistory.btnViewClick(Sender: TObject);
begin
   ClearActions;
   FindSales;
   FindSessions;
   FindCashActions;
   SortActions;
   View;
end;

procedure TfmHistory.ClearActions;
var
   i: integer;
begin
//   for i := 0 to high(actions) do IF TRAction = class
//      FreeAndNil(actions[i]);
   setlength(actions, 0);
end;

constructor TfmHistory.Create;
begin
   inherited Create(nil);
   InitCtrls;
end;

procedure TfmHistory.FindCashActions;
var
   adc: TDBCompsAddit;
   id: integer;
   cashAType: integer;
   dt: TDateTime;
   money: double;
begin
   adc := TDBCompsAddit.Create(BASE_PATH);
   if not adc.Init then
   begin
      ShowMessage('�� ������� ���������������� ����������� � ����!');
      Close;
      Exit;
   end;
   with adc.query do
   begin
      SQL.Text := 'SELECT * FROM Cash_actions WHERE dt >= :dt_start AND dt <= :dt_end';
      ParamByName('dt_start').AsDateTime := dtpStart.DateTime;
      ParamByName('dt_end').AsDateTime := dtpEnd.DateTime;
      try
         Open;
      except
         on E: Exception do
         begin
            ShowMessage('Selection statement failed. Cash wont be shown. Error: ' +
               E.Message);
            adc.Destroy;
            Exit;
         end;
      end;
      while not EOF do
      begin
         id := FieldByName('id').AsInteger;
         cashAType := FieldByName('action_type').AsInteger;
         dt := FieldByName('dt').AsDateTime;
         money := FieldByName('cash').AsFloat;
         case cashAType of
            1: AddAction(id, atIncome, dt, money);
            2: AddAction(id, atOutcome, dt, money);
         end;
         Next;
      end;
   end;
   adc.Destroy;
end;

procedure TfmHistory.FindSales;
var
   adc: TDBCompsAddit;
   id: integer;
   cashAType: integer;
   dt: TDateTime;
   money: double;
begin
   adc := TDBCompsAddit.Create(BASE_PATH);
   if not adc.Init then
   begin
      ShowMessage('�� ������� ���������������� ����������� � ����!');
      Close;
      Exit;
   end;
   with adc.query do
   begin
      SQL.Text := 'SELECT s.id, s.dt, s.sale_type, ' +
                  '(SELECT SUM(sg.amount * g.price) FROM SALE_GOODS sg ' +
                  'INNER JOIN GOODS g ON sg.GOOD_ID = g.ID WHERE ' +
                  'sg.SALE_ID = s.id) FROM SALES s WHERE ' +
                  's.dt >= :dt_start AND s.dt <= :dt_end';
      ParamByName('dt_start').AsDateTime := dtpStart.DateTime;
      ParamByName('dt_end').AsDateTime := dtpEnd.DateTime;
      try
         Open;
      except
         on E: Exception do
         begin
            ShowMessage('Selection statement failed. Sales wont be shown. Error: ' +
               E.Message);
            adc.Destroy;
            Exit;
         end;
      end;
      while not EOF do
      begin
         id := Fields[0].AsInteger;
         cashAType := Fields[2].AsInteger;
         dt := Fields[1].AsDateTime;
         money := Fields[3].AsFloat;
         case cashAType of
            0: AddAction(id, atSaleCash, dt, money);
            1: AddAction(id, atSaleCashFree, dt, money);
         end;
         Next;
      end;
   end;
   adc.Destroy;
end;

procedure TfmHistory.FindSessions;
var
   adc: TDBCompsAddit;
   id: integer;
   cashAType: integer;
   dt: TDateTime;
   money: double;
begin
   adc := TDBCompsAddit.Create(BASE_PATH);
   if not adc.Init then
   begin
      ShowMessage('�� ������� ���������������� ����������� � ����!');
      Close;
      Exit;
   end;
   with adc.query do
   begin
      SQL.Text := 'SELECT * FROM SESSIONS WHERE dt_start >= :dt_start AND dt_start <= :dt_end ';
      ParamByName('dt_start').AsDateTime := dtpStart.DateTime;
      ParamByName('dt_end').AsDateTime := dtpEnd.DateTime;
      try
         Open;
      except
         on E: Exception do
         begin
            ShowMessage('Selection statement failed. OpenSess wont be shown. Error: ' +
               E.Message);
            adc.Destroy;
            Exit;
         end;
      end;
      while not EOF do
      begin
         id := Fields[0].AsInteger;
         dt := Fields[1].AsDateTime;
         AddAction(id, atOpenSess, dt, 0);
         Next;
      end;
      Close;
      SQL.Text := 'SELECT * FROM SESSIONS WHERE not dt_end is NULL AND dt_end >= :dt_start AND ' +
                  'dt_end <= :dt_end';
      ParamByName('dt_start').AsDateTime := dtpStart.DateTime;
      ParamByName('dt_end').AsDateTime := dtpEnd.DateTime;
      try
         Open;
      except
         on E: Exception do
         begin
            ShowMessage('Selection statement failed. CloseSess wont be shown. Error: ' +
               E.Message);
            adc.Destroy;
            Exit;
         end;
      end;
      while not EOF do
      begin
         id := Fields[0].AsInteger;
         dt := Fields[2].AsDateTime;
         AddAction(id, atCloseSess, dt, 0);
         Next;
      end;
   end;
   adc.Destroy;
end;

procedure TfmHistory.InitCtrls;
var
   i: integer;
begin
   with sgView do
   begin
      RowCount := 1;
      ColCount := SGVIEW_COL_COUNT;
      for i := 0 to SGVIEW_COL_COUNT - 1 do
      begin
         Cells[i, 0] := SGVIEW_CAPS[i];
         ColWidths[i] := SGVIEW_WIDTHS[i];
      end;
   end;
   dtpStart.DateTime := Date;
   dtpEnd.DateTime := Now;
   for i := 0 to high(ATCaps) do
   begin
      lstActions.Checked[i] := true;
   end;
end;

procedure TfmHistory.sgViewClick(Sender: TObject);
var
   ARow: integer;
begin
   ARow := sgView.Selection.Top;
   if ARow <= 0 then
      exit;
   if (actions[ARow - 1].actionType = atSaleCash) or
      (actions[ARow - 1].actionType = atSaleCashFree) then
      ShowExtInfo(ARow - 1);
end;

procedure TfmHistory.ShowExtInfo(AActionId: integer);
var
   fmExtInfo: TfmExtInfo;
begin
   fmExtInfo := TfmExtInfo.Create(actions[AActionId]);
   fmExtInfo.ShowModal;
   FreeAndNil(fmExtInfo);
end;

procedure TfmHistory.SortActions;
var
   i, j: integer;
   tmpAction: TRAction;
begin
   for i := 0 to high(actions) - 1 do
      for j := i + 1 to High(actions) do
         if actions[i].dt < actions[j].dt then
         begin
            tmpAction := actions[i];
            actions[i] := actions[j];
            actions[j] := tmpAction;
         end;
//         else if (actions[i].dt = actions[i].dt) then

end;

procedure TfmHistory.View;
var
   i: integer;
begin
   with sgView do
   begin
      RowCount := 0;
      for i := 0 to high(actions) do
      begin
         if not lstActions.Checked[Integer(actions[i].actionType)] then
            continue;
         RowCount := RowCount + 1;
         Cells[0, i + 1] := IntToStr(actions[i].id);
         Cells[1, i + 1] := ATCaps[Integer(actions[i].actionType)];
         Cells[2, i + 1] := DateTimeToStr(actions[i].dt);
         Cells[3, i + 1] := PriceToStr(actions[i].money);
      end;
   end;
end;

initialization
   SGVIEW_COL_COUNT := 4;
   setlength(SGVIEW_CAPS, SGVIEW_COL_COUNT);
   setlength(SGVIEW_WIDTHS, SGVIEW_COL_COUNT);
   SGVIEW_CAPS[0] := '��';
   SGVIEW_CAPS[1] := '���';
   SGVIEW_CAPS[2] := '�����';
   SGVIEW_CAPS[3] := '������';
   SGVIEW_WIDTHS[0] := 70;
   SGVIEW_WIDTHS[1] := 200;
   SGVIEW_WIDTHS[2] := 200;
   SGVIEW_WIDTHS[3] := 200;
   SetLength(ATCaps, 6);
   ATCaps[0] := '������� ���';
   ATCaps[1] := '������� �/�';
   ATCaps[2] := '�����';
   ATCaps[3] := '�������';
   ATCaps[4] := '�������� ������';
   ATCaps[5] := '�������� ������';
end.
