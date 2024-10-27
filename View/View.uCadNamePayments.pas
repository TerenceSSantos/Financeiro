unit View.uCadNamePayments;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   Forms,
   Controls,
   Graphics,
   Dialogs,
   StdCtrls,
   DBGrids,
   ExtCtrls,
   ActnList,
   View.uFrameButtons;

type

   { TfrmTypePayment }

   TfrmTypePayment = class(TForm)
      dbgrdTypePay: TDBGrid;
      edtNamePayment: TEdit;
      frameBtnsPayments: TframeButtons;
      lblNamePayment: TLabel;
      shpUnderlineNamePay: TShape;
   private

   public

   end;

var
   frmTypePayment: TfrmTypePayment;

implementation

uses
   Controller.uPaymentMethod,
   Model.uPaymentMethod;

{$R *.lfm}

end.

