unit Controller.uPaymentMethod;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   Model.uPaymentMethod,
   View.uCadNamePayments,
   DM.uCadPaymentMethod,
   Generics.Collections;

type

   { TPaymentMethodController }

   TPaymentMethodController = class
   public
      function AddPaymentMethod(Nome: string): string;
      function EditPaymentMethod(ID: Integer; Nome: string): string;
      function DeletePaymentMethod(ID: Integer): string;
      function GetPaymentMethodByID(ID: Integer): TPaymentMethod;
      function GetAllPaymentMethods: specialize TObjectList<TPaymentMethod>;
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
      paymentMethod := DM.GetByID(ID);
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

function TPaymentMethodController.GetPaymentMethodByID(ID: Integer): TPaymentMethod;
var
   DM : TDMPaymentMethod;
begin
   try
      DM := TDMPaymentMethod.Create;
      result := DM.GetByID(ID);
   finally
      FreeAndNil(DM);
   end;

end;

function TPaymentMethodController.GetAllPaymentMethods: specialize TObjectList<TPaymentMethod>;
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

