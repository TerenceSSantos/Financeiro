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
   DBGrids;

type

   { TfrmTypePayment }

   TfrmTypePayment = class(TForm)
      dbgrdTypePay: TDBGrid;
      edtNamePayment: TEdit;
      lblNamePayment: TLabel;
   private

   public

   end;

var
   frmTypePayment: TfrmTypePayment;

implementation

{$R *.lfm}

end.

