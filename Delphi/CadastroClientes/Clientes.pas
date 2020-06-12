unit Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, Datasnap.DBClient;

type
  TFormClientes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBGridCliente: TDBGrid;
    ButtonIncluir: TButton;
    ButtonAlterar: TButton;
    ButtonExcluir: TButton;
    EditPesquisa: TEdit;
    RadioGroupOrdem: TRadioGroup;
    ButtonFiltrar: TButton;
    ButtonLimpar: TButton;
    ButtonSair: TButton;
    cdsCliente: TClientDataSet;
    cdsClienteNOME: TStringField;
    cdsClienteIDENTIDADE: TStringField;
    cdsClienteCPF: TStringField;
    cdsClienteTELEFONE: TStringField;
    cdsClienteEMAIL: TStringField;
    cdsClienteCEP: TStringField;
    cdsClienteLOGRADOURO: TStringField;
    cdsClienteNUMERO: TStringField;
    cdsClienteCOMPLEMENTO: TStringField;
    cdsClienteBAIRRO: TStringField;
    cdsClienteCIDADE: TStringField;
    cdsClienteESTADO: TStringField;
    cdsClientePAIS: TStringField;
    dsCliente: TDataSource;
    ButtonEmail: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonFiltrarClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonIncluirClick(Sender: TObject);
    procedure ButtonAlterarClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonSairClick(Sender: TObject);
    procedure DBGridClienteDblClick(Sender: TObject);
    procedure RadioGroupOrdemClick(Sender: TObject);
    function MontarEmail(cds: TClientDataSet): String;
    procedure MontarXML(cds: TClientDataSet);
    procedure EnviarEmailCliente();
    procedure ButtonEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClientes: TFormClientes;

implementation

{$R *.dfm}

uses
   DetalheCliente, Funcoes;

procedure TFormClientes.ButtonEmailClick(Sender: TObject);
begin
  if cdsCliente.FieldByName('CPF').IsNull then
     begin
       MessageDlg('Falta selecionar um registro.', mtError, [mbOk], 0);
       abort;
     end;


  if MessageDlg('Deseja realmente enviar o e-mail para o cliente?' + #13 + 
                'O envio pode levar alguns segundos.', mtConfirmation, [mbYes, mbNo], 0)  = mrYes then
     begin
       if Trim(cdsCliente.FieldByName('EMAIL').AsString) = '' then
          begin
            MessageDlg('O e-mail não foi informado. Operação cancelada.', mtInformation, [mbOk], 0);
            abort;
          end;     

       try
         ButtonEmail.Enabled := False;
         EnviarEmailCliente();       
       finally
         ButtonEmail.Enabled := True;
       end;
     end;

end;

procedure TFormClientes.ButtonAlterarClick(Sender: TObject);
var
  cpf: String;
begin
  if cdsCliente.FieldByName('CPF').IsNull then
     begin
       MessageDlg('Falta selecionar um registro.', mtError, [mbOk], 0);
       abort;
     end;

  cpf := cdsCliente.FieldByName('CPF').AsString;

  FormDetalheCliente := TFormDetalheCliente.Create(Application);
  FormDetalheCliente.cdsAux.CloneCursor(cdsCliente, false, false);
  FormDetalheCliente.DBEditCPF.Enabled := False;

  cdsCliente.Edit;

  FormDetalheCliente.ShowModal;

  ButtonLimpar.Click;

  cdsCliente.Locate('CPF', cpf, []);

//  cdsCliente.SaveToFile(ExtractFilePath(Application.ExeName) + 'cdsCliente.cds');
end;

procedure TFormClientes.ButtonExcluirClick(Sender: TObject);
begin
  if cdsCliente.FieldByName('CPF').IsNull then
     begin
       MessageDlg('Falta selecionar um registro.', mtError, [mbOk], 0);
       abort;
     end;

  if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       cdsCliente.Delete;

       ButtonLimpar.Click;
//       cdsCliente.SaveToFile(ExtractFilePath(Application.ExeName) + 'cdsCliente.cds');
     end;
end;

procedure TFormClientes.ButtonFiltrarClick(Sender: TObject);
begin
  if Trim(EditPesquisa.Text) <> '' then
     begin
       cdsCliente.Filtered := False;
       cdsCliente.Filter := '(NOME like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(IDENTIDADE like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(CPF like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(TELEFONE like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(EMAIL like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(CEP like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(LOGRADOURO like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '% ') + ') or ' +
                            '(COMPLEMENTO like ' + QuotedStr('%' + Trim(EditPesquisa.Text) + '%') + ') or ' +
                            '(BAIRRO like ' + QuotedStr('%' + Trim(EditPesquisa.Text)+ '% ') + ') or ' +
                            '(CIDADE like ' + QuotedStr('%' + Trim(EditPesquisa.Text)+ '% ') + ') or ' +
                            '(ESTADO like ' + QuotedStr('%' + Trim(EditPesquisa.Text)+ '% ') + ') or ' +
                            '(PAIS like ' + QuotedStr('%' + Trim(EditPesquisa.Text)+ '% ') + ' )';
       cdsCliente.Filtered := True;
     end
  else
    begin   
      cdsCliente.Filtered := False;
      cdsCliente.Filter := '';
      cdsCliente.Filtered := True;
    end;

  case RadioGroupOrdem.ItemIndex of
    0:  cdsCliente.IndexFieldNames := 'NOME';
    1:  cdsCliente.IndexFieldNames := 'CPF';
    2:  cdsCliente.IndexFieldNames := 'TELEFONE';
    3:  cdsCliente.IndexFieldNames := 'EMAIL';
    4:  cdsCliente.IndexFieldNames := 'LOGRADOURO';
    5:  cdsCliente.IndexFieldNames := 'ESTADO';
  end;
