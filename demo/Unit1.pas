unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, sButton;

type
  TAbout = class(TForm)
    sButton1: TsButton;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sWebLabel1: TsWebLabel;
    sWebLabel2: TsWebLabel;
    sLabelFX1: TsLabelFX;
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation

{$R *.dfm}

procedure TAbout.sButton1Click(Sender: TObject);
begin
close;
end;

end.
