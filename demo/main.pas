unit main;

interface
{$I cef.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ceflib, cefvcl, Buttons, ActnList, Menus, ComCtrls,
  ExtCtrls, XPMan, Registry, ShellApi, SyncObjs, System.Actions, acProgressBar,
  Vcl.Samples.Gauges, Vcl.Samples.Spin, httpsend, IdBaseComponent, IdComponent,  bass,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket, IdCompressorZLib,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, DateUtils, cHash,   math,      mmsystem,
  EncdDecd,   IdHMAC,   idglobal,    IdHash, sSkinManager, sComboBoxes, acMeter, sGauge, sSkinProvider,
  IdCoder, IdCoder3to4, IdCoderMIME, IdMessage, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdAntiFreezeBase, Vcl.IdAntiFreeze,
  sLabel, sGroupBox, sButton, sBitBtn, sMemo, sCheckBox, sPanel, sEdit,
  sSpinEdit, sStatusBar, sRadioButton, Vcl.OleCtrls, SHDocVw, acWebBrowser,
  Vcl.MPlayer;

  //(FormatDateTime('ss:ms', time));

type
  TNewThread = class(TThread)
  private
  //  Progress_btcusd: integer;
    procedure SetProgress;
  protected
    procedure Execute; override;
  end;




type
  TMainForm = class(TForm)
    crm: TChromium;     ActionList: TActionList;       actPrev: TAction;
    actNext: TAction;            actHome: TAction;     actReload: TAction;        actGoTo: TAction;
    MainMenu: TMainMenu;        File1: TMenuItem;    est1: TMenuItem;
    actGetSource: TAction;            actGetText: TAction;         actZoomIn: TAction;       actZoomOut: TAction;
    actZoomReset: TAction;
    actExecuteJS: TAction;       Exit1: TMenuItem;      actDom: TAction;       actDevTool: TAction;
    DevelopperTools1: TMenuItem;     actDoc: TAction;         Help1: TMenuItem;        Documentation1: TMenuItem;
    actGroup: TAction;            Googlegroup1: TMenuItem;     actFileScheme: TAction;           actPrint: TAction;
    TimerTradeVolBTC: TTimer;          PowerBTC: TGauge;       Splitter1: TSplitter;
    TimerPowerBTC: TTimer;      TimerStatusBTC: TTimer;
    IdHTTP1: TIdHTTP;           IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    PampDampBTC: TsMeter;            run: TTimer;
    IdAntiFreeze1: TIdAntiFreeze;     IdSMTP1: TIdSMTP;        IdMessage1: TIdMessage;      IdSSLIOHandlerSocketOpenSSL2: TIdSSLIOHandlerSocketOpenSSL;
    IdEncoderMIME1: TIdEncoderMIME;
    TimerMailBTC: TTimer;
    StatusBTC: TsLabelFX;       sGroupBox1: TsGroupBox;        sGroupBox2: TsGroupBox;          sGroupBox3: TsGroupBox;     sSkinManager1: TsSkinManager;        TradeVolBTC: TGauge;            LogBTC: TsMemo;       Рекомендация: TsLabel;
    sLabel1: TsLabel;     sLabel2: TsLabel;       sPanel1: TsPanel;       START: TsButton;       sPanel2: TsPanel;
    sPanel3demo: TsPanel;     sPanel4: TsPanel;          sButton1: TsButton;       Edit2: TsEdit;     sButton2: TsButton;          Edit1: TsEdit;
    sPanel5: TsPanel;       sPanel6: TsPanel;           sPanel7: TsPanel;          StatusBar: TsStatusBar;         sLabel3: TsLabel;
    sButton3: TsButton;       sRadioButton1: TsRadioButton;            sRadioButton2: TsRadioButton;        sSpinEdit1: TsSpinEdit;
    sLabel4: TsLabel;         sLabel5: TsLabel;            sSpinEdit2: TsSpinEdit;        sButton4: TsButton;          sButton5: TsButton;
    sButton6: TsButton;    sPanel8: TsPanel;                 sPanel9: TsPanel;                 sPanel10: TsPanel;      sSkinProvider1: TsSkinProvider;
    SimulationBTC: TsSpinEdit;
    TimerFreeBass: TTimer;


    procedure FormCreate(Sender: TObject);

