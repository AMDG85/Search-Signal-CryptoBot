unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, sRichEdit,
  sButton;

type
  THelp = class(TForm)
    sButton1: TsButton;
    sRichEdit1: TsRichEdit;
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Help: THelp;

implementation

{$R *.dfm}

procedure THelp.sButton1Click(Sender: TObject);
begin
close;
end;

end.
