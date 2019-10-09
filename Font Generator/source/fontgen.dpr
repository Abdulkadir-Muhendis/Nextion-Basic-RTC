program fontgen;

uses
  Forms,
  main in 'main.pas' {Form1},
  charset in 'charset.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Nextion font generator v0.3';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
