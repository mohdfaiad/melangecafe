object fmSaleType: TfmSaleType
  Left = 0
  Top = 0
  Caption = #1054' '#1087#1088#1086#1076#1072#1078#1077
  ClientHeight = 465
  ClientWidth = 541
  Color = clBtnFace
  Constraints.MaxHeight = 504
  Constraints.MaxWidth = 557
  Constraints.MinHeight = 504
  Constraints.MinWidth = 557
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSum: TLabel
    Left = 102
    Top = 13
    Width = 104
    Height = 21
    Caption = #1054#1073#1097#1072#1103' '#1089#1091#1084#1084#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblSeria: TLabel
    Left = 236
    Top = 125
    Width = 60
    Height = 23
    Caption = #1057#1077#1088#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = -6
    Top = 111
    Width = 551
    Height = 1
    Brush.Color = clBackground
  end
  object lblNumber: TLabel
    Left = 45
    Top = 125
    Width = 63
    Height = 23
    Caption = #1053#1086#1084#1077#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblDiscountKey: TLabel
    Left = 44
    Top = 198
    Width = 169
    Height = 23
    Caption = #1055#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1089#1082#1080#1076#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblDiscountSumm: TLabel
    Left = 102
    Top = 65
    Width = 86
    Height = 21
    Caption = #1057#1086' '#1089#1082#1080#1076#1082#1086#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape2: TShape
    Left = -2
    Top = 264
    Width = 551
    Height = 1
    Brush.Color = clBackground
  end
  object btnCash: TButton
    Left = 27
    Top = 280
    Width = 209
    Height = 81
    Caption = #1054#1087#1083#1072#1090#1072' '#1085#1072#1083#1080#1095#1085#1099#1084#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnCashClick
  end
  object btnFree: TButton
    Tag = 3
    Left = 292
    Top = 280
    Width = 209
    Height = 81
    Caption = #1054#1087#1083#1072#1090#1072' '#1082#1072#1088#1090#1086#1095#1082#1086#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnCashClick
  end
  object btnExit: TButton
    Tag = -1
    Left = 27
    Top = 367
    Width = 474
    Height = 81
    Caption = #1054#1058#1052#1045#1053#1040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCashClick
  end
  object edtSeria: TEdit
    Left = 236
    Top = 151
    Width = 65
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = edtSeriaClick
  end
  object edtNumber: TEdit
    Left = 45
    Top = 151
    Width = 185
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = edtNumberClick
  end
  object edtSum: TEdit
    Left = 243
    Top = 8
    Width = 185
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object edtDiscountKey: TEdit
    Left = 44
    Top = 227
    Width = 269
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    OnClick = edtDiscountKeyClick
  end
  object edtDiscountSum: TEdit
    Left = 243
    Top = 60
    Width = 185
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object btnClearDiscount: TButton
    Left = 344
    Top = 151
    Width = 177
    Height = 107
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1082#1080#1076#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnClearDiscountClick
  end
end
