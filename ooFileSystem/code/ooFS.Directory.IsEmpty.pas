{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Directory.IsEmpty;

interface

uses
  Windows, SysUtils,
  ooFS.Directory, ooFS.Archive, ooFS.Archive.Scan,
  ooFS.Command.Intf;

type
  IFSDirectoryIsEmpty = interface(IFSCommand<Boolean>)
    ['{EE614F18-5741-4F9E-96D7-D8695AEF8FC4}']
  end;

  TFSDirectoryIsEmpty = class sealed(TInterfacedObject, IFSDirectoryIsEmpty)
  strict private
    _Directory: IFSDirectory;
  public
    function Execute: Boolean;
    constructor Create(const Directory: IFSDirectory);
    class function New(const Directory: IFSDirectory): IFSDirectoryIsEmpty;
  end;

implementation

function TFSDirectoryIsEmpty.Execute: Boolean;
var
  ArchiveList: TFSArchiveList;
begin
  ArchiveList := TFSArchiveList.Create;
  try
    TFSArchiveScan.New(_Directory, ArchiveList).Execute;
    Result := ArchiveList.IsEmpty;
  finally
    ArchiveList.Free;
  end;
end;

constructor TFSDirectoryIsEmpty.Create(const Directory: IFSDirectory);
begin
  _Directory := Directory;
end;

class function TFSDirectoryIsEmpty.New(const Directory: IFSDirectory): IFSDirectoryIsEmpty;
begin
  Result := TFSDirectoryIsEmpty.Create(Directory);
end;

end.
