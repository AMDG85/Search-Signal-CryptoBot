unit Other;




interface

uses    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ceflib, cefvcl, Buttons, ActnList, Menus, ComCtrls, bass,
  ExtCtrls, XPMan, Registry, ShellApi, SyncObjs, System.Actions, acProgressBar,
  Vcl.Samples.Gauges, Vcl.Samples.Spin, httpsend, IdBaseComponent, IdComponent,mmsystem,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket, IdCompressorZLib,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, DateUtils, cHash,   math,
  EncdDecd,   IdHMAC,   idglobal,    IdHash, sSkinManager, sComboBoxes, acMeter, sGauge, sSkinProvider,
  IdCoder, IdCoder3to4, IdCoderMIME, IdMessage, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdAntiFreezeBase, Vcl.IdAntiFreeze ,

  idAttachment,IdAttachmentFile  ;

 // ������� � ������� �����
procedure mail (str:integer; text, para:string);
function addmessage (s:string; pokazateli:bool; para:string):string;
function EncodeBase64(const inStr: string): string;
function StrToHex(source: string): string;
function balance (Response:string; birga:string):string;
function ponigenie (str,OldStatusFunction:integer):Boolean;
procedure AsyncBeep(freq,duration: integer);
Procedure StatusPrint_Btcus (str:integer);
procedure calculation_btcusd;
procedure logfile (str, para:string);
function BASS_PlaySoundFile(const FileName: string): Boolean;
procedure Bitfinex({str1,str2: string});
procedure Bittrex({str1,str2: string});

  type
 TChannelType = (ctUnknown, ctStream, ctMusic);


 var    Channel: DWORD;
 ChannelType: TChannelType;


implementation

uses main, Unit3;

function BASS_PlaySoundFile(const FileName: string): Boolean;
 var
 ChannelInfo: BASS_CHANNELINFO;
 begin
 Result:= False;
 Channel:= BASS_StreamCreateFile(False, PAnsiChar(AnsiString(FileName)), 0, 0, 0);
 if (Channel <> 0) then
 ChannelType:= ctStream;
 if (Channel <> 0) then
 begin
 BASS_ChannelPlay(Channel, False);
 end;
 Result:= Channel <> 0;
 end;

function EncodeBase64(const inStr: string): string;

  function Encode_Byte(b: Byte): ansichar;
  const
    Base64Code: string[64] =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  begin
    Result := Base64Code[(b and $3F)+1];
  end;

var
  i: Integer;
begin
  i := 1;
  Result := '';
  while i <=Length(InStr) do
  begin
    Result := Result + Encode_Byte(Byte(inStr[i]) shr 2);
    Result := Result + Encode_Byte((Byte(inStr[i]) shl 4) or (Byte(inStr[i+1]) shr 4));
    if i+1 <=Length(inStr) then
      Result := Result + Encode_Byte((Byte(inStr[i+1]) shl 2) or (Byte(inStr[i+2]) shr 6))
    else
      Result := Result + '=';
    if i+2 <=Length(inStr) then
      Result := Result + Encode_Byte(Byte(inStr[i+2]))
    else
      Result := Result + '=';
    Inc(i, 3);
  end;
end;

procedure AsyncBeepThread(fd: dword); stdcall;
begin
  Windows.Beep(loword(fd),hiword(fd));
end;

procedure logfile (str, para:string);
var
  F : TextFile;
  FileName : String;
  dt:string;
  tt:string;
begin

DateTimeToString(tt, 'hh:mm:ss', time);
tt:= tt+ ' | ';

if para='btcusd' then
 mainform.LogBTC.lines.add (tt+str);


if settings.slogs.Checked=false then
   exit;

   dt:= FormatDateTime('dd.mm.yy', Now);

  FileName := ExtractFilePath(Application.ExeName) + 'logs\'+para+'\'+dt+'.txt';
  AssignFile(F, FileName);
  if FileExists(FileName) then
    Append(F)
  else
    Rewrite(F);
  WriteLn(F, tt +str );
  CloseFile(F);


end;


