object fmHistory: TfmHistory
  Left = 0
  Top = 0
  Caption = #1048#1089#1090#1086#1088#1080#1103
  ClientHeight = 469
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilters: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 469
    Align = alLeft
    TabOrder = 0
    object dtpStart: TDateTimePicker
      Left = 16
      Top = 16
      Width = 153
      Height = 25
      Date = 41697.654940914360000000
      Time = 41697.654940914360000000
      TabOrder = 0
    end
    object dtpEnd: TDateTimePicker
      Left = 16
      Top = 47
      Width = 153
      Height = 25
      Date = 41697.655044930560000000
      Time = 41697.655044930560000000
      TabOrder = 1
    end
    object btnView: TButton
      Left = 16
      Top = 409
      Width = 153
      Height = 41
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      TabOrder = 2
      OnClick = btnViewClick
    end
    object lstActions: TCheckListBox
      Left = 16
      Top = 80
      Width = 153
      Height = 241
      ItemHeight = 13
      Items.Strings = (
        #1055#1088#1086#1076#1072#1078#1080' '#1085#1072#1083#1080#1095#1085#1099#1084#1080
        #1055#1088#1086#1076#1072#1078#1080' '#1073#1077#1079#1085#1072#1083
        #1042#1079#1085#1086#1089#1099' '#1074' '#1082#1072#1089#1089#1091
        #1042#1099#1087#1083#1072#1090#1099' '#1080#1079' '#1082#1072#1089#1089#1099
        #1054#1090#1082#1088#1099#1090#1080#1077' '#1089#1077#1089#1089#1080#1081
        #1047#1072#1082#1088#1099#1090#1080#1077' '#1089#1077#1089#1089#1080#1081)
      TabOrder = 3
    end
  end
  object pnlView: TPanel
    Left = 177
    Top = 0
    Width = 556
    Height = 469
    Align = alClient
    TabOrder = 1
    object sgView: TStringGrid
      Left = 1
      Top = 1
      Width = 554
      Height = 467
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 0
      OnClick = sgViewClick
    end
  end
end
