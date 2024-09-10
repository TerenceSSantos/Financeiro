unit View.uCadCredorDevedor;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   Forms,
   Controls,
   Graphics,
   Dialogs,
   ExtCtrls,
   ComCtrls,
   StdCtrls,
   DBGrids,
   EditBtn,
   BCButtonFocus,
   ACBrValidador,
   ACBrCEP;

type

   { TfrmCadCredorDevedor }

   TfrmCadCredorDevedor = class(TForm)
      ACBrCEP: TACBrCEP;
      ACBrValidador: TACBrValidador;
      bcbtnCadCredDev: TBCButtonFocus;
      bcbtnEndereco: TBCButtonFocus;
      dbgrdCredorDevedor: TDBGrid;
      dtedtDataNasc: TDateEdit;
      edtAddress: TEdit;
      edtCEP: TEdit;
      edtCity: TEdit;
      edtComplement: TEdit;
      edtCpfCnpj: TEdit;
      edtNeighborhood: TEdit;
      edtNome: TEdit;
      edtNumber: TEdit;
      edtTelefone: TEdit;
      lblCEP: TLabel;
      lblCity: TLabel;
      lblComplement: TLabel;
      lblCpfCnpj: TLabel;
      lblDtNascimento: TLabel;
      lblAddress: TLabel;
      lblIdade: TLabel;
      lblNeighborhood: TLabel;
      lblNome: TLabel;
      lblNumber: TLabel;
      lblTelefone: TLabel;
      Panel1: TPanel;
      Panel2: TPanel;
      pcCadCredorDevedor: TPageControl;
      pnlBirthDate: TPanel;
      rgTipoPessoa: TRadioGroup;
      shpUnderlineNome: TShape;
      shpUnderlineCpfCnpj: TShape;
      shpUnderlineTelefone: TShape;
      shpUnderlineTelefone1: TShape;
      shpUnderlineCep: TShape;
      shpUnderlineLogradouro: TShape;
      shpUnderlineNumero: TShape;
      shpUnderlineComplemento: TShape;
      shpUnderlineBairro: TShape;
      shpUnderlineCidade: TShape;
      TbShtCredorDevedor: TTabSheet;
      TbShtEndereco: TTabSheet;
      procedure ACBrCEPBuscaEfetuada(Sender: TObject);
      procedure bcbtnCadCredDevClick(Sender: TObject);
      procedure bcbtnEnderecoClick(Sender: TObject);
      procedure dtedtDataNascExit(Sender: TObject);
      procedure edtCEPEnter(Sender: TObject);
      procedure edtCEPExit(Sender: TObject);
      procedure edtCpfCnpjEditingDone(Sender: TObject);
      procedure edtCpfCnpjEnter(Sender: TObject);
      procedure edtCpfCnpjExit(Sender: TObject);
      procedure edtTelefoneEditingDone(Sender: TObject);
      procedure edtTelefoneEnter(Sender: TObject);
      procedure edtTelefoneExit(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure rgTipoPessoaSelectionChanged(Sender: TObject);
   private
      //Fazer a troca de aba e trocar as cores dos botões para indicar qual aba está ativa.
      procedure ActiveDeactiveButton(AButton: TBCButtonFocus; ATabSheet: TTabSheet);
   public

   end;

var
   frmCadCredorDevedor: TfrmCadCredorDevedor;

implementation

uses
   Util.utilitarios;

{$R *.lfm}

{ TfrmCadCredorDevedor }

procedure TfrmCadCredorDevedor.FormCreate(Sender: TObject);
begin
   pcCadCredorDevedor.PageIndex := 0;
   bcbtnCadCredDev.Width := panel1.ClientWidth div 2;
   bcbtnEndereco.Width := panel1.ClientWidth div 2;
   dtedtDataNasc.MaxDate := Date;
end;

procedure TfrmCadCredorDevedor.FormShow(Sender: TObject);
begin
   edtNome.SetFocus;
end;

procedure TfrmCadCredorDevedor.edtCpfCnpjEnter(Sender: TObject);
begin
   if edtCpfCnpj.Text <> EmptyStr then
      edtCpfCnpj.Text := ClearFormatting(edtCpfCnpj.Text);  // Tira os caracteres não numéricos

   edtCpfCnpj.NumbersOnly := true;

   if rgTipoPessoa.ItemIndex = 0 then
      edtCpfCnpj.MaxLength := 11
   else
   if rgTipoPessoa.ItemIndex = 1 then
      edtCpfCnpj.MaxLength := 14;
end;

procedure TfrmCadCredorDevedor.edtCEPEnter(Sender: TObject);
begin
   ACBrValidador.TipoDocto := docCEP;
   if edtCEP.Text <> EmptyStr then
      edtCEP.Text := ClearFormatting(edtCEP.Text);
   edtCEP.NumbersOnly := true;
   edtCEP.MaxLength := 8;
end;

procedure TfrmCadCredorDevedor.ACBrCEPBuscaEfetuada(Sender: TObject);
begin
   try
      edtAddress.Text:= ACBrCEP.Enderecos[0].Tipo_Logradouro + ' ' + ACBrCEP.Enderecos[0].Logradouro;
      edtNeighborhood.Text:= ACBrCEP.Enderecos[0].Bairro;
      edtCity.Text:= ACBrCEP.Enderecos[0].Municipio;
   except
     on E: EListError{Exception} do
        ShowMessage('Endereço não encontrado com o CEP fornecido!');
   end;
end;

procedure TfrmCadCredorDevedor.bcbtnCadCredDevClick(Sender: TObject);
begin
   ActiveDeactiveButton(bcbtnCadCredDev, TbShtEndereco);
end;

procedure TfrmCadCredorDevedor.bcbtnEnderecoClick(Sender: TObject);
begin
   ActiveDeactiveButton(bcbtnEndereco, TbShtCredorDevedor);
end;

procedure TfrmCadCredorDevedor.dtedtDataNascExit(Sender: TObject);
begin
   if dtedtDataNasc.Text <> EmptyStr then
      lblIdade.Caption := CalculateAge(dtedtDataNasc.Date)
   else
      lblIdade.Caption := 'Data não informada!';
end;

procedure TfrmCadCredorDevedor.edtCEPExit(Sender: TObject);
begin
   edtCEP.MaxLength := 9;
   ACBrValidador.Documento := edtCEP.Text;

   if ACBrValidador.Validar then
   begin
      edtCEP.NumbersOnly := false;
      edtCEP.Text := ACBrValidador.Formatar;
      if TestInternetConnection then
         ACBrCEP.BuscarPorCEP(edtCEP.Text) //===> O resultado será capturado pelo evento OnBuscaEfetuada do ACBrCEP.
      else
         MessageDlg('A V I S O', 'Não foi possível a conexão com a internet, portanto não será possível procurar ' +
                    'pelo endereço!', mtWarning, [mbOK], 0);
   end
   else
   begin
      MessageDlg('A V I S O', 'Nº de CEP inválido!', mtWarning, [mbOK],0);
      edtCEP.SetFocus;
   end;
end;

//  ***   ESTE CÓDIGO É PARA QUE O TEXTHINT POSSA SER EXIBIDO.    ***

procedure TfrmCadCredorDevedor.edtCpfCnpjEditingDone(Sender: TObject);
begin
   if Length(edtCpfCnpj.Text) = 0 then     // Caso o campo esteja vazio ao final, na saída,
      edtCpfCnpj.NumbersOnly := false;     // permitirá a exibição do TEXTHINT
end;

procedure TfrmCadCredorDevedor.edtCpfCnpjExit(Sender: TObject);
var
   qualDoc : string;
begin
   ACBrValidador.Documento := edtCpfCnpj.Text;
   if rgTipoPessoa.ItemIndex = 0 then
   begin
      qualDoc := 'CPF';
      edtCpfCnpj.MaxLength := 14;
   end
   else
   if rgTipoPessoa.ItemIndex = 1 then
   begin
      qualDoc := 'CNPJ';
      edtCpfCnpj.MaxLength := 18;
   end;

   if edtCpfCnpj.Text <> EmptyStr then
   begin
      if ACBrValidador.Validar then
      begin
         edtCpfCnpj.NumbersOnly := false;
         edtCpfCnpj.Text := ACBrValidador.Formatar;
      end
      else
      begin
         MessageDlg('Nº de ' + qualDoc + ' inválido!', mtWarning, [mbOK],0);
         edtCpfCnpj.SetFocus;
      end;
   end;
end;

//  ***   ESTE CÓDIGO É PARA QUE O TEXTHINT POSSA SER EXIBIDO.    ***

procedure TfrmCadCredorDevedor.edtTelefoneEditingDone(Sender: TObject);
begin
   if Length(edtTelefone.Text) = 0 then   // Caso o campo esteja vazio ao final, na saída,
      edtTelefone.NumbersOnly := false;   // permitirá a exibição do TEXTHINT
end;

procedure TfrmCadCredorDevedor.edtTelefoneEnter(Sender: TObject);
begin
   if Length(edtTelefone.Text) = 0 then
      edtTelefone.NumbersOnly := true;

   if edtTelefone.Text <> EmptyStr then
   begin
      edtTelefone.Text := ClearFormatting(edtTelefone.Text);
      edtTelefone.NumbersOnly := true;
   end;

   edtTelefone.MaxLength := 11;
end;

procedure TfrmCadCredorDevedor.edtTelefoneExit(Sender: TObject);
begin
   edtTelefone.MaxLength := 14;
   edtTelefone.NumbersOnly := false;

   if edtTelefone.Text <> EmptyStr then
      edtTelefone.Text := FormatarFone(edtTelefone.Text);

end;

procedure TfrmCadCredorDevedor.rgTipoPessoaSelectionChanged(Sender: TObject);
begin
   lblCpfCnpj.Visible := true;
   edtCpfCnpj.Visible := true;
   edtCpfCnpj.Text := EmptyStr;
   shpUnderlineCpfCnpj.Visible := true;

   if rgTipoPessoa.ItemIndex = 0 then
   begin
      lblCpfCnpj.Caption := 'CPF';
      dtedtDataNasc.Enabled := true;
      ACBrValidador.TipoDocto := docCPF;
      lblIdade.Visible := true;
   end
   else
   if rgTipoPessoa.ItemIndex = 1 then
   begin
      lblCpfCnpj.Caption := 'CNPJ';
      dtedtDataNasc.Clear;
      dtedtDataNasc.Enabled := false;
      dtedtDataNasc.Enabled := false;
      ACBrValidador.TipoDocto := docCNPJ;
      lblIdade.Visible := false;
   end
   else
   begin
      lblCpfCnpj.Visible := false;
      edtCpfCnpj.Visible := false;
      shpUnderlineCpfCnpj.Visible := false;
   end;
end;

procedure TfrmCadCredorDevedor.ActiveDeactiveButton(AButton: TBCButtonFocus; ATabSheet: TTabSheet);
begin
   if (AButton.Name = 'bcbtnCadCredDev') and (ATabSheet.Name = 'TbShtEndereco') then
   begin
      pcCadCredorDevedor.PageIndex := 0;
      AButton.StateNormal.Background.Color := clTeal;
      bcbtnEndereco.StateNormal.Background.Color := clInactiveCaption;
   end
   else
   if (AButton.Name = 'bcbtnEndereco') and (ATabSheet.Name = 'TbShtCredorDevedor') then
   begin
      pcCadCredorDevedor.PageIndex := 1;
      AButton.StateNormal.Background.Color := clTeal;
      bcbtnCadCredDev.StateNormal.Background.Color := clInactiveCaption;
   end;

end;

end.

