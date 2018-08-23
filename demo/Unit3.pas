unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sCheckBox,
  sGroupBox, sEdit, sLabel, inifiles, Vcl.ExtCtrls, sPanel, sComboBox;

type
  TSettings = class(TForm)
    sButton2: TsButton;
    CheckMailBTC: TsCheckBox;
    CheckMailZEC: TsCheckBox;
    CheckMailETH: TsCheckBox;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    sEdit1: TsEdit;
    sGroupBox2: TsGroupBox;
    sLabel2: TsLabel;
    sEdit2: TsEdit;
    sLabel3: TsLabel;
    sEdit3: TsEdit;
    sPanel1: TsPanel;
    splay: TsCheckBox;
    slogs: TsCheckBox;
    sGroupBox3: TsGroupBox;
    sGroupBox4: TsGroupBox;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sEdit4: TsEdit;
    sEdit5: TsEdit;
    sLabel6: TsLabel;
    sEdit6: TsEdit;
    sEdit7: TsEdit;
    sLabel7: TsLabel;
    sPanel2: TsPanel;
    sComboBox1: TsComboBox;
    sLabel8: TsLabel;
    procedure sButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Settings: TSettings;
  pathINI:string ;
   sIniFile : TIniFile;



implementation
   uses main;

{$R *.dfm}

procedure TSettings.FormCreate(Sender: TObject);
begin

pathINI:=extractfilepath(application.ExeName)+'\settings.ini';


if FileExists(pathINI) then //проверяем есть ли файл INI
   begin
     sIniFile := TIniFile.Create(pathINI);
     sEdit1.Text:=sIniFile.ReadString('Settings', 'send to mail', '');
     sEdit2.Text:=sIniFile.ReadString('Settings', 'login', '');
     sEdit3.Text:=sIniFile.ReadString('Settings', 'pass', '');


     //spinedit1.Value:=sIniFile.readInteger('Settings', 'SpinVal', 0);
     CheckMailBTC.Checked:=sIniFile.readBool('Settings', 'send btcusd', false);
     CheckMailZEC.Checked:=sIniFile.readBool('Settings', 'send zecusd', false);
     CheckMailETH.Checked:=sIniFile.readBool('Settings', 'send ethusd', false);
     slogs.Checked:=sIniFile.readBool('Settings', 'logs', true);
     splay.Checked:=sIniFile.readBool('Settings', 'playmusic', true);

     sEdit4.Text:=sIniFile.ReadString('Settings', 'keypublick_bitfinex', '');
     sEdit5.Text:=sIniFile.ReadString('Settings', 'keysecret_bitfinex', '');
     sEdit6.Text:=sIniFile.ReadString('Settings', 'keypublick_bittrex', '');
     sEdit7.Text:=sIniFile.ReadString('Settings', 'keysecret_bittrex', '');
     sComboBox1.Text:=sIniFile.ReadString('Settings', 'simulation', 'не использовать');


     sIniFile.Free;
   end
   else
  begin
   sIniFile := TIniFile.Create(pathINI);
   sIniFile.WriteBool('Settings', 'playmusic', true);
   splay.Checked:=true;
   sIniFile.WriteBool('Settings', 'logs', true);
   slogs.Checked:=true;
   sIniFile.Free;
  end;



end;

procedure TSettings.sButton2Click(Sender: TObject);
begin

 if Settings.sComboBox1.Text='не использовать' then  begin
  MainForm.SimulationBTC.Visible:=false;


 end;

 if Settings.sComboBox1.Text='btcusd' then  begin
  MainForm.SimulationBTC.Visible:=true;
   mainform.sPanel2.Caption:='BTCUSD'+#13+MainForm.SimulationBTC.Text;
 end;

  if Settings.sComboBox1.Text='zecusd' then  begin
  MainForm.SimulationBTC.Visible:=false;

 end;

  if Settings.sComboBox1.Text='ethusd' then  begin
  MainForm.SimulationBTC.Visible:=false;

  end;

if (CheckMailBTC.Checked) or (CheckMailZEC.Checked) or (CheckMailETH.Checked) then
begin
  if (sEdit1.Text='') or (sEdit2.Text='') or (sEdit3.Text='') then  begin
  showmessage ('Заполните все поля авторизации и почту на которую отправлять сигналы');
  exit;
  end;

end;



//создаем ссылку на объект INI
  sIniFile := TIniFile.Create(pathINI);

  // запись в INI строки
   sIniFile.WriteString('Settings', 'send to mail', sEdit1.Text);
   sIniFile.WriteString('Settings', 'login', sEdit2.Text);
   sIniFile.WriteString('Settings', 'pass', sEdit3.Text);

   sIniFile.WriteString('Settings', 'keypublick_bitfinex', sEdit4.Text);
   sIniFile.WriteString('Settings', 'keysecret_bitfinex', sEdit5.Text);
   sIniFile.WriteString('Settings', 'keypublick_bittrex', sEdit6.Text);
   sIniFile.WriteString('Settings', 'keysecret_bittrex', sEdit7.Text);


  // запись в INI логического значения boolean
  sIniFile.WriteBool('Settings', 'send btcusd', CheckMailBTC.Checked);
  sIniFile.WriteBool('Settings', 'send zecusd', CheckMailZEC.Checked);
  sIniFile.WriteBool('Settings', 'send ethusd', CheckMailETH.Checked);
  sIniFile.WriteBool('Settings', 'playmusic', splay.Checked);
  sIniFile.WriteBool('Settings', 'logs', slogs.Checked);
  sIniFile.WriteString('Settings', 'simulation', sComboBox1.Text);


  // очистка переменной объекта
  sIniFile.Free;
close;
end;

end.