    procedure Exit1Click(Sender: TObject);
    procedure crmLoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure crmStatusMessage(Sender: TObject; const browser: ICefBrowser;
      const value: ustring);
    procedure crmDownloadUpdated(Sender: TObject; const browser: ICefBrowser;
      const downloadItem: ICefDownloadItem;
      const callback: ICefDownloadItemCallback);
    procedure TimerTradeVolBTCTimer(Sender: TObject);
    procedure SpinEdit1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinEdit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpinEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);       procedure TimerPowerBTCTimer(Sender: TObject);
    procedure TimerStatusBTCTimer(Sender: TObject);
    procedure runTimer(Sender: TObject);
    procedure TimerMailBTCTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sButton1Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure STARTClick(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure Googlegroup1Click(Sender: TObject);
    procedure Documentation1Click(Sender: TObject);
    procedure DevelopperTools1Click(Sender: TObject);
    procedure SimulationBTCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerFreeBassTimer(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);

  private


  public

  end;



var
  MainForm: TMainForm;


  // btc
  btcusd,  lastbtcusd:real;
  Progress_btcusd, OldStatus_btcusd:integer;   flash_btcusd:real;
  tickStatus_btcusd, stopmailBTC:integer;
  // zec
  zecusd ,lastzecusd:real;
  Progress_zecusd, OldStatus_zecusd:integer;   flash_zecusd:real;
  tickStatus_zecusd, stopmailZEC:integer;
  // eth
  ethusd ,lastethusd:real;
  Progress_ethusd, OldStatus_ethusd:integer;   flash_ethusd:real;
  tickStatus_ethusd, stopmailETH:integer;

  ftime:string;

implementation

 uses other, Unit1, Unit2, Unit3;


{$R *.dfm}


// для компонента TGauge (визуальное изменение - требуется создавать отдельный поток)
procedure TNewThread.Execute;
var
  i: integer;
begin

    application.ProcessMessages;
    try
      MainForm.TradeVolBTC.progress:=round(flash_btcusd);
      Synchronize(SetProgress);
    except

    end;

//  end;
end;

procedure TNewThread.SetProgress;
begin
      application.ProcessMessages;

end;


// получение котировки BTCUSD
procedure CallbackGetText(const txt: ustring);
var
  source: ustring;
  tsource:TStringList;
  str:string;
  str2:string;
// newprice, oldprice:real;
  i:integer;
begin


   application.ProcessMessages;
  tsource:= TStringList.Create;
  tsource.Add   ('0');tsource.Add('0');tsource.Add('0');tsource.Add('0');tsource.Add('0');
  source := txt;
  source := StringReplace(source, '.', ',', [rfReplaceAll]);

  tsource.Clear;
  tsource.Text:=source;

 btcusd:=0;

   str:=tsource.Strings[2];
   if str='1д' then   str:=tsource.Strings[1];


  i:=Pos('R',str);
  str2:=copy (str,1,i-1);
 if lastbtcusd=0 then strtofloat(str2);
 btcusd:= strtofloat(str2);

 mainform.sPanel2.Caption:='BTCUSD'+#13+str2;
 tsource.Free;

end;




procedure TMainForm.TimerStatusBTCTimer(Sender: TObject);

begin


MainForm.StatusBTC.tag:=MainForm.StatusBTC.tag+1;
if MainForm.StatusBTC.tag>=30 then begin
MainForm.StatusBTC.Kind.Color:=clSilver;
//OldStatus:=0;
end;

if MainForm.StatusBTC.tag>=200 then begin
//MainForm.StatusBTC.Kind.Color:=clRed;
MainForm.StatusBTC.Kind.Color:=cllime;
MainForm.StatusBTC.Caption:='Наблюдаем....';
MainForm.StatusBTC.tag:=0;
OldStatus_btcusd:=0;
end;


inc (tickStatus_btcusd);


                      //75-85
if (TradeVolBTC.Progress>=80) and (TradeVolBTC.Progress<=90)  then Begin
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100)<=35)          then begin StatusPrint_Btcus (3);  exit;   end;
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100)in [36..50])          then begin StatusPrint_Btcus (4);  exit;   end;
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100) in [51..98])  then begin StatusPrint_Btcus (5);  exit;   end;
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position -100)>=99)         then begin      StatusPrint_Btcus (16); exit; end;

         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)in [36..50])         then begin StatusPrint_Btcus (6);  exit; end;
         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)in [51..98])  then begin StatusPrint_Btcus (7);  exit; end;
         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)>=99)         then begin     StatusPrint_Btcus (16);  exit; end;

         if (abs(PampDampBTC.Position -100)in [0..17]) then begin        StatusPrint_Btcus (3); exit; end;
         if (abs(PampDampBTC.Position -100)in [18..50]) then begin        StatusPrint_Btcus (4); exit; end;
         if (abs(PampDampBTC.Position -100)in [51..98]) then begin        StatusPrint_Btcus (7); exit; end;
         if (abs(PampDampBTC.Position -100)>=99)        then begin        StatusPrint_Btcus (16); exit; end;

            exit;
                                                         End;
                       //86
