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
      tlbtnCadPayment: TToolButton;
      procedure tlbtnCadPaymentClick(Sender: TObject);
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
   View.uConfigurations,
   View.uCadNamePayments;

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

procedure TfrmPrincipal.tlbtnCadPaymentClick(Sender: TObject);
begin
   try
      frmTypePayment := TfrmTypePayment.Create(Self);
      frmTypePayment.ShowModal;
   finally
      FreeAndNil(frmTypePayment);
   end;
end;

end.