procedure BitfinexBalance({fd: dword}); stdcall;
var PostList:TStringStream;
Response:variant;
nonce, key, secret, Payload, sign, url,payload2, request,resul:string;
begin


key:=Settings.sEdit4.Text;
secret:=Settings.sEdit5.Text;
nonce:=inttostr(DateTimeToUnix(now)*10000);

  PostList := TStringStream.Create;
  mainform.IdHttp1 := TIdHttp.Create();


  mainform.IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create();
  mainform.IdHttp1.IOHandler := mainform.IdSSLIOHandlerSocketOpenSSL1;
  mainform.Idhttp1.HTTPOptions := [hoKeepOrigProtocol,hoForceEncodeParams{,hoWantProtocolErrorContent}];
  mainform.Idhttp1.ProtocolVersion := pv1_1;
  mainform.Idhttp1.Request.UserAgent := 'Go-http-client/1.1';
  mainform.Idhttp1.Request.ContentType := 'application/json';
  mainform.Idhttp1.Request.Accept := 'application/json';
  mainform.Idhttp1.Request.AcceptEncoding := 'gzip, identity;q=0';
  mainform.IdHttp1.Compressor := TIdCompressorZLib.Create(mainform.IdHttp1);

 url:='https://api.bitfinex.com/';
 request:='/v1/balances';

 payload:='{"nonce":"'+nonce+'","request":"'+request+'"}';
 payload := EncodeBase64(payload);

   addmessage ('������ �� ����� bitfinex �������', false, 'btcusd');

     try

     // � �� ���� ����� �� Delphi ������� ����������� SHA384
     // ��� ���� ��������� � �������� API �� ����� bitfinex =
     // "The signature is the hex digest of an HMAC-SHA384 hash where the message is your payload, and the secret key is your API secret."

      // � ������ ������ ��� ����!
      // � ����� ������ �� ���� ����, ��� ������� ����� ���������� php ������� hash_hmac("sha384", $hash, $secret)  ;
      // � ����� �����
      // ��� � ���� X-Bfx-Signature
      // � ��� �����, ��� �� �� ���� �������!
      // ����� ���������� �� ��� ���� ���� secret  = >> ������� ����� ���� ����, :

                                        /// www.������.���
     Response := mainform.Idhttp1.post('http://xn--c1adbq6ae.xn--90ais/hash.php?hash='+payload+'&secretkey='+secret, PostList);
    except
      on E: EIdHTTPProtocolException do
      begin
logfile (E.Message,'btcusd');
logfile (E.ErrorMessage,'btcusd');

 logfile ('Hash �� �������.','btcusd');
 mainform.edit2.Text:='';
 exit;

      end;
      on E: Exception do
      begin
      end;
    end;



  sign:= Response;



  mainform.Idhttp1.Request.CustomHeaders.Values['X-Bfx-Apikey'] := key;
  mainform.Idhttp1.Request.CustomHeaders.Values['X-Bfx-Payload'] := payload;//payload;
  mainform.Idhttp1.Request.CustomHeaders.Values['X-Bfx-Signature'] :=sign; //sign;

   try
Response := mainform.Idhttp1.post(url+request, PostList);
    except
      on E: EIdHTTPProtocolException do
      begin
logfile (E.Message,'btcusd');
logfile (E.ErrorMessage,'btcusd');
logfile ('����� ����� ���������','btcusd');    mainform.edit2.Text:='';
 exit;

      end;
      on E: Exception do
      begin

logfile (E.Message,'btcusd');
      end;
    end;


   mainform.edit2.Text:= balance (Response, 'bitfinex');


end;

procedure Bitfinex({str1,str2: string});
var
  thread: THandle;
  tid: dword;
begin

  thread := CreateThread(nil, 0, @BitfinexBalance, 0, 0, tid);
end;


procedure BittrexBalance({fd: dword}); stdcall;
var PostList:TStringStream;
Response:variant;
nonce, key, secret, Payload, sign, url:string;
begin

