object Form1: TForm1
  Left = 192
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Nextion font generator v0.3'
  ClientHeight = 578
  ClientWidth = 798
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnCreate = FormCreate
  DesignSize = (
    798
    578)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 779
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Font Settings  '
    TabOrder = 0
    object ComboBox1: TComboBox
      Left = 8
      Top = 24
      Width = 289
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object ComboBox2: TComboBox
      Left = 312
      Top = 24
      Width = 81
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
      OnChange = ComboBox1Change
    end
    object CheckBox1: TCheckBox
      Left = 408
      Top = 26
      Width = 49
      Height = 17
      Caption = 'Bold'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ComboBox1Change
    end
    object TrackBar1: TTrackBar
      Left = 468
      Top = 25
      Width = 301
      Height = 25
      Hint = '200'
      Max = 255
      Min = 1
      ParentShowHint = False
      Frequency = 20
      Position = 200
      ShowHint = True
      TabOrder = 3
      OnChange = TrackBar1Change
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 72
    Width = 779
    Height = 388
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Preview  '
    TabOrder = 1
    DesignSize = (
      779
      388)
    object Image1: TImage
      Left = 8
      Top = 160
      Width = 763
      Height = 105
      Anchors = [akLeft, akTop, akRight]
    end
    object Image2: TImage
      Left = 8
      Top = 272
      Width = 763
      Height = 105
      Anchors = [akLeft, akTop, akRight]
    end
    object TntMemo1: TTntMemo
      Left = 8
      Top = 24
      Width = 763
      Height = 129
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'Type your sample text here...')
      ParentFont = False
      TabOrder = 0
      OnChange = ComboBox1Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 464
    Width = 779
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Generator  '
    TabOrder = 2
    DesignSize = (
      779
      57)
    object Label1: TLabel
      Left = 8
      Top = 25
      Width = 66
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = 'Font name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit2: TEdit
      Left = 104
      Top = 20
      Width = 169
      Height = 24
      Anchors = [akLeft, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Edit2'
    end
    object CheckBox2: TCheckBox
      Left = 288
      Top = 24
      Width = 153
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Singularity generator'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object Button3: TButton
      Left = 674
      Top = 14
      Width = 97
      Height = 35
      Anchors = [akRight, akBottom]
      Caption = '&Generate'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button3Click
    end
    object ComboBox3: TComboBox
      Left = 448
      Top = 20
      Width = 105
      Height = 24
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Left align'
      Items.Strings = (
        'Left align'
        'Center align'
        'Right align')
    end
  end
  object Button1: TButton
    Left = 688
    Top = 531
    Width = 99
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = '&Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 531
    Width = 121
    Height = 35
    Caption = 'Edit &character set'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'zi'
    Filter = 'Font file|*.zi'
    Left = 648
    Top = 536
  end
end
