unit Controller.uPaymentMethod;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   Model.uPaymentMethod,
   View.uCadNamePayments,
   DM.uCadPaymentMethod;

type

   { TPaymentMethodController }

   TPaymentMethodController = class
   public
      function AddPaymentMethod(Nome: string): string;
      function EditPaymentMethod(ID: Integer; Nome: string): string;
      function DeletePaymentMethod(ID: Integer): string;
      function GetByName(const AName: string): string;
      function GetAllPaymentMethods: string;

   end;

implementation

{ TPaymentMethodController }

function TPaymentMethodController.AddPaymentMethod(Nome: string): string;
var
   paymentMethod : TPaymentMethod;
   DM : TDMPaymentMethod;
begin
   try
      paymentMethod := TPaymentMethod.Create;
      DM := TDMPaymentMethod.Create;
      paymentMethod.Nome := Nome;
      result := DM.Insert(paymentMethod);
   finally
      FreeAndNil(DM);
      FreeAndNil(paymentMethod);
   end;
end;

function TPaymentMethodController.EditPaymentMethod(ID: Integer;
   Nome: string): string;
var
   paymentMethod : TPaymentMethod;
   DM : TDMPaymentMethod;
begin
   try
      paymentMethod := TPaymentMethod.Create;
      DM := TDMPaymentMethod.Create;
//      paymentMethod := DM.GetByID(ID);
      PaymentMethod.Nome := Nome;
      Result := DM.Update(PaymentMethod);
   finally
      FreeAndNil(DM);
      FreeAndNil(paymentMethod);
   end;
end;

function TPaymentMethodController.DeletePaymentMethod(ID: Integer): string;
var
   DM : TDMPaymentMethod;
begin
   try
      DM := TDMPaymentMethod.Create;
      result := DM.Delete(ID);
   finally
      FreeAndNil(DM);
   end;
end;

function TPaymentMethodController.GetByName(const AName: string): string;
var
   DM : TDMPaymentMethod;
begin
   try
      DM := TDMPaymentMethod.Create;
      result := DM.GetByName(AName);
   finally
      FreeAndNil(DM);
   end;

end;

function TPaymentMethodController.GetAllPaymentMethods: string;
var
   DM : TDMPaymentMethod;
begin
   try
      DM := TDMPaymentMethod.Create;
      result := DM.GetAll;
   finally
      FreeAndNil(DM);
   end;
end;

end.

