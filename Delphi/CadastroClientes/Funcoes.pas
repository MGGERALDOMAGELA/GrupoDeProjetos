unit Funcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, Datasnap.DBClient, IdHTTP, IdSSLOpenSSL, System.json, WinSpool,
  Buttons, ExtCtrls, ComCtrls, dbGrids, Printers, DBTables, Consts,
  ComObj, System.UITypes, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, Typinfo, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, SHFolder, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdAttachmentFile, Wininet, StrUtils, IdHashMessageDigest,
  XMLDoc, XMLIntf,IdStackWindows, ADOInt, IdText;

function GravaConteudoEntreTags(Tag, conteudo: String): String;
procedure EnviarEmail(CaminhoAnexo, NomeRemetente, EmailDestinatario, Assunto, Corpo: String);

implementation

function GravaConteudoEntreTags(Tag, conteudo: String): String;
begin
  result := '<' + Tag + '>' + conteudo + '</' + Tag + '>'
end;

procedure EnviarEmail(CaminhoAnexo, NomeRemetente, EmailDestinatario, Assunto, Corpo: String);
var
  RealizarAutenticacao, UtilizaSSL: boolean;
  SMTP: TIdSMTP;
  IdentificadorMensagem: TIdMessage;
  ProvedorSMTP, SenhaSMTP, UserSMTP: String;
  TextoParte: TIdText;
  SSLSocket: TIdSSLIOHandlerSocketOpenSSL;
  PortaSMTP: integer;
begin
  UtilizaSSL := True;
  RealizarAutenticacao := True;

  if not FileExists(CaminhoAnexo) then
     CaminhoAnexo := '';

  SMTP := TIdSMTP.Create(Application);
  SSLSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  IdentificadorMensagem := TIdMessage.Create(Application);

  ProvedorSMTP := '';  // Coloque aqui seu provedor
  UserSMTP := ''; // Coloque aqui seu e-mail
  SenhaSMTP := '';     //coloque aqui a sua senha
  PortaSMTP := 587;  //465, 587

  with SMTP do
    begin
      if RealizarAutenticacao then
         AuthType := satDefault
      else
        AuthType := satNone;

      Host := ProvedorSMTP;
      Password := SenhaSMTP;
      Username := UserSMTP;
      Port := PortaSMTP;

      if UtilizaSSL then
         begin
           IOHandler := SSLSocket;
           UseTLS := utUseRequireTLS;
           ConnectTimeout := 6000;
           ReadTimeout := 6000;
      end
        else
          IOHandler := nil;
    end;

  if UtilizaSSL then
  begin
    SSLSocket.SSLOptions.Method := sslvTLSv1; // sslvTLSv1_2
    SSLSocket.SSLOptions.Mode := sslmClient;
  end;

  try
    SMTP.Connect;
    SMTP.Authenticate;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      SMTP.Free;
      SSLSocket.Free;
      IdentificadorMensagem.Free;
      exit;
    end;
  end;

  if SMTP.Connected then
     begin
       IdentificadorMensagem.From.Name := NomeRemetente;
       IdentificadorMensagem.From.Address := UserSMTP;
       IdentificadorMensagem.Recipients.EMailAddresses := EmailDestinatario;
       IdentificadorMensagem.Subject := Assunto;

       IdentificadorMensagem.ClearBody();

       TextoParte := TIdText.Create(IdentificadorMensagem.MessageParts, nil);
       TextoParte.Body.Text := Corpo;
       TextoParte.ContentType := 'text/plain';

       if CaminhoAnexo <> '' then
         TIdAttachmentFile.Create(IdentificadorMensagem.MessageParts, CaminhoAnexo);

       try
         SMTP.Send(IdentificadorMensagem);
       except
         on E: Exception do
            begin
              MessageDlg('Houve falha no envio do e-mail.' + E.Message, mtError, [mbOK], 0);

              SMTP.Disconnect();
              IdentificadorMensagem.Free;
              SMTP.Free;
              SSLSocket.Free;

              exit;
            end;
       end;

      MessageDlg('E-mail enviado com sucesso.', mtInformation, [mbOK], 0);
      DeleteFile(CaminhoAnexo);

      SMTP.Disconnect();
     end;

  SMTP.Free;
  SSLSocket.Free;
  IdentificadorMensagem.Free;
end;

end.