if (TradeVolBTC.Progress>=91)  then Begin
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100)<=35)           then begin StatusPrint_Btcus (8);  exit;  end;
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100)in [36..50])          then begin StatusPrint_Btcus (9);  exit;  end;
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100)in [51..98])    then begin    StatusPrint_Btcus (10);  exit;  end;
         if (Progress_btcusd<=9) and (abs(PampDampBTC.Position-100)>=99)           then begin StatusPrint_Btcus (17);  exit;  end;

         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)in [0..35])    then begin        StatusPrint_Btcus (9);  exit;  end;
         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)in [36..50])    then begin        StatusPrint_Btcus (11);  exit;  end;
         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)in [51..98])    then begin        StatusPrint_Btcus (12);  exit;  end;
         if (Progress_btcusd<=35) and (abs(PampDampBTC.Position-100)>=99)           then begin StatusPrint_Btcus (17);  exit;  end;



         if (abs(PampDampBTC.Position-100)in [36..98])   then begin StatusPrint_Btcus (12);  exit;  end;
         if (abs(PampDampBTC.Position-100)>=99)   then begin        StatusPrint_Btcus (17);  exit;  end;
           exit;

                              End;


         if  (abs(PampDampBTC.Position-100) in [35..50])  then begin          StatusPrint_Btcus (1); exit; end;
         if  (abs(PampDampBTC.Position-100) in [51..98])  then begin          StatusPrint_Btcus (2); exit; end;
         if  (abs(PampDampBTC.Position-100)>=99)  then begin                  StatusPrint_Btcus
          (15); exit; end;




if (tickStatus_btcusd>=19*10) {and (MainForm.Status.tag=0) }then  begin  StatusPrint_Btcus (0);
        MainForm.TimerStatusBTC.tag:=0;   // progress:=0;
        end;


end;




procedure TMainForm.crmDownloadUpdated(Sender: TObject;
  const browser: ICefBrowser; const downloadItem: ICefDownloadItem;
  const callback: ICefDownloadItemCallback);
begin
  if downloadItem.IsInProgress then
    StatusBar.SimpleText := IntToStr(downloadItem.PercentComplete) + '%' else
    StatusBar.SimpleText := '';
end;


procedure callback(const str: ustring);
begin
  Application.ProcessMessages;
  end;

procedure TMainForm.crmLoadEnd(Sender: TObject; const browser: ICefBrowser;
  const frame: ICefFrame; httpStatusCode: Integer);

begin


  if (frame <> nil) and (frame.IsMain)  then
 begin
     Application.ProcessMessages;
     sleep (1500);
     Application.ProcessMessages;
     //  'Загрузка котировок завершена';
     crm.Tag:=1;
     Run.Enabled:=true;


  end;
end;



procedure TMainForm.crmStatusMessage(Sender: TObject;
  const browser: ICefBrowser; const value: ustring);
begin
  StatusBar.SimpleText := value
end;

procedure TMainForm.DevelopperTools1Click(Sender: TObject);
begin
Settings.show;
end;

procedure TMainForm.Documentation1Click(Sender: TObject);
begin
help.show;
end;



procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;




procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
logfile ('EXIT','btcusd');
halt;
end;

procedure TMainForm.FormCreate(Sender: TObject);
 var
 BassInfo: BASS_INFO;
 begin

// btc
  flash_btcusd:=0;    btcusd:=0;    lastbtcusd:=0;  stopmailbtc:=0;


 // активация звука
 BASS_Init(1, 44100, BASS_DEVICE_3D, Handle, nil) ;
 BASS_Start;
 BASS_GetInfo(BassInfo);


 // создание папки logs
  CreateDir (ExtractFilePath(Application.ExeName) + 'logs');
  CreateDir (ExtractFilePath(Application.ExeName) + 'logs\btcusd');
  CreateDir (ExtractFilePath(Application.ExeName) + 'logs\zecusd');
  CreateDir (ExtractFilePath(Application.ExeName) + 'logs\ethusd');


