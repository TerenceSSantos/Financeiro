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
   StdCtrls;

type

   { TfrmConfigurations }

   TfrmConfigurations = class(TForm)
      edtDocument: TEdit;
      edtName: TEdit;
      lblDocument: TLabel;
      lblName: TLabel;
      ntbkConfig: TNotebook;
      pageConfigConection: TPage;
      pageConfigMyData: TPage;
      pnlConfig: TPanel;
      rgTypePerson: TRadioGroup;
      txtTitulo: TStaticText;
      procedure FormCreate(Sender: TObject);
      procedure rgTypePersonSelectionChanged(Sender: TObject);
   private

   public

   end;

var
   frmConfigurations: TfrmConfigurations;

implementation

{$R *.lfm}

{ TfrmConfigurations }

procedure TfrmConfigurations.rgTypePersonSelectionChanged(Sender: TObject);
begin
   if rgTypePerson.ItemIndex = 0 then
      lblDocument.Caption := 'CPF'
   else
      lblDocument.Caption := 'CNPJ';
end;

procedure TfrmConfigurations.FormCreate(Sender: TObject);
begin
   txtTitulo.Font.Color := $00828200;    // + ou - clTeal
   txtTitulo.Color := $00C0DDC1;
end;

end.

