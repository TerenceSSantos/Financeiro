unit View.uConfigurations;

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
   StdCtrls,
   BCButtonFocus;

type

   { TfrmConfigurations }

   TfrmConfigurations = class(TForm)
      bcbtnConfig: TBCButtonFocus;
      bcbtnPersonData: TBCButtonFocus;
      edtDatabase: TEdit;
      edtDocument: TEdit;
      edtName: TEdit;
      lblDatabase: TLabel;
      lblDocument: TLabel;
      lblName: TLabel;
      ntbkConfig: TNotebook;
      pageConfigConection: TPage;
      pageConfigMyData: TPage;
      Panel1: TPanel;
      pnlConfig: TPanel;
      rgTypePerson: TRadioGroup;
      shpUnderlineCpfCnpj: TShape;
      shpUnderlineNome: TShape;
      shpUnderlineDatabase: TShape;
      txtTitulo: TStaticText;
      procedure bcbtnConfigClick(Sender: TObject);
      procedure bcbtnPersonDataClick(Sender: TObject);
      procedure edtDocumentChange(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure rgTypePersonSelectionChanged(Sender: TObject);
   private

   public

   end;

var
   frmConfigurations: TfrmConfigurations;

implementation

uses
   Util.utilitarios,
   ACBrValidador;

{$R *.lfm}

{ TfrmConfigurations }

procedure TfrmConfigurations.rgTypePersonSelectionChanged(Sender: TObject);
begin
   edtDocument.Clear;

   if rgTypePerson.ItemIndex = 0 then
   begin
      lblDocument.Caption := 'CPF';
      edtDocument.MaxLength := 11;
   end
   else
   begin
      lblDocument.Caption := 'CNPJ';
      edtDocument.MaxLength := 14;
   end;

   //  Para habilitar somente somente se estiver marcado
   if rgTypePerson.ItemIndex >= 0 then
      edtDocument.Enabled := true
   else
      edtDocument.Enabled := false;

   // Focar na campo text
   edtDocument.SetFocus;
end;

procedure TfrmConfigurations.FormCreate(Sender: TObject);
begin
   bcbtnConfig.Width := Panel1.ClientWidth div 2;
   bcbtnPersonData.Width := Panel1.ClientWidth div 2;
end;

procedure TfrmConfigurations.edtDocumentChange(Sender: TObject);
var
   validator : TACBrValidador;
begin
   validator := TACBrValidador.Create(nil);

   // Após inserir os 11 números do CPF, fazer a validação e formatação
   if (Length(edtDocument.Text) = 11) and (rgTypePerson.ItemIndex = 0) then
   begin
      validator.Documento := edtDocument.Text;
      validator.TipoDocto := docCPF;
      if validator.Validar then
      begin
         edtDocument.MaxLength := 14;
         edtDocument.NumbersOnly := false;
         edtDocument.Text := validator.Formatar;
      end
      else
      begin
         edtDocument.SetFocus;
      end;
   end

   else
   // Após inserir os 14 números do CNPJ, fazer a validação e formatação
   if (Length(edtDocument.Text) = 14) and (rgTypePerson.ItemIndex = 1) then
   begin
      validator.Documento := edtDocument.Text;
      validator.TipoDocto := docCNPJ;
      if validator.Validar then
      begin
         edtDocument.MaxLength := 18;
         edtDocument.NumbersOnly := false;
         edtDocument.Text := validator.Formatar;
      end
      else
      begin
         edtDocument.SetFocus;
      end;
   end;

   //  Tirar os pontos e traços quando apagar o texto já formatado
   if ((Length(edtDocument.Text) < 14) and (rgTypePerson.ItemIndex = 0)) or
      ((Length(edtDocument.Text) < 18) and (rgTypePerson.ItemIndex = 1)) then
   begin
      edtDocument.Text := ClearFormatting(edtDocument.Text);
   end;



   FreeAndNil(validator);
end;

procedure TfrmConfigurations.bcbtnPersonDataClick(Sender: TObject);
begin
   ntbkConfig.PageIndex := 1;
end;

procedure TfrmConfigurations.bcbtnConfigClick(Sender: TObject);
begin
   ntbkConfig.PageIndex := 0;
end;

end.

