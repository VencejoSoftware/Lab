object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 145
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 48
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 1
  end
  object SpinEdit1: TSpinEdit
    Left = 32
    Top = 71
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object SaveButton: TButton
    Left = 94
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 3
    OnClick = SaveButtonClick
  end
  object LoadButton: TButton
    Left = 13
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = LoadButtonClick
  end
end
