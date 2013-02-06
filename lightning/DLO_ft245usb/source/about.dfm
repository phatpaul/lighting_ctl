object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'FT245 DLOP V0.2'
  ClientHeight = 187
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 46
    Width = 68
    Height = 13
    Caption = 'Select Device:'
  end
  object Label2: TLabel
    Left = 214
    Top = 30
    Width = 105
    Height = 13
    Caption = 'phatpaul@yahoo.com'
  end
  object Label3: TLabel
    Left = 11
    Top = 8
    Width = 306
    Height = 16
    Caption = '8 Channel USB Output Plugin for the FTDI Chip FT245'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 241
    Top = 88
    Width = 78
    Height = 13
    Caption = '(Will disconnect)'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 65
    Width = 185
    Height = 21
    ItemHeight = 0
    TabOrder = 0
  end
  object Button1: TButton
    Left = 240
    Top = 134
    Width = 81
    Height = 35
    Caption = 'Apply'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 120
    Width = 185
    Height = 49
    Lines.Strings = (
      'No Device Selected.')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button2: TButton
    Left = 224
    Top = 60
    Width = 97
    Height = 26
    Caption = 'Refresh Devices'
    TabOrder = 3
    OnClick = Button2Click
  end
end
