object Settings: TSettings
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Settings'
  ClientHeight = 461
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sGroupBox1: TsGroupBox
    Left = 0
    Top = 0
    Width = 363
    Height = 161
    Align = alTop
    Caption = #1054#1090#1087#1088#1072#1074#1083#1103#1090#1100' '#1089#1080#1075#1085#1072#1083#1099' '#1085#1072' e-mail'
    TabOrder = 0
    object sLabel1: TsLabel
      Left = 22
      Top = 105
      Width = 62
      Height = 13
      Caption = 'Send Mail to:'
    end
    object CheckMailBTC: TsCheckBox
      Left = 19
      Top = 28
      Width = 64
      Height = 17
      Caption = 'BTSUSD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckMailETH: TsCheckBox
      Left = 19
      Top = 74
      Width = 65
      Height = 17
      Caption = 'ETHUSD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object CheckMailZEC: TsCheckBox
      Left = 19
      Top = 51
      Width = 65
      Height = 17
      Caption = 'ZECUSD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object sEdit1: TsEdit
      Left = 19
      Top = 124
      Width = 121
      Height = 21
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447447
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object sGroupBox2: TsGroupBox
      Left = 160
      Top = 20
      Width = 185
      Height = 133
      Hint = 
        #1042#1086' '#1080#1079#1073#1077#1078#1072#1085#1080#1077' '#1085#1077#1076#1086#1088#1072#1079#1091#1084#1077#1085#1080#1081', '#13#10#1089#1086#1079#1076#1072#1081#1090#1077' '#1085#1086#1074#1091#1102' '#1087#1086#1095#1090#1091', '#13#10#1089' '#1082#1086#1090#1086#1088#1086#1081' ' +
        #1073#1091#1076#1077#1090' '#1080#1076#1090#1080' '#1086#1090#1087#1088#1072#1074#1082#1072' '#1089#1080#1075#1085#1072#1083#1086#1074'!'
      Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' (mail.ru)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      object sLabel2: TsLabel
        Left = 16
        Top = 23
        Width = 25
        Height = 13
        Caption = 'Login'
      end
      object sLabel3: TsLabel
        Left = 16
        Top = 69
        Width = 22
        Height = 13
        Caption = 'Pass'
      end
      object sEdit2: TsEdit
        Left = 16
        Top = 42
        Width = 145
        Height = 21
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 1447447
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object sEdit3: TsEdit
        Left = 16
        Top = 88
        Width = 145
        Height = 21
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 1447447
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
      end
    end
  end
  object sButton2: TsButton
    Left = 0
    Top = 431
    Width = 363
    Height = 30
    Align = alTop
    Caption = 'Ok'
    TabOrder = 1
    OnClick = sButton2Click
  end
  object sPanel1: TsPanel
    Left = 0
    Top = 161
    Width = 363
    Height = 30
    Align = alTop
    TabOrder = 2
    object splay: TsCheckBox
      Left = 23
      Top = 7
      Width = 141
      Height = 17
      Caption = #1042#1086#1089#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1100' '#1079#1074#1091#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 0
      ImgChecked = 0
      ImgUnchecked = 0
    end
    object slogs: TsCheckBox
      Left = 185
      Top = 7
      Width = 128
      Height = 17
      Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1083#1086#1075#1080' '#1094#1077#1085
      Checked = True
      State = cbChecked
      TabOrder = 1
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object sGroupBox3: TsGroupBox
    Left = 0
    Top = 191
    Width = 363
    Height = 105
    Hint = 
      #1042#1086' '#1080#1079#1073#1077#1078#1072#1085#1080#1077' '#1085#1077#1076#1086#1088#1072#1079#1091#1084#1077#1085#1080#1081', '#13#10#1085#1077' '#1074#1089#1090#1072#1074#1083#1103#1081#1090#1077' '#1089#1074#1086#1080' '#1082#1083#1102#1095#1080'!'#13#10#1048#1083#1080' '#1085#1072#1089 +
      #1090#1088#1072#1080#1074#1072#1081#1090#1077' '#1090#1086#1083#1100#1082#1086' '#1085#1072' '#1095#1090#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072'!'
    Align = alTop
    Caption = 'API '#1050#1083#1102#1095#1080' Bitfinex'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    object sLabel4: TsLabel
      Left = 22
      Top = 32
      Width = 48
      Height = 13
      Caption = 'Public Key'
    end
    object sLabel5: TsLabel
      Left = 19
      Top = 72
      Width = 55
      Height = 13
      Caption = 'Private Key'
    end
    object sEdit4: TsEdit
      Left = 88
      Top = 29
      Width = 257
      Height = 21
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447447
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
    end
    object sEdit5: TsEdit
      Left = 88
      Top = 69
      Width = 257
      Height = 21
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447447
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object sGroupBox4: TsGroupBox
    Left = 0
    Top = 296
    Width = 363
    Height = 105
    Hint = 
      #1042#1086' '#1080#1079#1073#1077#1078#1072#1085#1080#1077' '#1085#1077#1076#1086#1088#1072#1079#1091#1084#1077#1085#1080#1081', '#13#10#1085#1077' '#1074#1089#1090#1072#1074#1083#1103#1081#1090#1077' '#1089#1074#1086#1080' '#1082#1083#1102#1095#1080'!'#13#10#1048#1083#1080' '#1085#1072#1089 +
      #1090#1088#1072#1080#1074#1072#1081#1090#1077' '#1090#1086#1083#1100#1082#1086' '#1085#1072' '#1095#1090#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072'!'
    Align = alTop
    Caption = 'API '#1050#1083#1102#1095#1080' Bittrex'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object sLabel6: TsLabel
      Left = 22
      Top = 32
      Width = 48
      Height = 13
      Caption = 'Public Key'
    end
    object sLabel7: TsLabel
      Left = 19
      Top = 72
      Width = 55
      Height = 13
      Caption = 'Private Key'
    end
    object sEdit6: TsEdit
      Left = 88
      Top = 29
      Width = 257
      Height = 21
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447447
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
    end
    object sEdit7: TsEdit
      Left = 88
      Top = 69
      Width = 257
      Height = 21
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447447
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 401
    Width = 363
    Height = 30
    Hint = 
      #1042' '#1075#1083#1072#1074#1085#1086#1081' '#1092#1086#1088#1084#1077' '#1084#1077#1085#1103#1081#1090#1077' '#1094#1077#1085#1091' '#1087#1086#1076' '#1082#1086#1090#1080#1088#1086#1074#1082#1086#1081','#13#10#1090'.'#1086'. '#1087#1086#1085#1103#1090#1100' '#1087#1088#1080#1085#1094#1080 +
      #1087' '#1088#1072#1073#1086#1090#1099' '#1082#1088#1080#1087#1090#1086#1073#1086#1090#1072'.'
    Align = alTop
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    object sLabel8: TsLabel
      Left = 16
      Top = 9
      Width = 110
      Height = 13
      Caption = #1057#1080#1084#1091#1083#1103#1094#1080#1103' '#1094#1077#1085#1099' '#1076#1083#1103':'
    end
    object sComboBox1: TsComboBox
      Left = 224
      Top = 5
      Width = 121
      Height = 21
      Alignment = taLeftJustify
      VerticalAlignment = taAlignTop
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1447447
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 0
      Text = #1085#1077' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100
      Items.Strings = (
        #1085#1077' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100
        'btcusd'
        'zecusd'
        'ethusd')
    end
  end
end
