unit View.uCadNamePayments;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils, DB,
   Forms,
   Controls,
   Graphics,
   Dialogs,
   StdCtrls,
   DBGrids,
   ExtCtrls,
   ActnList, ZDataset,
   View.uFrameButtons;

type

   { TfrmTypePayment }

   TfrmTypePayment = class(TForm)
      dbgrdTypePay: TDBGrid;
      dsPayments: TDataSource;
      edtNamePayment: TEdit;
      frameBtnsPayments: TframeButtons;
      lblNamePayment: TLabel;
      shpUnderlineNamePay: TShape;
      zmemtblPayments: TZMemTable;
      procedure FormShow(Sender: TObject);
   private
      procedure LoadMemDataSet;
   public

   end;

var
   frmTypePayment: TfrmTypePayment;

implementation

uses
   Controller.uPaymentMethod,
   Model.uPaymentMethod;

{$R *.lfm}

{ TfrmTypePayment }

procedure TfrmTypePayment.FormShow(Sender: TObject);
begin
   LoadMemDataSet;
end;

procedure TfrmTypePayment.LoadMemDataSet;
var
   controllerPayMethod : TPaymentMethodController;
begin
   zmemtblPayments.Close;
   try
      controllerPayMethod := TPaymentMethodController.Create;
      zmemtblPayments.AssignDataFrom(controllerPayMethod.GetAllPaymentMethods);
      zmemtblPayments.Open;
   finally
      FreeAndNil(controllerPayMethod);
   end;
end;

end.

