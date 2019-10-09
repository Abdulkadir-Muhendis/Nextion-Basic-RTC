unit charset;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntStdCtrls, StdCtrls, Math, TntRegistry;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    EditBoxes: array[1..95] of TTntEdit;
  end;

var
  Form2: TForm2;

implementation

uses main;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var Labels: TLabel;
    group,i: Integer;
    reg: TTntRegistry;
begin
   reg:=TTntRegistry.Create(KEY_READ);
   reg.RootKey:=HKEY_LOCAL_MACHINE;
   reg.Access:=KEY_ALL_ACCESS;
   reg.OpenKey('Software\Nextion Font Generator\',True);
   group:=20;
   for i:=32 to 126 do begin
      EditBoxes[i-31]:=TTntEdit.Create(Self);
      EditBoxes[i-31].Parent:=Self;
      if not reg.ValueExists('val'+IntToStr(i-31)) then begin
         EditBoxes[i-31].Text:=Chr(i);
         reg.WriteString('val'+IntToStr(i-31),Chr(i));
      end else begin
         EditBoxes[i-31].Text:=reg.ReadString('val'+IntToStr(i-31));
      end;
      EditBoxes[i-31].Left:=Floor((i-32)/group)*160+80;
      EditBoxes[i-31].Top:=((i-32) mod group)*25+20;
      EditBoxes[i-31].Width:=30;
      EditBoxes[i-31].MaxLength:=1;
      Labels:=TLabel.Create(Self);
      if i=32 then Labels.Caption:='Space' else
         if i=38 then Labels.Caption:=Chr(i)+Chr(i) else
            Labels.Caption:=Chr(i);
      Labels.Parent:=Self;
      Labels.Left:=Floor((i-32)/group)*160+40;
      Labels.Top:=((i-32) mod group)*25+23;
   end;
   reg.CloseKey;
   reg.Free;
end;

procedure TForm2.Button1Click(Sender: TObject);
var i: Integer;
    reg: TTntRegistry;
begin
   reg:=TTntRegistry.Create(KEY_READ);
   reg.RootKey:=HKEY_LOCAL_MACHINE;
   reg.Access := KEY_ALL_ACCESS;
   reg.OpenKey('Software\Nextion Font Generator\',True);
   for i:=32 to 126 do reg.WriteString('val'+IntToStr(i-31),EditBoxes[i-31].Text);
   reg.CloseKey;
   reg.Free;
   Form1.Show;
   Form2.Hide;
   Form1.SetFocus;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
   Form1.Show;
   Form2.Hide;
   Form1.SetFocus;
end;

procedure TForm2.Button3Click(Sender: TObject);
var i: Integer;
    reg: TTntRegistry;
begin
   reg:=TTntRegistry.Create(KEY_READ);
   reg.RootKey:=HKEY_LOCAL_MACHINE;
   reg.Access := KEY_ALL_ACCESS;
   reg.OpenKey('Software\Nextion Font Generator\',True);
   for i:=32 to 126 do begin
      reg.WriteString('val'+IntToStr(i-31),Chr(i));
      EditBoxes[i-31].Text:=Chr(i);
   end;
   reg.CloseKey;
   reg.Free;
end;

end.