key:=Settings.sEdit6.Text;
secret:=Settings.sEdit7.Text;
nonce:=inttostr(DateTimeToUnix(now));

  PostList := TStringStream.Create;
  mainform.IdHttp1 := TIdHttp.Create();

  mainform.IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create();
  mainform.IdHttp1.IOHandler := mainform.IdSSLIOHandlerSocketOpenSSL1;
  mainform.Idhttp1.HTTPOptions := [hoKeepOrigProtocol,hoForceEncodeParams];
  mainform.Idhttp1.ProtocolVersion := pv1_1;
  mainform.Idhttp1.Request.UserAgent := 'Go-http-client/1.1';
  mainform.Idhttp1.Request.ContentType := 'application/json';
  mainform.Idhttp1.Request.Accept := 'application/json';

 url:='https://bittrex.com/api/v1.1/account/getbalances?apikey='+key+'&nonce='+nonce;
 sign:=SHA512DigestToHex(CalcHMAC_SHA512(secret, url));


  addmessage ('������ �� ����� bittrex �������', false, 'btcusd');
  mainform.Idhttp1.Request.CustomHeaders.Values['apisign'] := sign;


try
Response := mainform.Idhttp1.Post(url, PostList);
    except
      on E: EIdHTTPProtocolException do
      begin
       logfile (E.Message,'btcusd');
       logfile (E.ErrorMessage,'btcusd');
       logfile ('����� ����� ���������','btcusd');

 exit;

      end;
      on E: Exception do
      begin
      end;
    end;



 if AnsiPos('INVALID', Response)<>0  then begin  logfile ('�������� ������','btcusd');
 exit;
  end;
      balance (Response, 'bittrex');
end;


procedure Bittrex({str1,str2: string});
var
  thread: THandle;
  tid: dword;
begin

  thread := CreateThread(nil, 0, @BittrexBalance, 0, 0, tid);
end;



procedure AsyncBeep(freq,duration: integer);
var
  thread: THandle;
  tid: dword;
  fd: dword;
begin
  fd := freq or (duration shl 16);
  thread := CreateThread(nil, 0, @AsyncBeepThread, pointer(fd), 0, tid);
end;


function StrToHex(source: string): string;
var
  i: Integer;
  c: Char;
  s: string;
begin
  s := '';
  for i:=1 to Length(source) do begin
    c := source[i];
    s := s +  IntToHex(Integer(c), 2) + ' ';
  end;
  result := s;
end;

function RDTSC: Int64; register;    asm    rdtsc  end;

function addmessage (s:string; pokazateli:bool; para:string):string;
var cena:string;
begin

if para='btcusd' then    Begin

         if pokazateli=false then  begin

            logfile ( s,'btcusd');

                                   end  else
                                   begin

            if MainForm.PowerBTC.Progress>0 then
            cena:=inttostr(MainForm.PowerBTC.Progress)+'%';
            if MainForm.PampDampBTC.Position>=199 then cena:='����! +'+inttostr(abs(MainForm.PampDampBTC.Position-100))+'%';
            if MainForm.PampDampBTC.Position<=1 then cena:='����! -'+inttostr(abs(MainForm.PampDampBTC.Position-100))+'%';

            if MainForm.PowerBTC.ForeColor=clRed then cena:='������� '+inttostr(MainForm.PowerBTC.Progress)+'%';
            if (MainForm.PowerBTC.Progress=0) {and (MainForm.Gauge3.Progress=0) }
            then cena:='0%';
            logfile ( s+' || ����������: ����� ������: '+inttostr(MainForm.TradeVolBTC.Progress)+'%, ����� last ������: '+cena+', ����/����: '+inttostr(abs(MainForm.PampDampBTC.Position-100))+'%' ,'btcusd');
                 //MainForm.Caption:='����� ������ ������ � ������'+' || ����������: ����� ������: '+inttostr(MainForm.TradeVolBTC.Progress)+'%, ����� last ������: '+cena+', ����/����: '+inttostr(abs(MainForm.PampDampBTC.Position-100))+'%';
                                   end;
                         End;

end;

