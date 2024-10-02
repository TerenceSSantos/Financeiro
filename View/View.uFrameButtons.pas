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
      status : TStatusDataSet;

      procedure StateButtons;
   public

   end;

implementation

{$R *.lfm}

{ TframeButtons }

procedure TframeButtons.bcbtnNewClick(Sender: TObject);
begin
   status := sdsInsert;
   StateButtons;
end;

procedure TframeButtons.bcbtnPostClick(Sender: TObject);
begin
   status := sdsPost;
   StateButtons;
end;

procedure TframeButtons.StateButtons;
begin
   if status in [sdsInsert, sdsEdit] then
   begin
      bcbtnNew.Enabled := false;
      bcbtnEdit.Enabled := false;
      bcbtnDelete.Enabled := false;
      bcbtnPost.Enabled := true;
      bcbtnCancel.Enabled := true;
   end;

   if status in [sdsBrowse, sdsCancel, sdsPost] then
   begin
      bcbtnNew.Enabled := true;
      bcbtnEdit.Enabled := true;
      bcbtnDelete.Enabled := true;
      bcbtnPost.Enabled := false;
      bcbtnCancel.Enabled := false;
   end;
end;

procedure TframeButtons.bcbtnEditClick(Sender: TObject);
begin
   status := sdsEdit;
   StateButtons;
end;

procedure TframeButtons.bcbtnDeleteClick(Sender: TObject);
begin
   status := sdsDelete;
   StateButtons;
end;

procedure TframeButtons.bcbtnCancelClick(Sender: TObject);
begin
   status := sdsCancel;
   StateButtons;
end;

end.

