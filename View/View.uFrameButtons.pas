unit View.uFrameButtons;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   Forms,
   Controls,
   StdCtrls,
   ExtCtrls,
   BCButtonFocus;

type

   // Indicação da operação a ser realizada.
   TStatusDataSet = (sdsBrowse, sdsInsert, sdsEdit, sdsDelete, sdsPost, sdsCancel);

   // Declaração de eventos
   TOnActionEvent = procedure(Status: TStatusDataSet) of object;

   { TframeButtons }

   TframeButtons = class(TFrame)
      bcbtnNew: TBCButtonFocus;
      bcbtnEdit: TBCButtonFocus;
      bcbtnDelete: TBCButtonFocus;
      bcbtnPost: TBCButtonFocus;
      bcbtnCancel: TBCButtonFocus;
      pnlButtonsLeft: TPanel;
      pnlButtonsRight: TPanel;
      procedure bcbtnCancelClick(Sender: TObject);
      procedure bcbtnDeleteClick(Sender: TObject);
      procedure bcbtnEditClick(Sender: TObject);
      procedure bcbtnNewClick(Sender: TObject);
      procedure bcbtnPostClick(Sender: TObject);
   private
      FOnAction: TOnActionEvent;
      FStatus: TStatusDataSet;

      procedure SetStatus(AStatus: TStatusDataSet);
      procedure UpdateButtons;
   public
      constructor Create(AOwner: TComponent); override;
      property Status: TStatusDataSet read FStatus write SetStatus;
      property OnAction: TOnActionEvent read FOnAction write FOnAction;
   end;

implementation

{$R *.lfm}

{ TframeButtons }

procedure TframeButtons.bcbtnNewClick(Sender: TObject);
begin
   status := sdsInsert;
end;

procedure TframeButtons.bcbtnPostClick(Sender: TObject);
begin
   status := sdsPost;
end;

procedure TframeButtons.UpdateButtons;
begin
   case FStatus of
      sdsBrowse,
      sdsCancel,
      sdsPost   : begin
                     bcbtnNew.Enabled := true;
                     bcbtnEdit.Enabled := true;
                     bcbtnDelete.Enabled := true;
                     bcbtnPost.Enabled := false;
                     bcbtnCancel.Enabled := false;
                  end;
      sdsInsert,
      sdsEdit   : begin
                     bcbtnNew.Enabled := false;
                     bcbtnEdit.Enabled := false;
                     bcbtnDelete.Enabled := false;
                     bcbtnPost.Enabled := true;
                     bcbtnCancel.Enabled := true;
                  end;
   end;
end;

procedure TframeButtons.SetStatus(AStatus: TStatusDataSet);
begin
   if FStatus <> AStatus then
   begin
      FStatus := AStatus;
      UpdateButtons;

      // Dispara o evento quando o status mudar
      if Assigned(FOnAction) then
         FOnAction(FStatus);
   end;
end;

constructor TframeButtons.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FStatus := sdsBrowse;  // Estado inicial
   UpdateButtons;
end;

procedure TframeButtons.bcbtnEditClick(Sender: TObject);
begin
   status := sdsEdit;
end;

procedure TframeButtons.bcbtnDeleteClick(Sender: TObject);
begin
   status := sdsDelete;
end;

procedure TframeButtons.bcbtnCancelClick(Sender: TObject);
begin
   status := sdsCancel;
end;

end.

