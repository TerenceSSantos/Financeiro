program prjFinanceiro;

{$mode objfpc}{$H+}

uses
   {$IFDEF UNIX}
   cthreads,
   {$ENDIF}
   {$IFDEF HASAMIGA}
   athreads,
   {$ENDIF}
   Interfaces, // this includes the LCL widgetset
   Forms,
   datetimectrls,
   zcomponent,
   View.uPrincipal,
   DM.uDMImagens,
   DM.uConexao,
   View.uCadCredorDevedor,
   View.uConfigurations,
   View.uCadNamePayments,
   Util.utilitarios,
   View.uFrameButtons,
   Model.uPaymentMethod,
   DM.uCadPaymentMethod, Controller.uPaymentMethod
   { you can add units after this };

{$R *.res}

begin
   RequireDerivedFormResource := True;
   Application.Scaled := True;
   Application.Initialize;
   Application.CreateForm(TdmConexao, dmConexao);
   Application.CreateForm(TdmImagens, dmImagens);
   Application.CreateForm(TfrmPrincipal, frmPrincipal);
   Application.Run;
end.