end;


procedure TMainForm.Googlegroup1Click(Sender: TObject);
begin
  About.Show;
end;

procedure TMainForm.runTimer(Sender: TObject);
var
  ibtc:integer;
begin
  application.ProcessMessages;
  if  (MainForm.crm.Tag=0)  then exit;


   ibtc:=pos ('...',spanel2.Caption);


try
      if Settings.sComboBox1.Text='не использовать' then  begin
      crm.Browser.MainFrame.GetTextProc(CallbackGetText);

                                                           end;

 if Settings.sComboBox1.Text='btcusd' then  begin

      mainform.sPanel2.Caption:='BTCUSD'+#13+SimulationBTC.Text;

 end;





except

 end;

  if   (ibtc=0)    then
 begin


      StatusBar.SimpleText := 'Загрузка котировок завершена';
      MainMenu.Items[0].Enabled:=true; MainMenu.Items[1].Enabled:=true; MainMenu.Items[2].Enabled:=true;



      //TimerPowerBTC.Enabled:=true;

      START.Enabled:=true;
     if run.Tag=0 then begin
        run.Tag:=1;
        run.Enabled:=false;
        START.Click;

                       end;

 end;



end;

procedure TMainForm.sBitBtn1Click(Sender: TObject);
begin
 TradeVolBTC.Font.Color:=cllime;

end;

procedure TMainForm.sButton1Click(Sender: TObject);
begin
edit2.Text:='';
Bitfinex;
end;

procedure TMainForm.sButton2Click(Sender: TObject);
begin
edit1.Text:='';
 bittrex;
end;

procedure TMainForm.sButton3Click(Sender: TObject);
begin
logfile ('EXIT','btcusd');   logfile ('EXIT','zecusd');   logfile ('EXIT','ethusd');
halt;
end;

procedure TMainForm.sButton4Click(Sender: TObject);
begin
showmessage ('Недоступно в Demo!');
end;

procedure TMainForm.sButton5Click(Sender: TObject);
begin
showmessage ('Недоступно в Demo!');
end;

procedure TMainForm.sButton6Click(Sender: TObject);
begin
showmessage ('Недоступно в Demo!');
end;

procedure TMainForm.SimulationBTCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  Mgs: TMsg;
begin
if key <> vk_return then
exit;


PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);



// only btcusd
btcusd:=SimulationBTC.Value;
MainForm.Caption:='Симуляция изменения цены ('+ floattostr(btcusd)+')';
mainform.sPanel2.Caption:='BTCUSD'+#13+floattostr(btcusd);


end;





procedure TMainForm.SpinEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  Mgs: TMsg;
begin
halt;
if key <> vk_return then
exit;


PeekMessage(Mgs, 0, WM_CHAR, WM_CHAR, PM_REMOVE);



// only btcusd
btcusd:=SimulationBTC.Value;
MainForm.Caption:='Симуляция изменения цены ('+ floattostr(btcusd)+')';
end;

procedure TMainForm.SpinEdit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//SpinEdit1.Value:=SpinEdit1.Value-10;
end;

procedure TMainForm.SpinEdit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
//SpinEdit1.Value:=SpinEdit1.Value+20;
end;

procedure TMainForm.SpinEdit1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//SpinEdit1.Value:=SpinEdit1.Value+10;


end;





procedure TMainForm.STARTClick(Sender: TObject);
var
  NewThread: TNewThread;


  i:integer;

begin

 if Settings.sComboBox1.Text='не использовать' then  begin
  MainForm.SimulationBTC.Visible:=false;

 end;

 if Settings.sComboBox1.Text='btcusd' then  begin
  MainForm.SimulationBTC.Visible:=true;
  mainform.sPanel2.Caption:='BTCUSD'+#13+SimulationBTC.Text;

 end;






if MainForm.START.Caption='Остановить' then
begin
  MainForm.START.Caption:='СТАРТ';  run.Tag:=5;
  logfile ('STOP','btcusd');
  exit;
end;

