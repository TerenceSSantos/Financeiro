unit Model.uPaymentMethod;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils;

type

    { TPaymentMethod }

    TPaymentMethod = class
     private
        FID: Integer;
        FNome: string;

        function GetID: Integer;
        function GetNome: string;
        procedure SetID(AValue: Integer);
        procedure SetNome(AValue: string);
     public
        property ID: Integer read GetID write SetID;
        property Nome: string read GetNome write SetNome;
    end;

implementation

{ TPaymentMethod }

procedure TPaymentMethod.SetNome(AValue: string);
begin
   if FNome = AValue then
      Exit;
   FNome := AValue;
end;

function TPaymentMethod.GetNome: string;
begin
   result := FNome;
end;

function TPaymentMethod.GetID: Integer;
begin
   result := FID;
end;

procedure TPaymentMethod.SetID(AValue: Integer);
begin
   if FID = AValue then
      Exit;
   FID := AValue;
end;

end.

