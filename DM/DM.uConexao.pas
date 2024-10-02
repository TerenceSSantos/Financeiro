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
      procedure CheckAndCreateConfig;
   public

   end;

var
   dmConexao: TdmConexao;

implementation

uses
   IniFiles,
   Util.utilitarios;

{$R *.lfm}

{ TdmConexao }

procedure TdmConexao.zconConexaoBeforeConnect(Sender: TObject);
begin
   with zconConexao do
   begin
      Database := 'Financeiro';
      HostName := GetComputerName;
      Password := 'masterkey';
      User := 'SYSDBA';
      Protocol := 'firebird';
      Port := 30500;
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

procedure TdmConexao.CheckAndCreateConfig;
var
   ConfigFile: TIniFile;
   ConfigFileName: string;
begin
   ConfigFileName := ExtractFilePath(ParamStr(0)) + 'config.conf';

   // Verifica se o arquivo já existe
   if not FileExists(ConfigFileName) then
   begin
      ConfigFile := TIniFile.Create(ConfigFileName);
      try
         // Configurações padrão
         ConfigFile.WriteString('Database', 'Database', 'Financeiro');
         ConfigFile.WriteString('Database', 'Password', 'masterkey');
         ConfigFile.WriteString('Database', 'User', 'SYSDBA');
         ConfigFile.WriteString('Database', 'Protocol', 'firebird');
         ConfigFile.WriteInteger('Database', 'Port', 30500);
         ConfigFile.WriteString('Database', 'HostName','127.0.0.1');
      finally
         FreeAndNil(ConfigFile);
      end;
   end;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
var
   ConfigFile: TIniFile;
   ConfigFileName: string;
begin
    // Chama a função para verificar/criar o arquivo de configuração
   CheckAndCreateConfig;

   // Define o nome do arquivo de configuração
   ConfigFileName := ExtractFilePath(ParamStr(0)) + 'config.conf';
   ConfigFile := TIniFile.Create(ConfigFileName);

   try  {
      with zconConexao do
      begin
         Database := ConfigFile.ReadString('Database', 'Database', 'Financeiro');
         Password := ConfigFile.ReadString('Database', 'Password', 'masterkey');
         User := ConfigFile.ReadString('Database', 'User', 'SYSDBA');
         Protocol := ConfigFile.ReadString('Database', 'Protocol', 'firebird');
         Port := ConfigFile.ReadInteger('Database', 'Port', 30500);
         HostName := ConfigFile.ReadString('Database', 'HostName', '127.0.0.1');
      end;
       }
      // Conecta ao banco de dados
      zconConexao.Connect;
   finally
      FreeAndNil(ConfigFile);
   end;
end;

end.

