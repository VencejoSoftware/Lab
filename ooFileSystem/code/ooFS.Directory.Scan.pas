{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Directory.Scan;

interface

uses
  Windows, SysUtils,
  ooFS.Command.Intf,
  ooFS.Entry, ooFS.Directory;

type
  IFSDirectoryScan = interface(IFSCommand<Integer>)
    ['{719B95CE-7C05-4266-9455-1E977E492133}']
  end;

  TFSDirectoryScan = class sealed(TInterfacedObject, IFSDirectoryScan)
  strict private
    _Path: IFSEntry;
    _DirectoryList: TFSDirectoryList;
    _Recursively: Boolean;
  private
    function IsRealDirectory(const Name: String): Boolean;
    procedure ScanPath(const Path: IFSEntry; const DirectoryList: TFSDirectoryList; const Recursively: Boolean);
  public
    function Execute: Integer;
    constructor Create(const Path: IFSEntry; const DirectoryList: TFSDirectoryList; const Recursively: Boolean);
    class function New(const Path: IFSEntry; const DirectoryList: TFSDirectoryList;
      const Recursively: Boolean): IFSDirectoryScan;
  end;

implementation

function TFSDirectoryScan.IsRealDirectory(const Name: String): Boolean;
const
  CURRENT = '.';
  PARENT = '..';
begin
  Result := (Name <> CURRENT) and (Name <> PARENT);
end;

procedure TFSDirectoryScan.ScanPath(const Path: IFSEntry; const DirectoryList: TFSDirectoryList;
  const Recursively: Boolean);
var
  SearchRec: TSearchRec;
  Directory: IFSDirectory;
begin
  if FindFirst(Path.Path + '*', faDirectory, SearchRec) = 0 then
    try
      repeat
        if IsRealDirectory(SearchRec.Name) then
        begin
          Directory := TFSDirectory.New(Path, Path.Path + SearchRec.Name);
          DirectoryList.Add(Directory);
          if Recursively then
            ScanPath(Directory, DirectoryList, Recursively);
        end;
      until FindNext(SearchRec) <> 0;
    finally
      FindClose(SearchRec);
    end;
end;

function TFSDirectoryScan.Execute: Integer;
begin
  ScanPath(_Path, _DirectoryList, _Recursively);
  Result := _DirectoryList.Count;
end;

constructor TFSDirectoryScan.Create(const Path: IFSEntry; const DirectoryList: TFSDirectoryList;
  const Recursively: Boolean);
begin
  _Path := Path;
  _DirectoryList := DirectoryList;
  _Recursively := Recursively;
end;

class function TFSDirectoryScan.New(const Path: IFSEntry; const DirectoryList: TFSDirectoryList;
  const Recursively: Boolean): IFSDirectoryScan;
begin
  Result := TFSDirectoryScan.Create(Path, DirectoryList, Recursively);
end;

end.
