{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Archive.Rename;

interface

uses
  Windows, SysUtils,
  ooFS.Command.Delay,
  ooFS.Archive,
  ooFS.Command.Intf;

type
  IFSArchiveRename = interface(IFSCommand<Boolean>)
    ['{A51280AF-3CAA-4985-AC49-01D2D7086F96}']
  end;

  TFSArchiveRename = class sealed(TInterfacedObject, IFSArchiveRename)
  strict private
  const
    DELAY_IN_TRY = 200;
  strict private
    _Archive: IFSArchive;
    _DestinationFileName: String;
    _MaxTries: Byte;
  private
    function TryRename(const Tries: Byte): Boolean;
    function BuildDestinationFileName(const FileName, Destination: String): String;
  public
    function Execute: Boolean;
    constructor Create(const Archive: IFSArchive; const Destination: String; const MaxTries: Byte = 10);
    class function New(const Archive: IFSArchive; const Destination: String;
      const MaxTries: Byte = 10): IFSArchiveRename;
  end;

implementation

function TFSArchiveRename.TryRename(const Tries: Byte): Boolean;
begin
  Result := RenameFile(PChar(_Archive.Path), PChar(_DestinationFileName));
  if not Result and (Tries < _MaxTries) then
  begin
    TFSCommandDelay.New(DELAY_IN_TRY).Execute;
    Result := TryRename(Tries + 1);
  end;
end;

function TFSArchiveRename.Execute: Boolean;
begin
  Result := TryRename(0);
end;

function TFSArchiveRename.BuildDestinationFileName(const FileName, Destination: String): String;
begin
  if Length(ExtractFileName(Destination)) < 1 then
    Result := IncludeTrailingPathDelimiter(Destination) + _Archive.Name
  else
    Result := Destination;
end;

constructor TFSArchiveRename.Create(const Archive: IFSArchive; const Destination: String; const MaxTries: Byte);
begin
  _Archive := Archive;
  _MaxTries := MaxTries;
  _DestinationFileName := BuildDestinationFileName(_Archive.Path, Destination);
end;

class function TFSArchiveRename.New(const Archive: IFSArchive; const Destination: String;
  const MaxTries: Byte): IFSArchiveRename;
begin
  Result := TFSArchiveRename.Create(Archive, Destination, MaxTries);
end;

end.