end;

procedure TFormClientes.ButtonIncluirClick(Sender: TObject);
begin
  FormDetalheCliente := TFormDetalheCliente.Create(Application);
  FormDetalheCliente.cdsAux.CloneCursor(cdsCliente, false, false);

  cdsCliente.Append;

  FormDetalheCliente.ShowModal;

  ButtonLimpar.Click;

//  cdsCliente.SaveToFile(ExtractFilePath(Application.ExeName) + 'cdsCliente.cds');
end;

procedure TFormClientes.ButtonLimparClick(Sender: TObject);
begin
  EditPesquisa.Clear;
  RadioGroupOrdem.ItemIndex := 0;

  cdsCliente.Filtered := False;
  cdsCliente.Filter := '';
  cdsCliente.Filtered := True;
end;

procedure TFormClientes.ButtonSairClick(Sender: TObject);
begin
//  cdsCliente.SaveToFile(ExtractFilePath(Application.ExeName) + 'cdsCliente.cds');

  Self.Close;
end;

procedure TFormClientes.DBGridClienteDblClick(Sender: TObject);
begin
  ButtonAlterar.Click;
end;

procedure TFormClientes.FormCreate(Sender: TObject);
var
  Caminho: String;
begin
  cdsCliente.CreateDataSet;

  Caminho := ExtractFilePath(Application.ExeName);

  if FileExists(Caminho + 'cdsCliente.cds') then
     cdsCliente.LoadFromFile(Caminho + 'cdsCliente.cds');
end;

procedure TFormClientes.FormShow(Sender: TObject);
begin
  ButtonFiltrar.Click;
end;

procedure TFormClientes.RadioGroupOrdemClick(Sender: TObject);
begin
  ButtonFiltrar.Click;
end;

function TFormClientes.MontarEmail(cds: TClientDataSet): String;
var
  s: TStringList;
begin
  s := TStringList.Create();

  s.Add('Presado cliente, seu cadastro foi realizado com sucesso.');
  s.Add('');
  s.Add('Segue abaixo seus dados para conferência:');
  s.Add('');
  s.Add('Dados pessoais');
  s.Add('Nome: ' + Trim(cds.FieldByName('NOME').AsString));
  s.Add('Identidade: ' + Trim(cds.FieldByName('IDENTIDADE').AsString));
  s.Add('CPF: ' + Trim(cds.FieldByName('CPF').AsString));
  s.Add('Telefone: ' + Trim(cds.FieldByName('TELEFONE').AsString));
  s.Add('E-mail: ' + Trim(cds.FieldByName('EMAIL').AsString));
  s.Add('');
  s.Add('Endereço:');
  s.Add('Logradouro: ' + Trim(cds.FieldByName('LOGRADOURO').AsString));
  s.Add('Número: ' + Trim(cds.FieldByName('NUMERO').AsString));
  s.Add('Complemento: ' + Trim(cds.FieldByName('COMPLEMENTO').AsString));
  s.Add('Bairro: ' + Trim(cds.FieldByName('BAIRRO').AsString));
  s.Add('Cidade: ' + Trim(cds.FieldByName('CIDADE').AsString));
  s.Add('CEP: ' + Trim(cds.FieldByName('CEP').AsString));
  s.Add('País: ' + Trim(cds.FieldByName('PAIS').AsString));
  s.Add('');
  s.Add('Segue xml em anexo.');
  s.Add('');
  s.Add('Atenciosamente');

  result := s.Text;

  s.Free;
end;

procedure TFormClientes.MontarXML(cds: TClientDataSet);
var
  Caminho: String;
  i: Integer;
  xml: TStringList;
begin
  Caminho := ExtractFilePath(Application.ExeName);

  xml := TStringList.Create;
  xml.Add('<?xml version="1.0"?>');
  xml.Add('<CLIENTES>');
  xml.Add('   <CLIENTE> id="' + cds.FieldByName('CPF').AsString + '">');

  for i := 0 to cds.FieldCount -1 do
    xml.Add('      ' + GravaConteudoEntreTags(cds.Fields[i].FieldName, cds.Fields[i].Value));

  xml.Add('   </CLIENTE>');
  xml.Add('</CLIENTES>');

  xml.SaveToFile(Caminho + 'CPF-' + cds.FieldByName('CPF').AsString + '.XML');

  xml.Free;
end;

procedure TFormClientes.EnviarEmailCliente();
var
  Caminho, CorpoEmail: String;
begin
  FormClientes.MontarXML(FormClientes.cdsCliente);
  CorpoEmail := FormClientes.MontarEmail(FormClientes.cdsCliente);
  Caminho := ExtractFilePath(Application.ExeName) + 'CPF-' + Trim(cdsCliente.FieldByName('CPF').AsString) + '.XML';
  EnviarEmail(Caminho, Trim(cdsCliente.FieldByName('NOME').AsString), Trim(cdsCliente.FieldByName('EMAIL').AsString), 'Cadastro Realizado', CorpoEmail);
end;

end.