if (MainForm.START.Caption='СТАРТ') or (MainForm.START.Caption='АВТОСТАРТ') then
begin MainForm.START.Caption:='Остановить';
run.Tag:=9;

  logfile ('START','btcusd');
end;

 MainForm.TimerMailBTC.Enabled:=true;
 //PlaySound(PChar('wavs/notify.wav'),0,SND_ASYNC or SND_NOWAIT);
 if settings.splay.Checked=true then BASS_PlaySoundFile(PChar('mp3/notify.mp3'));
 //exit;



                     START.Tag:=1;
                     StatusBTC.Visible:=true;
                     StatusPrint_Btcus (0);



                     TimerStatusBTC.Enabled:=true;


  // MainForm.Caption:='Робот поиска пампов и дампов v.1.0';

while True do
 Begin

  if run.Tag=5 then
  break;


   application.ProcessMessages;
   sleep (20);


    // обнуляем счетчик


 // BTCUSD
 try

 if settings.sComboBox1.Text<>'btcusd' then
 crm.Browser.MainFrame.GetTextProc(CallbackGetText) else
 if lastbtcusd=0 then    lastbtcusd:=SimulationBTC.value;

 except
  btcusd:=0;
 end;

  if lastbtcusd=0 then begin
  lastbtcusd:=btcusd ;
  addmessage ('BTCUSD='+floattostr(btcusd),false, 'btcusd');
  end;


  // есть изменение цены
  if ( btcusd<>lastbtcusd) and (btcusd<>0) and (lastbtcusd<>0) then  begin


  calculation_btcusd;

  lastbtcusd:= btcusd;

  NewThread:=TNewThread.Create(true);
  NewThread.FreeOnTerminate:=true;
  NewThread.Priority:=tpLower;
  NewThread.Resume;
                                     end;

 End;
end;




procedure TMainForm.TimerPowerBTCTimer(Sender: TObject);
Label go;
var h, l: integer;
begin
  //try
h:=MainForm.PowerBTC.progress;
//l:=MainForm.Gauge4.Height;

if (h>0) and (h>=70) then begin dec (h);  MainForm.PowerBTC.progress:=h-2; goto go; end;
if (h>0) and (h>=35) then begin dec (h);  MainForm.PowerBTC.progress:=h-1; goto go; end;
if (h>0)   then begin dec (h);  MainForm.PowerBTC.progress:=h;   end;


 GO:

if MainForm.PampDampBTC.Position=100 then exit;


if MainForm.PampDampBTC.Position>=175 then begin MainForm.PampDampBTC.Position:=MainForm.PampDampBTC.Position-3; exit; end;
if MainForm.PampDampBTC.Position>=135 then begin MainForm.PampDampBTC.Position:=MainForm.PampDampBTC.Position-2; exit; end;
if MainForm.PampDampBTC.Position>=101 then begin MainForm.PampDampBTC.Position:=MainForm.PampDampBTC.Position-1; exit; end;

if MainForm.PampDampBTC.Position<=25 then begin MainForm.PampDampBTC.Position:=MainForm.PampDampBTC.Position+3; exit; end;
if MainForm.PampDampBTC.Position<=75 then begin MainForm.PampDampBTC.Position:=MainForm.PampDampBTC.Position+2; exit; end;
if MainForm.PampDampBTC.Position<=99 then begin MainForm.PampDampBTC.Position:=MainForm.PampDampBTC.Position+1; exit; end;



end;

procedure TMainForm.TimerTradeVolBTCTimer(Sender: TObject);

begin


flash_btcusd:=flash_btcusd-1;

if flash_btcusd=-1 then flash_btcusd:=0;

 try
MainForm.TradeVolBTC.progress:=round(flash_btcusd);
 except
 end;

end;





procedure TMainForm.TimerFreeBassTimer(Sender: TObject);
       var
 BassInfo: BASS_INFO;
begin
// раз в полчаса освобождаем память после проигрывания звуков, иначе наблюдается утечка памяти
// dll проигрывания mp3 сторонняя, поэтому криворукость не моя
BASS_Free;
sleep (20);
 // и активация звука
 BASS_Init(1, 44100, BASS_DEVICE_3D, Handle, nil) ;
 BASS_Start;
 BASS_GetInfo(BassInfo);

end;

procedure TMainForm.TimerMailBTCTimer(Sender: TObject);
begin

stopmailBTC:=0;

end;



end.

