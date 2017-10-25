object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 202
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    546
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 546
    Height = 202
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 397
    Top = 8
    Width = 127
    Height = 41
    Anchors = [akTop, akRight]
    Caption = 'TListRandomize Integer'
    TabOrder = 1
    OnClick = Button1Click
  end
  object btnInc: TButton
    Left = 449
    Top = 55
    Width = 75
    Height = 25
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Increment'
    TabOrder = 2
    OnClick = btnIncClick
  end
  object btnEven: TButton
    Left = 449
    Top = 86
    Width = 75
    Height = 25
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Even'
    TabOrder = 3
    OnClick = btnEvenClick
  end
  object btnOdd: TButton
    Left = 449
    Top = 117
    Width = 75
    Height = 25
    Align = alCustom
    Anchors = [akTop, akRight]
    Caption = 'Odd'
    TabOrder = 4
    OnClick = btnOddClick
  end
  object spnSteps: TSpinEdit
    Left = 449
    Top = 148
    Width = 65
    Height = 22
    Anchors = [akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 1
  end
end
