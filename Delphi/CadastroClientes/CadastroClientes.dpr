program CadastroClientes;

uses
  Vcl.Forms,
  Clientes in 'Clientes.pas' {FormClientes},
  DetalheCliente in 'DetalheCliente.pas' {FormDetalheCliente},
  UnAPIviacep in 'UnAPIviacep.pas',
  Funcoes in 'Funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormClientes, FormClientes);
  Application.Run;
end.
