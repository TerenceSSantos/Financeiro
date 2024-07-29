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
   DateTimePicker,
   ACBrValidador,
   ACBrCEP;

type

   { TfrmCadCredorDevedor }

   TfrmCadCredorDevedor = class(TForm)
      ACBrCEP: TACBrCEP;
      ACBrValidador: TACBrValidador;
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
      pnlButtonCreDev: TPanel;
      pnlButtonEndereco: TPanel;
      rgTipoPessoa: TRadioGroup;
      TbShtCredorDevedor: TTabSheet;
      TbShtEndereco: TTabSheet;
      procedure ACBrCEPBuscaEfetuada(Sender: TObject);
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
      procedure pnlButtonCreDevClick(Sender: TObject);
      procedure pnlButtonEnderecoClick(Sender: TObject);
      procedure rgTipoPessoaSelectionChanged(Sender: TObject);
   private
      // Retirar a formatação e retornar somente os números
      function ClearFormatting(const doc: string): string;

      //Fazer a troca de aba e trocar as cores dos botões para indicar qual aba está ativa.
      procedure ActiveDeactiveButton(AButton: TPanel; ATabSheet: TTabSheet);
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
   pnlButtonEndereco.Width := panel1.ClientWidth div 2;
   pnlButtonCreDev.Width := panel1.ClientWidth div 2;
   dtedtDataNasc.MaxDate := Date;
end;

procedure TfrmCadCredorDevedor.pnlButtonCreDevClick(Sender: TObject);
begin
   ActiveDeactiveButton(pnlButtonCreDev, TbShtEndereco);
end;

procedure TfrmCadCredorDevedor.pnlButtonEnderecoClick(Sender: TObject);
begin
   ActiveDeactiveButton(pnlButtonEndereco, TbShtCredorDevedor);
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
     on E: {EListError}Exception do
        ShowMessage('Endereço não encontrado com o CEP fornecido!');
   end;
end;

procedure TfrmCadCredorDevedor.dtedtDataNascExit(Sender: TObject);
begin
   if dtedtDataNasc.Text <> EmptyStr then
      lblIdade.Caption := CalculateAge(dtedtDataNasc.Date)
   else
      lblIdade.Caption := 'Idade não informada!';
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
   if Length(edtCpfCnpj.Text) = 0 then
      edtCpfCnpj.NumbersOnly := false;
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
   if Length(edtTelefone.Text) = 0 then
      edtTelefone.NumbersOnly := false;
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
      ACBrValidador.TipoDocto := docCNPJ;
      lblIdade.Visible := false;
   end
   else
   begin
      lblCpfCnpj.Visible := false;
      edtCpfCnpj.Visible := false;
   end;
end;

function TfrmCadCredorDevedor.ClearFormatting(const doc: string): string;
var
   i : integer;
   noMask : string = ''; // para receber o doc. sem a máscara.
begin
   for i := 1 to Length(doc) do
   begin
      if doc[i] in ['0'..'9'] then
         noMask := noMask + doc[i];
   end;
   result := noMask;
end;

procedure TfrmCadCredorDevedor.ActiveDeactiveButton(AButton: TPanel; ATabSheet: TTabSheet);
begin
   if (AButton.Name = 'pnlButtonCreDev') and (ATabSheet.Name = 'TbShtEndereco') then
   begin
      pcCadCredorDevedor.PageIndex := 0;
      AButton.BevelOuter := bvLowered;
      AButton.Color := $00C0DDC1;   // Verde Dinheiro
      pnlButtonEndereco.BevelOuter := bvRaised;
      pnlButtonEndereco.Color := $00D2EDF5; // Amarelo Creme
   end
   else
   if (AButton.Name = 'pnlButtonEndereco') and (ATabSheet.Name = 'TbShtCredorDevedor') then
   begin
      pcCadCredorDevedor.PageIndex := 1;
      AButton.BevelOuter := bvLowered;
      AButton.Color := $00C0DDC1; // Verde Dinheiro
      pnlButtonCreDev.BevelOuter := bvRaised;
      pnlButtonCreDev.Color := $00D2EDF5; // Amarelo Creme
   end;
end;

end.

