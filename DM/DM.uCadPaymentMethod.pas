unit DM.uCadPaymentMethod;

{$mode ObjFPC}{$H+}
// para a "function GetAll: TObjectList<TPaymentMethod>;" não dar erro no {mode ObjFPC}
// deve-se usar a palavra reservada "specilize".

// Mode Delphi, faz a declaração "function GetAll: TObjectList<TPaymentMethod>;" funcionar
//{$mode delphi} {$H+}

interface

uses
   Classes,
   SysUtils,
   ZDataset,
   Model.uPaymentMethod,
   Generics.Collections;

type

  { TDMPaymentMethod }

  TDMPaymentMethod = class
     qry: TZQuery;
     function Insert(PaymentMethod: TPaymentMethod): string;
     function Update(PaymentMethod: TPaymentMethod): string;
     function Delete(ID: Integer): string;
     function GetByID(ID: Integer): TPaymentMethod;
     function GetAll: specialize TObjectList<TPaymentMethod>;
  private
     function CreatePaymentMethodFromQuery: TPaymentMethod;
  public
     constructor Create;
     destructor Destroy; override;
  end;

implementation

uses
   DM.uConexao;

{ TDMPaymentMethod }

function TDMPaymentMethod.Insert(PaymentMethod: TPaymentMethod): string;
begin
   qry.SQL.Text := 'INSERT INTO TBL_FORMA_PAGAMENTO (NOME_FORMA_PAGAMENTO) VALUES (:Nome)';
   qry.ParamByName('Nome').AsString := PaymentMethod.Nome;
   try
      qry.ExecSQL;
      Result := 'OK';
   except on E: exception do
      Result := E.Message;
   end;
end;

function TDMPaymentMethod.Update(PaymentMethod: TPaymentMethod): string;
begin
   qry.SQL.Text := 'UPDATE TBL_FORMA_PAGAMENTO SET NOME_FORMA_PAGAMENTO = :Nome WHERE ID_FORMA_PAGAMENTO = :ID';
   qry.ParamByName('Nome').AsString := PaymentMethod.Nome;
   qry.ParamByName('ID').AsInteger := PaymentMethod.ID;
   try
      qry.ExecSQL;
      Result := 'OK';
   except on E: exception do
      Result := E.Message;
  end;
end;

function TDMPaymentMethod.Delete(ID: Integer): string;
begin
   qry.SQL.Text := 'DELETE FROM TBL_FORMA_PAGAMENTO WHERE ID_FORMA_PAGAMENTO = :ID';
   qry.ParamByName('ID').AsInteger := ID;
   try
      qry.ExecSQL;
      Result := 'OK';
   except on E: exception do
      Result := E.Message;
   end;
end;

function TDMPaymentMethod.GetByID(ID: Integer): TPaymentMethod;
begin
   qry.SQL.Text := 'SELECT * FROM TBL_FORMA_PAGAMENTO WHERE ID_FORMA_PAGAMENTO = :ID';
   qry.ParamByName('ID').AsInteger := ID;
   qry.Open;

   if not qry.IsEmpty then
      Result := CreatePaymentMethodFromQuery
   else
      Result := nil;
end;

function TDMPaymentMethod.GetAll: specialize TObjectList<TPaymentMethod>;
var
   List: specialize TObjectList<TPaymentMethod>;
   PaymentMethod: TPaymentMethod;
begin                                                 // 'true' para liberar os objetos automaticamente,
    List := specialize TObjectList<TPaymentMethod>.Create(true); // apesar de true ser o valor default
    qry.SQL.Text := 'SELECT * FROM TBL_FORMA_PAGAMENTO';
    qry.Open;

    while not qry.EOF do
    begin
       PaymentMethod := CreatePaymentMethodFromQuery;
       List.Add(PaymentMethod);
       qry.Next;
    end;
    Result := List;
end;

function TDMPaymentMethod.CreatePaymentMethodFromQuery: TPaymentMethod;
begin
   Result := TPaymentMethod.Create;
   Result.ID := qry.FieldByName('ID_FORMA_PAGAMENTO').AsInteger;
   Result.Nome := qry.FieldByName('NOME_FORMA_PAGAMENTO').AsString;
end;

constructor TDMPaymentMethod.Create;
begin
   qry.Connection := dmConexao.zconConexao;
end;

destructor TDMPaymentMethod.Destroy;
begin
   inherited Destroy;
end;

end.

