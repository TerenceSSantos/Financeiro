unit View.uCadNamePayments;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   DB,
   Forms,
   Controls,
   Graphics,
   Dialogs,
   StdCtrls,
   DBGrids,
   ExtCtrls,
   ActnList,
   fpjsonDataset,
   fpjson,
   View.uFrameButtons;

type

   { TfrmTypePayment }

   TfrmTypePayment = class(TForm)
      dbgrdTypePay: TDBGrid;
      dsPayments: TDataSource;
      edtNamePayment: TEdit;
      frameBtnsPayments: TframeButtons;
      jsondsPayMethods: TJSONDataSet;
      lblNamePayment: TLabel;
      shpUnderlineNamePay: TShape;
      procedure edtNamePaymentChange(Sender: TObject);
      procedure FormShow(Sender: TObject);
   private
      jsonArray : TJSONArray;
      procedure LoadJSONDataSet;
      procedure SearchByName(const AName: string);
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
   LoadJSONDataSet;
end;

procedure TfrmTypePayment.edtNamePaymentChange(Sender: TObject);
begin
   if Length(edtNamePayment.Text) >= 3 then
      SearchByName(edtNamePayment.Text)
   else
      LoadJSONDataSet;;
end;

procedure TfrmTypePayment.LoadJSONDataSet;
var
   controllerPayMethod : TPaymentMethodController;
   jsonString : string;
begin
   jsondsPayMethods.Close;
   controllerPayMethod := TPaymentMethodController.Create;
   try
      jsonString := controllerPayMethod.GetAllPaymentMethods;

      // Analisa a string JSON
      jsonArray := GetJSON(jsonString) as TJSONArray;

      // Exibe o JSON em uma caixa de mensagem
      //ShowMessage(jsonString);

      // Define OwnsData como True e os dados JSON serão destruídos quando o conjunto de dados for destruído
      jsondsPayMethods.OwnsData := true;

      // Os dados JSON são um array de objetos
      jsondsPayMethods.RowType := rtJSONObject;

      // Atribui os dados JSON ao conjunto de dados
      jsondsPayMethods.Rows := jsonArray;
      jsondsPayMethods.Open;
   finally
      FreeAndNil(controllerPayMethod);
   end;
end;

procedure TfrmTypePayment.SearchByName(const AName: string);
var
   controllerPayMethod : TPaymentMethodController;
   jsonString : string;
begin
   controllerPayMethod := TPaymentMethodController.Create;
   jsondsPayMethods.Close;

   try
      jsonString := controllerPayMethod.GetByName(AName);

      // Analisa a string JSON
      jsonArray := GetJSON(jsonString) as TJSONArray;

      // Define OwnsData como True e os dados JSON serão destruídos quando o conjunto de dados for destruído
      jsondsPayMethods.OwnsData := true;

      // Os dados JSON são um array de objetos
      jsondsPayMethods.RowType := rtJSONObject;

      // Atribui os dados JSON ao conjunto de dados
      jsondsPayMethods.Rows := jsonArray;
      jsondsPayMethods.Open;
   finally
      FreeAndNil(controllerPayMethod);
   end;
end;

end.

