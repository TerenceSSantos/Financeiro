unit Util.utilitarios;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   fphttpclient,
   DateUtils,
   {$IFDEF MSWINDOWS}
   Windows;  // para Windows API pegar o nome do computador
   {$ENDIF}
   {$IFDEF UNIX}
   Unix;   // para Linux API pegar o nome do computador
   {$ENDIF}

   // função para testar se existe conexão com a internet
function TestInternetConnection: Boolean;

   // função para calcular a idade.
function CalculateAge(ABirthDate: TDate): string;

   //   função para retornar o nome do computador
function GetComputerName: string;

   // Retirar a formatação e retornar somente os números
function ClearFormatting(const doc: string): string;

implementation

function TestInternetConnection: Boolean;
var
  HTTPClient: TFPHTTPClient;
begin
  HTTPClient := TFPHTTPClient.Create(nil);
  try
    try
       HTTPClient.SimpleGet('http://www.google.com');
       Result := True;
    except
       Result := False;
    end;
  finally
     HTTPClient.Free;
  end;
end;

function CalculateAge(ABirthDate: TDate): string;
var
  months, years, days : word;
  actualDate : TDate;
  textYear, textMonth, textDay : string;
begin
   textYear := EmptyStr;
   textMonth := EmptyStr;
   textDay := EmptyStr;
   result := EmptyStr;
   actualDate := Date;
   months := 0;
   years := 0;
   days := 0;

   //   Procedimento da DateUtil que realiza o cálculo dos anos, meses e dias entre 2 datas
   PeriodBetween(actualDate, ABirthDate, years, months, days);

//       ***** A seguir a formatação do texto da idade em dias, meses e anos. *****

         {** ANOS **}
   if years > 0 then
      if years = 1 then
         textYear := IntToStr(years) + ' ano'
      else
         textYear := IntToStr(years) + ' anos';

         {** MESES **}
   if months > 0 then
      if months = 1 then
         textMonth := IntToStr(months) + ' mês'
      else
         textMonth := IntToStr(months) + ' meses';

         {** DIAS **}
//   day := DaysBetween(actualDate, ABirthDate);
   if  days > 0 then
      if days = 1 then
         textDay := IntToStr(days) + ' dia'
      else
         textDay := IntToStr(days) + ' dias';


   if textYear <> EmptyStr then
      result := textYear;


   if textMonth <> EmptyStr then
   begin
      if result <> EmptyStr then
         result := result + ' ' + textMonth
      else
         result := textMonth;
   end;


   if textDay <> EmptyStr then
   begin
      if result <> EmptyStr then
         result := result + ' ' + textDay
      else
         result := textDay;
   end;

//  Result := Format('%d anos, %d meses e %d dias', [years, months, days]);
end;

function GetComputerName: string;
{$IFDEF MSWINDOWS}
var
  Buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: DWORD;
{$ENDIF}

begin
  {$IFDEF MSWINDOWS}
  // Código para Windows
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  if Windows.GetComputerName(Buffer, Size) then
    Result := StrPas(Buffer)
  else
    Result := 'Desconhecido';
  {$ENDIF}

  {$IFDEF UNIX}
  // Código para Linux/Unix
      // Obtém o hostname do sistema
    Result := GetHostName;
  {$ENDIF}
end;

function ClearFormatting(const doc: string): string;
var
   i : integer;
   noMask : string = ''; // para receber o doc. sem a máscara.
begin
   for i := 1 to Length(doc) do
   begin
      if doc[i] in ['0'..'9'] then
         noMask := noMask + doc[i];
   end;
   result := noMask;
end;

end.

