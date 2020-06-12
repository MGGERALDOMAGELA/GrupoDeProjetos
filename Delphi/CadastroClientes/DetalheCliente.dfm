object FormDetalheCliente: TFormDetalheCliente
  Left = 0
  Top = 0
  ActiveControl = DBEditNome
  BorderIcons = [biSystemMenu]
  Caption = 'Novo'
  ClientHeight = 458
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 9
    Width = 537
    Height = 185
    Caption = 'Dados Pessoais'
    TabOrder = 0
    object Label9: TLabel
      Left = 14
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label10: TLabel
      Left = 14
      Top = 71
      Width = 52
      Height = 13
      Caption = 'Identidade'
    end
    object Label11: TLabel
      Left = 185
      Top = 71
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object Label12: TLabel
      Left = 14
      Top = 119
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Label13: TLabel
      Left = 354
      Top = 72
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object DBEditNome: TDBEdit
      Left = 14
      Top = 39
      Width = 508
      Height = 21
      DataField = 'NOME'
      DataSource = FormClientes.dsCliente
      TabOrder = 0
    end
    object DBEditIdentidade: TDBEdit
      Left = 14
      Top = 87
      Width = 161
      Height = 21
      DataField = 'IDENTIDADE'
      DataSource = FormClientes.dsCliente
      TabOrder = 1
    end
    object DBEditCPF: TDBEdit
      Left = 184
      Top = 87
      Width = 161
      Height = 21
      DataField = 'CPF'
      DataSource = FormClientes.dsCliente
      TabOrder = 2
    end
    object DBEditEmail: TDBEdit
      Left = 14
      Top = 135
      Width = 508
      Height = 21
      DataField = 'EMAIL'
      DataSource = FormClientes.dsCliente
      TabOrder = 4
    end
    object DBEditTelefone: TDBEdit
      Left = 354
      Top = 87
      Width = 168
      Height = 21
      DataField = 'TELEFONE'
      DataSource = FormClientes.dsCliente
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 200
    Width = 537
    Height = 217
    Caption = 'Endere'#231'o'
    TabOrder = 1
    object Label1: TLabel
      Left = 14
      Top = 26
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object Label2: TLabel
      Left = 14
      Top = 74
      Width = 55
      Height = 13
      Caption = 'Logradouro'
    end
    object Label3: TLabel
      Left = 406
      Top = 74
      Width = 17
      Height = 13
      Caption = 'No.'
    end
    object Label4: TLabel
      Left = 457
      Top = 74
      Width = 65
      Height = 13
      Caption = 'Complemento'
    end
    object Label5: TLabel
      Left = 14
      Top = 122
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object Label6: TLabel
      Left = 236
      Top = 121
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label7: TLabel
      Left = 14
      Top = 170
      Width = 19
      Height = 13
      Caption = 'Pa'#237's'
    end
    object Label8: TLabel
      Left = 457
      Top = 120
      Width = 33
      Height = 13
      Caption = 'Estado'
    end
    object DBEditCEP: TDBEdit
      Left = 14
      Top = 41
      Width = 121
      Height = 21
      DataField = 'CEP'
      DataSource = FormClientes.dsCliente
      TabOrder = 0
    end
    object DBEditLogradouro: TDBEdit
      Left = 14
      Top = 89
      Width = 384
      Height = 21
      DataField = 'LOGRADOURO'
      DataSource = FormClientes.dsCliente
      TabOrder = 2
    end
    object DBEditNumero: TDBEdit
      Left = 406
      Top = 89
      Width = 43
      Height = 21
      DataField = 'NUMERO'
      DataSource = FormClientes.dsCliente
      TabOrder = 3
    end
    object DBEditComplemento: TDBEdit
      Left = 457
      Top = 89
      Width = 65
      Height = 21
      DataField = 'COMPLEMENTO'
      DataSource = FormClientes.dsCliente
      TabOrder = 4
    end
    object DBEditBairro: TDBEdit
      Left = 14
      Top = 137
      Width = 211
      Height = 21
      DataField = 'BAIRRO'
      DataSource = FormClientes.dsCliente
      TabOrder = 5
    end
    object DBEditCidade: TDBEdit
      Left = 235
      Top = 137
      Width = 211
      Height = 21
      DataField = 'CIDADE'
      DataSource = FormClientes.dsCliente
      TabOrder = 6
    end
    object DBEditPais: TDBEdit
      Left = 14
      Top = 185
      Width = 211
      Height = 21
      DataField = 'PAIS'
      DataSource = FormClientes.dsCliente
      TabOrder = 8
    end
    object DBComboBoxUF: TDBComboBox
      Left = 457
      Top = 137
      Width = 65
      Height = 21
      Style = csDropDownList
      DataField = 'ESTADO'
      DataSource = FormClientes.dsCliente
      TabOrder = 7
      OnKeyDown = DBComboBoxUFKeyDown
    end
    object ButtonPesquisar: TButton
      Left = 138
      Top = 40
      Width = 66
      Height = 23
      Caption = 'Pesquisar'
      PressedImageIndex = 21
      TabOrder = 1
      OnClick = ButtonPesquisarClick
    end
  end
  object ButtonGravar: TButton
    Left = 390
    Top = 424
    Width = 75
    Height = 25
    Hint = 'Gravar'
    Caption = 'Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = ButtonGravarClick
  end
  object ButtonSair: TButton
    Left = 470
    Top = 424
    Width = 75
    Height = 25
    Hint = 'Sair'
    Caption = 'Sair'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = ButtonSairClick
  end
  object cdsAux: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 5
    Top = 425
  end
end
