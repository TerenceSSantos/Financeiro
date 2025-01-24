unit DM.uCadPaymentMethod;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   ZDataset,
   Model.uPaymentMethod,
   fpjson,
   fpjsondataset;

type

  { TDMPaymentMethod }

  TDMPaymentMethod = class
     qry: TZQuery;
     function Insert(PaymentMethod: TPaymentMethod): string;
     function Update(PaymentMethod: TPaymentMethod): string;
     function Delete(ID: Integer): string;
//     function GetByID(ID: Integer): TPaymentMethod;
     function GetAll: string;
     function GetByName(const AName: string) : string;
//     function GetAll: specialize TObjectList<TPaymentMethod>;
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

function TDMPaymentMethod.GetByName(const AName: string): string;
var
   jsonArray : TJSONArray;
   jsonObject : TJSONObject;
begin
   qry.SQL.Text := 'SELECT * FROM TBL_FORMA_PAGAMENTO WHERE NOME_FORMA_PAGAMENTO CONTAINING ' + QuotedStr(AName);
   qry.Open;

   if not qry.IsEmpty then
   begin
      // Criar um novo array JSON
      jsonArray := TJSONArray.Create;

      try
         // Iterar pelos registros da consulta
         while not qry.EOF do
         begin
            // Criar e adicionar um objeto diretamente ao array
            jsonObject := TJSONObject.Create;

            // Adicionar os campos da consulta com propriedades do objeto
            jsonObject.Add('ID_FORMA_PAGAMENTO', qry.FieldByName('ID_FORMA_PAGAMENTO').AsInteger);
            jsonObject.Add('NOME_FORMA_PAGAMENTO', qry.FieldByName('NOME_FORMA_PAGAMENTO').AsString);

            jsonArray.Add(jsonObject);

            qry.Next;
         end;

         //converter o array para string JSON
         Result := jsonArray.FormatJSON;

      finally
         FreeAndNil(jsonArray);
      end;
   end
   else
      Result := EmptyStr;
end;

function TDMPaymentMethod.GetAll: string;
var
   jsonArray : TJSONArray;
   jsonObject : TJSONObject;
begin
   qry.SQL.Text := 'SELECT * FROM TBL_FORMA_PAGAMENTO';
   qry.Open;

   // Criar um novo array json
   jsonArray := TJSONArray.Create;

   try
      // Iterar pelos registros da consulta
      while not qry.EOF do
      begin
         // Criar e adicionar um objeto diretamente ao array
        jsonObject := TJSONObject.Create;

        // Adicionar os campos da consulta como propriedades do objeto
        jsonObject.Add('ID_FORMA_PAGAMENTO', qry.FieldByName('ID_FORMA_PAGAMENTO').AsInteger);
        jsonObject.Add('NOME_FORMA_PAGAMENTO', qry.FieldByName('NOME_FORMA_PAGAMENTO').AsString);

        jsonArray.Add(jsonObject);

        qry.Next;
      end;

      // Converter o array para string JSON
      result := jsonArray.FormatJSON;
   finally
      // Liberar memória do array (ele gerencia automaticamente os objetos internos)
      FreeAndNil(jsonArray);
   end;
end;

function TDMPaymentMethod.CreatePaymentMethodFromQuery: TPaymentMethod;
begin
   Result := TPaymentMethod.Create;
   Result.ID := qry.FieldByName('ID_FORMA_PAGAMENTO').AsInteger;
   Result.Nome := qry.FieldByName('NOME_FORMA_PAGAMENTO').AsString;
end;

constructor TDMPaymentMethod.Create;
begin
   inherited;
   qry := TZQuery.Create(nil);
   qry.Connection := dmConexao.zconConexao;
end;

destructor TDMPaymentMethod.Destroy;
begin
   inherited Destroy;
end;

end.