function balance (Response:string; birga:string):string;
var str, str1, str2, result2, bitfinexUSD , bitfinexETH, bitfinexZEC, bittrexUSD , bittrexETH, bittrexZEC:string;
    pos, pos1,pos2:integer;
    res:real;
begin

if  birga='bitfinex' then   Begin


   pos:= AnsiPos('"type":"trading","currency":"usd","amount":"', Response);
   if pos=0 then begin addmessage ('�������� ����� �� �����',false, 'btcusd'); exit;  end;

   pos:=pos+ 44;
   str:=copy (Response,pos,30);
   pos1:= AnsiPos('"', str);
   str:=copy (Response,pos,pos1-1);
   str:=StringReplace(str, '.', ',',  [rfReplaceAll, rfIgnoreCase] );
   str:=floattostr(RoundTo(strtofloat(str), -2));
   bitfinexUSD:=str;

pos:= AnsiPos('"type":"trading","currency":"zec","amount":"', Response);
   pos:=pos+ 44;
   str:=copy (Response,pos,30);
   pos1:= AnsiPos('"', str);
   str:=copy (Response,pos,pos1-1);
   str:=StringReplace(str, '.', ',',  [rfReplaceAll, rfIgnoreCase] );
   str:=floattostr(RoundTo(strtofloat(str), -2));
   bitfinexZEC:=str;

pos:= AnsiPos('"type":"trading","currency":"eth","amount":"', Response);
   pos:=pos+ 44;
   str:=copy (Response,pos,30);
   pos1:= AnsiPos('"', str);
   str:=copy (Response,pos,pos1-1);
   str:=StringReplace(str, '.', ',',  [rfReplaceAll, rfIgnoreCase] );
   str:=floattostr(RoundTo(strtofloat(str), -2));
   bitfinexETH:=str;


   result:='USD='+bitfinexUSD+'; '+'ZEC='+bitfinexZEC+'; '+'ETH='+bitfinexETH+';';
                           End;

if  birga='bittrex' then   Begin

  // MainForm.memo2.Lines.Clear;

   // eth
   pos:= AnsiPos('ETH","Balance":', Response);
   if pos=0 then begin addmessage ('�������� ����� �� �����',false, 'btcusd'); exit;  end;
   pos:=pos+ 15;
   str:=copy (Response,pos,30);
   pos1:= AnsiPos(',', str);
   str:=copy (Response,pos,pos1-1);
   str:=StringReplace(str, '.', ',',  [rfReplaceAll, rfIgnoreCase] );
   str:=floattostr(RoundTo(strtofloat(str), -4));
   bittrexETH:=str;

         // zec
   pos:= AnsiPos('ZEC","Balance":', Response);
   pos:=pos+ 16;
   str:=copy (Response,pos,30);
   pos1:= AnsiPos(',', str);
   str:=copy (Response,pos,pos1-1);
   str:=StringReplace(str, '.', ',',  [rfReplaceAll, rfIgnoreCase] );
   str:=floattostr(RoundTo(strtofloat(str), -2));
   bittrexZEC:=str;

      // ustd
   pos:= AnsiPos('USDT","Balance":', Response);
   pos:=pos+ 16;
   str:=copy (Response,pos,30);
   pos1:= AnsiPos(',', str);
   str:=copy (Response,pos,pos1-1);
   str:=StringReplace(str, '.', ',',  [rfReplaceAll, rfIgnoreCase] );
   str:=floattostr(RoundTo(strtofloat(str), -2));
   bittrexUSD:=str;
   //MainForm.edit1.text:=MainForm.edit1.text+('; USDT='+str);

   MainForm.edit1.text:='USDT='+bittrexUSD+'; '+'ZEC='+bittrexZEC+'; '+'ETH='+bittrexETH+';';


                           End;

end;

  // ���� �� ������� ���� ���������� ���������, ���������� �� ������ ��� ���������
  function ponigenie (str,OldStatusFunction:integer):Boolean;
  begin
  result:=false;
  if str<=OldStatusFunction   then  begin

  result:=true;
  end;

    sleep (10);

  end;



