unit DM.uDMImagens;

{$mode ObjFPC}{$H+}

interface

uses
   Classes,
   SysUtils,
   Controls;

type

   { TdmImagens }

   TdmImagens = class(TDataModule)
      imglstImagens: TImageList;
   private

   public

   end;

var
   dmImagens: TdmImagens;

implementation

{$R *.lfm}

end.

