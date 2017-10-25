{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Archive.InUse;

interface

uses
  Windows, SysUtils, Forms,
  ooFS.Archive,
  ooFS.Command.Intf;

type
  IFSArchiveInUse = interface(IFSCommand<Boolean>)
    ['{E4E10314-3233-4463-860D-9D07C003482C}']
  end;

  TFSArchiveInUse = class sealed(TInterfacedObject, IFSArchiveInUse)
  strict private
    _Archive: IFSArchive;
  public
    function Execute: Boolean;
    constructor Create(const Archive: IFSArchive);
    class function New(const Archive: IFSArchive): IFSArchiveInUse;
  end;

implementation

function TFSArchiveInUse.Execute: Boolean;
var
  FileHandle: HFILE;
begin
  Result := False;
  if not _Archive.Exists then
    Exit;
  FileHandle := CreateFile(PChar(_Archive.Path), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0);
  Result := (FileHandle = INVALID_HANDLE_VALUE);
  CloseHandle(FileHandle);
end;

constructor TFSArchiveInUse.Create(const Archive: IFSArchive);
begin
  _Archive := Archive;
end;

class function TFSArchiveInUse.New(const Archive: IFSArchive): IFSArchiveInUse;
begin
  Result := TFSArchiveInUse.Create(Archive);
end;

end.
