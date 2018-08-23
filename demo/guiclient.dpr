program guiclient;

uses
  sysutils,
  ceflib,
  Windows,
  Forms,
  main in 'main.pas' {MainForm},
  Other in 'Other.pas',
  Unit1 in 'Unit1.pas' {About},
  Unit2 in 'Unit2.pas' {Help},
  Unit3 in 'Unit3.pas' {Settings};

{$R *.res}



begin


  //CefRegisterSchemeHandlerFactory('local', '', TFileScheme);


  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAbout, About);
  Application.CreateForm(THelp, Help);
  Application.CreateForm(TSettings, Settings);
  Application.Run;
end.
