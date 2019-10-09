unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, ComCtrls, TntExtCtrls, TntStdCtrls, TntGraphics;

const
  UM_MEASUREFONTS = WM_USER;
type
  TForm1 = class(TForm)
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    TrackBar1: TTrackBar;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Edit2: TEdit;
    CheckBox2: TCheckBox;
    Button3: TButton;
    Button1: TButton;
    ComboBox3: TComboBox;
    TntMemo1: TTntMemo;
    Image1: TImage;
    Image2: TImage;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses charset;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
   ComboBox1.Items:=Screen.Fonts;
   ComboBox1.ItemIndex:=0;
   ComboBox2.Items.Clear;
   for i:=12 to 60 do ComboBox2.Items.Add(IntToStr(i));
   ComboBox2.ItemIndex:=0;
   ComboBox1.OnChange(self);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var i,i2,i3: integer;
begin
   Image1.Picture:=nil;
   Image2.Picture:=nil;
   Image2.Canvas.Brush.Color:=clBlack;
   Image2.Canvas.FillRect(Rect(0,0,Image2.Width,Image2.Height));
   Image1.Canvas.Font.Height:=StrToInt(ComboBox2.Text);
   Edit2.Text:=StringReplace(ComboBox1.Text, #32, '', [rfReplaceAll]);
   Edit2.Text:=StringReplace(Edit2.Text, #64, '', [rfReplaceAll])+'_'+ComboBox2.Text;
   if CheckBox1.Checked then
      Image1.Canvas.Font.Style:=Image1.Canvas.Font.Style+[fsBold]
   else
      Image1.Canvas.Font.Style:=Image1.Canvas.Font.style-[fsBold];
   Image1.Canvas.Font.Name:=ComboBox1.Text;
   for i:=0 to TntMemo1.Lines.Count-1 do begin
      WideCanvasTextOut(Image1.Canvas,2,i*Image1.Canvas.TextHeight(TntMemo1.Lines[0])+2,TntMemo1.Lines[i]);
      for i2:=2 to WideCanvasTextWidth(Image1.Canvas,TntMemo1.Lines[i])+2 do
         for i3:=2 to StrToInt(ComboBox2.Text)+2 do
            if (($FF and Image1.Canvas.Pixels[i2,Image1.Canvas.TextHeight(TntMemo1.Lines[i])*i+i3])<TrackBar1.Position) then begin
               Image1.Canvas.Pixels[i2,Image1.Canvas.TextHeight(TntMemo1.Lines[i])*i+i3]:=clBlack;
               Image2.Canvas.Pixels[i2,Image1.Canvas.TextHeight(TntMemo1.Lines[i])*i+i3]:=clWhite;
            end else
               Image1.Canvas.Pixels[i2,Image1.Canvas.TextHeight(TntMemo1.Lines[i])*i+i3]:=clWhite;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.Button3Click(Sender: TObject);
var MaxX,MaxY: Byte;   // Maximum width/height of characters
    x,y: Byte;         // Coordinates to read pixel color
    i,i2,temp: Byte;
    DataSize: LongInt; // Expected filesize
    PosX: Integer;     // Position adjust for center alignment
    CharNum: Byte;     // Number of characters in file (95)
    F: file of Byte;
    Header: array[0..26] of Byte;
begin
   if not(SaveDialog1.Execute) then Exit;
   if FileExists(SaveDialog1.FileName) then
      if MessageDlg('Overwrite existing file?',mtWarning,[mbYes,mbNo],0)=mrNo then Exit;
   CharNum:=95;
   Image1.Picture:=nil;
   Image1.Canvas.Font.Height:=StrToInt(ComboBox2.Text);
   if CheckBox1.Checked then
      Image1.Canvas.Font.Style:=Image1.Canvas.Font.Style+[fsBold]
   else
      Image1.Canvas.Font.Style:=Image1.Canvas.Font.style-[fsBold];
   Image1.Canvas.Font.Name:=ComboBox1.Text;
   MaxX:=0;
   MaxY:=StrToInt(ComboBox2.Text);
   if CheckBox2.Checked then
      for i:=0 to TntMemo1.Lines.Count-1 do begin
         if MaxX<Image1.Canvas.TextWidth(TntMemo1.Lines[i]) then MaxX:=Image1.Canvas.TextWidth(TntMemo1.Lines[i]);
      end
   else
      for i:=1 to CharNum do
         if (MaxX<Image1.Canvas.TextWidth(Form2.EditBoxes[i].Text)) then MaxX:=Image1.Canvas.TextWidth(Form2.EditBoxes[i].Text);
   DataSize:=Ceil(MaxY/8)*MaxX*CharNum+Length(Edit2.Text);
   for i:=0 to 25 do Header[i]:=0;
   AssignFile(F,SaveDialog1.FileName);
   ReWrite(F);
   Header[5]:=MaxX;                             // width of char
   Header[6]:=Ceil(MaxY/8)*8;                   // height of char (multiples of 8)
   Header[11]:=CharNum;                         // number of chars in file (95)
   Header[17]:=Length(Edit2.Text)-1;            // length of font name
   Header[19]:=(DataSize and $000000FF);        // file size
   Header[20]:=(DataSize and $0000FF00) shr 8;
   Header[21]:=(DataSize and $00FF0000) shr 16;
   Header[22]:=(DataSize and $FF000000) shr 24;
   for i:=0 to 26 do Write(F,Header[i]);
   for i:=1 to Length(Edit2.Text) do begin
      temp:=Ord(Edit2.Text[i]);
      Write(F,temp);
   end;
   if CheckBox2.Checked then begin
      //
      // singularity generator
      //
      temp:=0;
      for i:=32 to 64 do
         for x:=0 to (MaxX-1) do
            for y:=0 to (Ceil(MaxY/8)-1) do Write(F,temp);
      for i:=0 to TntMemo1.Lines.Count-1 do begin
         Image1.Picture:=nil;
         Image1.Canvas.Font.Height:=StrToInt(ComboBox2.Text);
         if CheckBox1.Checked then
            Image1.Canvas.Font.Style:=Image1.Canvas.Font.Style+[fsBold]
         else
            Image1.Canvas.Font.Style:=Image1.Canvas.Font.Style-[fsBold];
         Image1.Canvas.Font.Name:=ComboBox1.Text;
         case ComboBox3.ItemIndex of
            0 : PosX:=0;
            1 : PosX:=Round((MaxX-Image1.Canvas.TextWidth(TntMemo1.Lines[i]))/2);
            2 : PosX:=MaxX-Image1.Canvas.TextWidth(TntMemo1.Lines[i]);
         end;
         if PosX<0 then PosX:=0;
         WideCanvasTextOut(Image1.Canvas,0,0,TntMemo1.Lines[i]);
         for x:=0 to (MaxX-1) do
            for y:=0 to (Ceil(MaxY/8)-1) do begin
               temp:=0;
               for i2:=0 to 7 do
                  if (($FF and Image1.Canvas.Pixels[x,(y*8)+i2])<TrackBar1.Position) then temp:=temp+Round(Power(2,(7-i2)));
               Write(F,temp);
            end;
      end;
      for i:=64+TntMemo1.Lines.Count to 95 do
         for x:=0 to (MaxX-1) do
            for y:=0 to (Ceil(MaxY/8)-1) do Write(F,temp);
      CloseFile(F);
   end else begin
      //
      // normal font generator
      //
      for i:=1 to CharNum do begin
         Image1.Picture:=nil;
         Image1.Canvas.Font.Height:=StrToInt(ComboBox2.Text);
         if CheckBox1.Checked then
            Image1.Canvas.Font.Style:=Image1.Canvas.Font.Style+[fsBold]
         else
            Image1.Canvas.Font.Style:=Image1.Canvas.Font.Style-[fsBold];
         Image1.Canvas.Font.name:=ComboBox1.Text;
         PosX:=Floor((MaxX-Image1.Canvas.TextWidth(Form2.EditBoxes[i].Text))/2);
         if (PosX<0) then PosX:=0;
         WideCanvasTextOut(Image1.Canvas,PosX,0,Form2.EditBoxes[i].Text);
         for x:=0 to (MaxX-1) do
            for y:=0 to (Ceil(MaxY/8)-1) do begin
               temp:=0;
               for i2:=0 to 7 do
                  if (($FF and Image1.Canvas.Pixels[x,(y*8)+i2])<TrackBar1.Position) then temp:=temp+Round(Power(2,(7-i2)));
               Write(F,temp);
            end;
      end;
      CloseFile(F);
   end;
   ComboBox1.OnChange(Self);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
    TrackBar1.Hint:=IntToStr(TrackBar1.Position);
    ComboBox1.OnChange(Self);
end;
 
procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
   Form2.Show;
   Form2.SetFocus;
   Form1.Hide;
end;

end.

