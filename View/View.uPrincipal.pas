unit View.uPrincipal;

{$mode objfpc}{$H+}

interface

uses
   Classes,
   SysUtils,
   Forms,
   Controls,
   Graphics,
   Dialogs,
   ExtCtrls,
   ComCtrls;

type

   { TfrmPrincipal }

   TfrmPrincipal = class(TForm)
      pnlBarraFerramentasPrincipal: TPanel;
      tlbarPrincipal: TToolBar;
      tlbtnConfiguracoes: TToolButton;
      tlbtnCredorDevedor: TToolButton;
      procedure tlbtnConfiguracoesClick(Sender: TObject);
      procedure tlbtnCredorDevedorClick(Sender: TObject);
   private

   public

   end;

var
   frmPrincipal: TfrmPrincipal;

implementation

uses
   View.uCadCredorDevedor,
   View.uConfigurations;

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.tlbtnCredorDevedorClick(Sender: TObject);
begin
   try
      frmCadCredorDevedor := TfrmCadCredorDevedor.Create(self);
      frmCadCredorDevedor.ShowModal;
   finally
      FreeAndNil(frmCadCredorDevedor);
   end;

end;

procedure TfrmPrincipal.tlbtnConfiguracoesClick(Sender: TObject);
begin
   try
      frmConfigurations := TfrmConfigurations.Create(Self);
      frmConfigurations.ShowModal;
   finally
      FreeAndNil(frmConfigurations);
   end;
end;

end.

