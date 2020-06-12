object FormClientes: TFormClientes
  Left = 0
  Top = 0
  ActiveControl = EditPesquisa
  Caption = 'Clientes'
  ClientHeight = 543
  ClientWidth = 1165
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1165
    543)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 117
    Top = 58
    Width = 925
    Height = 435
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 140
      Height = 13
      Caption = 'Pesquisar (Principais campos)'
    end
    object DBGridCliente: TDBGrid
      Left = 8
      Top = 112
      Width = 905
      Height = 281
      DataSource = dsCliente
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGridClienteDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Alignment = taCenter
          Title.Caption = 'Nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IDENTIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Identidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFONE'
          Title.Alignment = taCenter
          Title.Caption = 'Telefone'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL'
          Title.Alignment = taCenter
          Title.Caption = 'E-Mail'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CEP'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOGRADOURO'
          Title.Alignment = taCenter
          Title.Caption = 'Logradouro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMERO'
          Title.Alignment = taCenter
          Title.Caption = 'N'#250'mero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPLEMENTO'
          Title.Alignment = taCenter
          Title.Caption = 'Complemento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Title.Alignment = taCenter
          Title.Caption = 'Bairro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Cidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTADO'
          Title.Alignment = taCenter
          Title.Caption = 'UF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PAIS'
          Title.Alignment = taCenter
          Title.Caption = 'Pa'#237's'
          Visible = True
        end>
    end
    object ButtonIncluir: TButton
      Left = 522
      Top = 400
      Width = 75
      Height = 25
      Hint = 'Incluir'
      Caption = 'Incluir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = ButtonIncluirClick
    end
    object ButtonAlterar: TButton
      Left = 602
      Top = 400
      Width = 75
      Height = 25
      Hint = 'Alterar'
      Caption = 'Alterar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = ButtonAlterarClick
    end
    object ButtonExcluir: TButton
      Left = 682
      Top = 400
      Width = 75
      Height = 25
      Hint = 'Excluir'
      Caption = 'Excluir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = ButtonExcluirClick
    end
    object EditPesquisa: TEdit
      Left = 8
      Top = 30
      Width = 385
      Height = 21
      TabOrder = 0
    end
    object RadioGroupOrdem: TRadioGroup
      Left = 8
      Top = 56
      Width = 385
      Height = 49
      Caption = 'Ordenar por'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Nome'
        'CPF'
        'Telefone'
        'E-mail'
        'Logradouro'
        'UF')
      TabOrder = 1
      OnClick = RadioGroupOrdemClick
    end
    object ButtonFiltrar: TButton
      Left = 399
      Top = 80
      Width = 75
      Height = 25
      Hint = 'Filtrar'
      Caption = 'Filtrar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = ButtonFiltrarClick
    end
    object ButtonLimpar: TButton
      Left = 480
      Top = 80
      Width = 75
      Height = 25
      Hint = 'Limpar'
      Caption = 'Limpar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = ButtonLimparClick
    end
    object ButtonSair: TButton
      Left = 839
      Top = 400
      Width = 75
      Height = 25
      Hint = 'Sair'
      Caption = 'Sair'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = ButtonSairClick
    end
    object ButtonEmail: TButton
      Left = 761
      Top = 400
      Width = 75
      Height = 25
      Caption = 'Enviar E-mail'
      TabOrder = 8
      OnClick = ButtonEmailClick
    end
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 163
    Top = 419
    object cdsClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object cdsClienteIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object cdsClienteCPF: TStringField
      FieldName = 'CPF'
      EditMask = '000.000.000-00'
    end
    object cdsClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      EditMask = '!\(99\)00000-0000;1;_'
    end
    object cdsClienteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 50
    end
    object cdsClienteCEP: TStringField
      Alignment = taRightJustify
      DisplayWidth = 20
      FieldName = 'CEP'
      EditMask = '00000-000'
    end
    object cdsClienteLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 150
    end
    object cdsClienteNUMERO: TStringField
      Alignment = taRightJustify
      FieldName = 'NUMERO'
    end
    object cdsClienteCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
    end
    object cdsClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 50
    end
    object cdsClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 50
    end
    object cdsClienteESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsClientePAIS: TStringField
      FieldName = 'PAIS'
      Size = 50
    end
  end
  object dsCliente: TDataSource
    DataSet = cdsCliente
    Left = 131
    Top = 419
  end
end
