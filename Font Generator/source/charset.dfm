object Form2: TForm2
  Left = 240
  Top = 214
  Width = 814
  Height = 616
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Nextion font generator v0.3 - Character set editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    798
    578)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 464
    Top = 531
    Width = 99
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 688
    Top = 531
    Width = 99
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 576
    Top = 531
    Width = 99
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = '&Default'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button3Click
  end
end