Procedure StatusPrint_Btcus (str:integer);
begin

MainForm.TimerStatusBTC.tag:=1;
tickStatus_btcusd:=0;


if  ( {��������� �������} ponigenie(str,OldStatus_btcusd) = true)  then
begin

  exit;
 end;


MainForm.StatusBTC.Kind.Color:=cllime;
MainForm.StatusBTC.tag:=0;

 OldStatus_btcusd:=str;
 Progress_btcusd:=0;

  if str=1 then  begin addmessage ('����� ������ �������� ��� ����������� ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='����� ������ �������� ��� ����������� ������������ ����'+'='+inttostr(str);
  if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;

  if str=2 then  begin addmessage ('����� ������ �������� ��� ������ ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='����� ������ �������� ��� ������ ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;
  //==
  if str=3 then  begin addmessage ('������� ������ �������� ��� ���������� ��������� ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='������� ������ �������� ��� ���������� ��������� ����'+'='+inttostr(str);
  if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;

  if str=4 then  begin addmessage ('������� ������ �������� ��� ����������� ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='������� ������ �������� ��� ����������� ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;

  if str=5 then  begin  addmessage ('������� ������ �������� ��� ������ ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='������� ������ �������� ��� ������ ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd'); end;

  //==

  if str=6 then   begin  addmessage ('������� ������ �������� ��� ������ � ����������� ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='������� ������ �������� ��� ������ � ����������� ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd'); end;

  if str=7 then   begin  addmessage ('������� ������ �������� ��� ������ � ������ ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='������� ������ �������� ��� ������ � ������ ������������ ����'+'='+inttostr(str);if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;
 //==
  if str=8 then  begin addmessage ('���������� ������ �������� ��� ���������� ��������� ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='���������� ������ �������� ��� ���������� ��������� ����'+'='+inttostr(str);
  if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;

  if str=9 then  begin addmessage ('���������� ������ �������� ��� ����������� ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='���������� ������ �������� ��� ����������� ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;

  if str=10 then  begin
  addmessage ('���������� ������ �������� ��� ������ ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='���������� ������ �������� ��� ������ ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd'); end;
 //==
  if str=11 then   begin
  addmessage ('���������� ������ �������� ��� ������ � ����������� ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='���������� ������ �������� ��� ������ � ����������� ������������ ����'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd'); end;

  if str=12 then   begin
  addmessage ('���������� ������ �������� ��� ������ � ������ ������������ ����'+'='+inttostr(str),true, 'btcusd');
  MainForm.StatusBTC.Caption:='���������� ������ �������� ��� ������ � ������ ������������ ����'+'='+inttostr(str);if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');  end;


 if str=15 then
 Begin

    if MainForm.PampDampBTC.position>=199 then
                begin  addmessage ('���� �� ����� �������!'+'='+inttostr(str) ,true, 'btcusd');
                       MainForm.StatusBTC.Caption:='���� �� ����� �������!'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');
                end;

    if MainForm.PampDampBTC.position<=1 then
                begin  addmessage ('���� �� ����� �������!'+'='+inttostr(str) ,true, 'btcusd');
                       MainForm.StatusBTC.Caption:='���� �� ����� �������!'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');
                end;

 End;
 if str=16 then
 Begin

    if MainForm.PampDampBTC.position>=199 then
                begin  addmessage ('���� �� ������� �������!'+'='+inttostr(str) ,true, 'btcusd');

                       MainForm.StatusBTC.Caption:='���� �� ������� �������!'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');
                end;

    if MainForm.PampDampBTC.position<=1 then
                begin  addmessage ('���� �� ������� �������!'+'='+inttostr(str) ,true, 'btcusd');
                       MainForm.StatusBTC.Caption:='���� �� ������� �������!'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');
                end;

 End;

 if str=17 then
 Begin

    if MainForm.PampDampBTC.position>=199 then
                begin  addmessage ('���� �� ���������� �������!'+'='+inttostr(str) ,true, 'btcusd');
                       MainForm.StatusBTC.Caption:='���� �� ���������� �������!'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');
                end;

    if MainForm.PampDampBTC.position<=1 then
                begin  addmessage ('���� �� ���������� �������!'+'='+inttostr(str) ,true, 'btcusd');
                       MainForm.StatusBTC.Caption:='���� �� ���������� �������!'+'='+inttostr(str); if Settings.CheckMailBTC.Checked then mail (str, MainForm.StatusBTC.Caption, 'btcusd');
                end;
 End;


  if str=0 then  begin MainForm.TimerStatusBTC.tag:=0;
  MainForm.StatusBTC.Caption:='���������...';
 // addmessage ('���������...',true, 'btcusd');

  End;



// if str in [3..17] then AsyncBeep(2000,800);
 if settings.splay.Checked=true then
 if str in [1..1] then {PlaySound(PChar('wavs/1.wav'),0,SND_ASYNC or SND_NOWAIT); }  BASS_PlaySoundFile(PChar('mp3/1.mp3'));
 if str in [2..4] then {PlaySound(PChar('wavs/234.wav'),0,SND_ASYNC or SND_NOWAIT); } BASS_PlaySoundFile(PChar('mp3/234.mp3'));
 if str in [5..6] then {PlaySound(PChar('wavs/56.wav'),0,SND_ASYNC or SND_NOWAIT); }  BASS_PlaySoundFile(PChar('mp3/56.mp3'));
 if str in [7..9] then {PlaySound(PChar('wavs/789.wav'),0,SND_ASYNC or SND_NOWAIT); } BASS_PlaySoundFile(PChar('mp3/789.mp3'));
 if str in [10..12] then {PlaySound(PChar('wavs/101112.wav'),0,SND_ASYNC or SND_NOWAIT);} BASS_PlaySoundFile(PChar('mp3/101112.mp3'));
 if str in [15..17] then {PlaySound(PChar('wavs/151617.wav'),0,SND_ASYNC or SND_NOWAIT);} BASS_PlaySoundFile(PChar('mp3/151617.mp3'));


 str:=0;

end;





procedure calculation_btcusd;
var
izmenenie,izmeneniem, izmenenief:real;

begin



addmessage ('BTCUSD='+floattostr(btcusd),false, 'btcusd');

           // ��� ������ ��������
  flash_btcusd:=flash_btcusd+9;  if flash_btcusd>=101 then flash_btcusd:=100;
  case round(flash_btcusd) of
  0..10:  flash_btcusd:=flash_btcusd+9;
  11..20: flash_btcusd:=flash_btcusd+7;
  21..30: flash_btcusd:=flash_btcusd+5;
  end;

 if btcusd>lastbtcusd then mainform.sPanel2.SkinData.ColorTone:=cllime;
 if btcusd<lastbtcusd then mainform.sPanel2.SkinData.ColorTone:=clred;



izmenenie:=btcusd/lastbtcusd;

//progress:=0;
try

Progress_btcusd:= MainForm.PowerBTC.Progress;
 except

end;


//  ��������� ���� ������������ ���������� � �������������� ����
if izmenenie>1 then begin
              // �����

              MainForm.PowerBTC.ForeColor:=clLime;
              MainForm.PowerBTC.Progress:=round(    ((izmenenie-1)*100/1*100)    );
              Progress_btcusd:=MainForm.PowerBTC.Progress;



           MainForm.PampDampBTC.Position:= MainForm.PampDampBTC.Position+ abs(round(    ((izmenenie-1)*100/1*100)    ));
           MainForm.PampDampBTC.PaintData.ArrowColor:=clLime;

end;

if izmenenie<1 then begin
              // ����

              MainForm.PowerBTC.ForeColor:=clRed;
              MainForm.PowerBTC.Progress:=round(    ((1-izmenenie)*100/1*100)    );      /// ���� 3
              Progress_btcusd:=MainForm.PowerBTC.Progress;



           MainForm.PampDampBTC.Position:=  MainForm.PampDampBTC.Position- abs(round(    ((izmenenie-1)*100/1*100)    ));
           MainForm.PampDampBTC.PaintData.ArrowColor:=clRed;

end;

  end;


procedure mail (str:integer; text, para:string);
var


msg:TIdMessage;

IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
i:integer; cena:string;
begin


 if  (str<=3) or (str=8) then exit;


 if (para='btcusd') and (stopmailBTC=1) then exit;
 if (para='btcusd') and (stopmailBTC=0) then stopmailBTC:=1;

 if (para='zecusd') and (stopmailZEC=1) then exit;
 if (para='zecusd') and (stopmailZEC=0) then stopmailZEC:=1;

 if (para='ethusd') and (stopmailETH=1) then exit;
 if (para='ethusd') and (stopmailETH=0) then stopmailETH:=1;



// �����������
MainForm.IdSMTP1.Host:='smtp.mail.ru';

// exit;
MainForm.IdSMTP1.Port:=465; // ������ ��� ������������� ssl 495, 587 ��� ����������� 25
MainForm.IdSMTP1.Username:=settings.sedit2.text;// �����  �����
MainForm.IdSMTP1.Password:=settings.sedit3.text; //������ ��  ����� � �������� ��� ������
MainForm.IdSMTP1.AuthType:=satDefault;

IdSSLIOHandlerSocketOpenSSL:= TIdSSLIOHandlerSocketOpenSSL.Create(nil);
IdSSLIOHandlerSocketOpenSSL.Destination := MainForm.IdSMTP1.Host+':'+IntToStr(MainForm.IdSMTP1.Port);
IdSSLIOHandlerSocketOpenSSL.Host := MainForm.IdSMTP1.Host;
IdSSLIOHandlerSocketOpenSSL.Port := MainForm.IdSMTP1.Port;
IdSSLIOHandlerSocketOpenSSL.DefaultPort := 0;
IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvTLSv1;


IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := sslmUnassigned;

MainForm.IdSMTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL;
MainForm.IdSMTP1.UseTLS := utUseImplicitTLS;

try
MainForm.IdSMTP1.Connect();
except
    addmessage ('����������� �� ����� �� ������!',false, para);
exit;
end;
 addmessage ('����������� �� ����� Ok',false, para);



MainForm.IdMessage1.From.Address:=settings.sedit2.text; // �������� ����� �����
MainForm.IdMessage1.Recipients.EMailAddresses:=settings.sedit1.text; // �����  ����� �� ������� ������� ������
MainForm.IdMessage1.From.Name:='������ ������: '+para;
MainForm.IdMessage1.CharSet:='windows-1251';
MainForm.IdMessage1.Body.Clear;

MainForm.IdMessage1.Body.Encoding.UTF8;
MainForm.idmessage1.Subject:=AnsiString('������ ������: '+text);// ���� ������

if para='btcusd' then begin
cena:=inttostr(MainForm.PowerBTC.Progress)+'%';
MainForm.IdMessage1.Body.Text:='������ ������: '+para+' '+text+#13+'����������: ����� ������:'+
inttostr(MainForm.TradeVolBTC.Progress)+'%, ����� last ������: '+cena+
', ����/����:'+inttostr(abs(MainForm.PampDampBTC.Position-100))+'%'+#13+'. ��������� ���������:'+floattostr(btcusd);
end;



MainForm.IdMessage1.Date:= now;

{��������� ����������� ����� ���������}
MainForm.IdMessage1.IsEncoded:=true;


try

if MainForm.idsmtp1.Connected then  begin

MainForm.IdSMTP1.Send(MainForm.IdMessage1);
Application.ProcessMessages;
addmessage ('������ ������� ���������� �� �����',false, para);
application.ProcessMessages;
  MainForm.IdMessage1.Clear;
  MainForm.IdMessage1.ClearBody;
                           end
                            else
  addmessage ('��� ����������',false, para);

except
addmessage ('������ �� ����������� �� �����',false, para);
application.ProcessMessages;
  MainForm.IdMessage1.Clear;
  MainForm.IdMessage1.ClearBody;
                                end;


addmessage ('��������� ����������',false, para);

MainForm.IdSMTP1.Disconnect;

end;


end.
