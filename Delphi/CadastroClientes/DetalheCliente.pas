unit DetalheCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, Datasnap.DBClient, IdHTTP, IdSSLOpenSSL, System.json, WinSpool,
  Buttons, ExtCtrls, ComCtrls, dbGrids, Printers, DBTables, Consts,
  ComObj, System.UITypes, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, Typinfo, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, SHFolder, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdAttachmentFile, Wininet, StrUtils, IdHashMessageDigest,
  XMLDoc, XMLIntf,IdStackWindows, ADOInt, IdText, MidasLib;

type
  TFormDetalheCliente = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBEditNome: TDBEdit;
    DBEditIdentidade: TDBEdit;
    DBEditCPF: TDBEdit;
    DBEditEmail: TDBEdit;
    DBEditTelefone: TDBEdit;
    DBEditCEP: TDBEdit;
    DBEditLogradouro: TDBEdit;
    DBEditNumero: TDBEdit;
    DBEditComplemento: TDBEdit;
    DBEditBairro: TDBEdit;
    DBEditCidade: TDBEdit;
    DBEditPais: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    DBComboBoxUF: TDBComboBox;
    ButtonGravar: TButton;
    ButtonSair: TButton;
    ButtonPesquisar: TButton;
    cdsAux: TClientDataSet;
    procedure ButtonGravarClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBComboBoxUFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDetalheCliente: TFormDetalheCliente;
  ListaEstado: TStringList;

implementation

{$R *.dfm}

uses
  Clientes, UnAPIviacep, Funcoes;

procedure TFormDetalheCliente.ButtonGravarClick(Sender: TObject);
var
  Caminho, CorpoEmail: String;

begin
  CorpoEmail := '';
  Caminho := '';

  // Consistindo os dados
  if Trim(DBEditNome.Field.AsString) = '' then
     begin
       MessageDlg('Falta informar o nome.', mtError, [mbOk], 0);
       DBEditNome.SetFocus;
       abort;
     end;

  if Trim(DBEditCPF.Field.AsString) = '' then
     begin
       MessageDlg('Falta informar o CPF.', mtError, [mbOk], 0);
       DBEditCPF.SetFocus;
       abort;
     end;

  if Length(Trim(DBEditCPF.Field.AsString)) - 3 <> 11 then
     begin
       MessageDlg('CPF inválido.', mtError, [mbOk], 0);
       DBEditCPF.SetFocus;
       abort;
     end;

  if DBEditCPF.Enabled then
     if cdsAux.Locate('CPF', Trim(DBEditCPF.Field.AsString), []) then
        begin
          MessageDlg('CPF já cadastrado. Verifique!!', mtInformation, [mbOk], 0);
          DBEditCPF.SetFocus;
          abort;
        end;

  if Trim(DBEditTelefone.Field.AsString) = '' then
     begin
       MessageDlg('Falta informar o telefone.', mtError, [mbOk], 0);
       DBEditNome.SetFocus;
       abort;
     end;

  // Gravando os dados e enviando o e-mail
  try
    FormClientes.cdsCliente.Post;

    if Trim(DBEditEmail.Field.AsString) = '' then
       messageDlg('Registro gravado com sucesso!!', mtError, [mbOk], 0)
    else
      if MessageDlg('Registro gravado com sucesso!! Deseja enviar um e-mail com xml contendo os dados do cliente?' + #13 +
                    'O envio pode levar alguns segundos.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
         begin
           try
             ButtonGravar.Enabled := False;
             FormClientes.EnviarEmailCliente()
           finally
             ButtonGravar.Enabled := True;
           end;

         end;

    ButtonSair.Click;
  except
    MessageDlg('Houve falha ao gravar o registro. Operação cancelada.', mtError, [mbOk], 0);
    abort;
  end;
end;

procedure TFormDetalheCliente.ButtonPesquisarClick(Sender: TObject);
var
  Endereco: TAPIViacep;
begin
  Endereco := TAPIViacep.Create(Trim(DBEditCEP.Field.AsString));

  if Endereco.GetRespCode <> 200 then
     begin
       MessageDlg('CEP inválido!!', mtInformation, [mbOk], 0);
       DBEditCEP.SetFocus;
       abort;
     end
  else
    begin
      MessageDlg('Consulta realizada com sucesso!', mtError, [mbOk], 0);
      DBEditPais.Field.AsString := 'Brasil';
      DBEditNumero.SetFocus;
    end;

  // Carrega os dados do endereço.
  DBEditLogradouro.Field.AsString := Endereco.GetLogradouro;
  DBEditBairro.Field.AsString := Endereco.GetBairro;
  DBEditCidade.Field.AsString := Endereco.GetLocalidade;
  DBComboBoxUF.Field.AsString := Endereco.GetUF;

  Endereco.Free;
end;

procedure TFormDetalheCliente.ButtonSairClick(Sender: TObject);
begin
  if FormClientes.cdsCliente.State <> dsBrowse then
     FormClientes.cdsCliente.Cancel;

  ListaEstado.Free;

  Self.Close;
end;

procedure TFormDetalheCliente.DBComboBoxUFKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
     DBComboBoxUF.Field.AsString := null;
end;

procedure TFormDetalheCliente.FormCreate(Sender: TObject);
begin
  ListaEstado := TStringList.Create();

  ListaEstado.Add('AC');
  ListaEstado.Add('AL');
  ListaEstado.Add('AM');
  ListaEstado.Add('AP');
  ListaEstado.Add('BA');
  ListaEstado.Add('CE');
  ListaEstado.Add('DF');
  ListaEstado.Add('ES');
  ListaEstado.Add('GO');
  ListaEstado.Add('MA');
  ListaEstado.Add('MG');
  ListaEstado.Add('MS');
  ListaEstado.Add('MT');
  ListaEstado.Add('PA');
  ListaEstado.Add('PB');
  ListaEstado.Add('PE');
  ListaEstado.Add('PI');
  ListaEstado.Add('PR');
  ListaEstado.Add('RJ');
  ListaEstado.Add('RN');
  ListaEstado.Add('RO');
  ListaEstado.Add('RR');
  ListaEstado.Add('RS');
  ListaEstado.Add('SC');
  ListaEstado.Add('SE');
  ListaEstado.Add('SP');
  ListaEstado.Add('TO');
  ListaEstado.Add('');
end;

procedure TFormDetalheCliente.FormShow(Sender: TObject);
begin
  DBComboBoxUF.Items := ListaEstado;
end;

end.
