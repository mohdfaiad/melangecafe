object fmIngredientCard: TfmIngredientCard
  Left = 0
  Top = 0
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090#1072
  ClientHeight = 549
  ClientWidth = 762
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBtns: TPanel
    Left = 0
    Top = 479
    Width = 762
    Height = 70
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 465
    object btnSave: TButton
      Left = 10
      Top = 10
      Width = 128
      Height = 49
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 162
      Top = 10
      Width = 128
      Height = 49
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pnlIngredientInfo: TPanel
    Left = 0
    Top = 0
    Width = 762
    Height = 97
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -24
    ExplicitTop = -1
    object lbMeasure: TLabel
      Left = 331
      Top = 4
      Width = 147
      Height = 19
      Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbMeasure: TComboBox
      Left = 331
      Top = 29
      Width = 278
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object leCaption: TLabeledEdit
      Left = 18
      Top = 29
      Width = 295
      Height = 27
      EditLabel.Width = 68
      EditLabel.Height = 19
      EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = leCaptionClick
    end
  end
  object pnlRecipe: TPanel
    Left = 0
    Top = 97
    Width = 762
    Height = 382
    Align = alClient
    TabOrder = 2
    ExplicitLeft = -139
    object pnlRecipeBtns: TPanel
      Left = 625
      Top = 1
      Width = 136
      Height = 380
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnRecipeCreate: TButton
        Left = 6
        Top = 4
        Width = 122
        Height = 103
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        WordWrap = True
        OnClick = btnRecipeCreateClick
      end
      object btnRecipeDelete: TButton
        Left = 6
        Top = 220
        Width = 122
        Height = 103
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        WordWrap = True
        OnClick = btnRecipeDeleteClick
      end
      object btnRecipeEdit: TButton
        Left = 6
        Top = 113
        Width = 122
        Height = 103
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1080#1085#1075#1088#1077#1076#1080#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        WordWrap = True
        OnClick = btnRecipeEditClick
      end
    end
    object sgRecipes: TStringGrid
      Left = 1
      Top = 1
      Width = 624
      Height = 380
      Align = alClient
      ColCount = 4
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      TabOrder = 1
    end
  end
end
