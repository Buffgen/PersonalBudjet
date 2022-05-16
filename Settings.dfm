object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1090#1080#1083#1103' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
  ClientHeight = 132
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object PanelSettings: TPanel
    Left = 0
    Top = 0
    Width = 252
    Height = 132
    Align = alClient
    TabOrder = 0
    object LabelUIStyle: TLabel
      Left = 26
      Top = 32
      Width = 195
      Height = 19
      Caption = #1062#1074#1077#1090#1086#1074#1072#1103' '#1089#1093#1077#1084#1072' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
    end
    object ComboBoxUIStyle: TComboBox
      Left = 26
      Top = 57
      Width = 195
      Height = 27
      Style = csDropDownList
      DropDownCount = 15
      TabOrder = 0
      OnChange = ComboBoxUIStyleChange
    end
  end
end
