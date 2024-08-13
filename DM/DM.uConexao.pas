unit DM.uConexao;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   ZConnection;

type

   { TdmConexao }

   TdmConexao = class(TDataModule)
      zconConexao: TZConnection;
      procedure DataModuleCreate(Sender: TObject);
      procedure zconConexaoBeforeConnect(Sender: TObject);
   private
      procedure ConfigIni;
   public

   end;

var
   dmConexao: TdmConexao;

implementation

{$R *.lfm}

{ TdmConexao }

procedure TdmConexao.zconConexaoBeforeConnect(Sender: TObject);
begin
   with zconConexao do
   begin
      {$IfDef LINUX}
         Database := 'Financeiro';
      {$EndIf}
      Password := 'masterkey';
      User := 'SYSDBA';
      Protocol := 'firebird';
      Port := 30500;
      HostName := 'localhost';
   end;
end;

procedure TdmConexao.ConfigIni;
var
   arquivoIni : string;
   arquivo : TextFile;
begin
   AssignFile(arquivo, arquivoIni);
   Rewrite(arquivo);


end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
   zconConexao.Connect;
end;

end.

