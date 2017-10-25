{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Directory;

interface

uses
  Windows, SysUtils,
  Generics.Collections,
  ooFS.Entry, ooFS.Drive;

type
  IFSDirectory = interface(IFSEntry)
    ['{7C577776-8DEA-4CB1-A20F-CF04A99174B1}']
    function Parent: IFSEntry;
    function Creation: TDateTime;
    function Modified: TDateTime;
    function Exists: Boolean;
  end;

  TFSDirectory = class sealed(TInterfacedObject, IFSDirectory)
  strict private
    _Parent: IFSEntry;
    _FSEntry: IFSEntry;
  public
    function Path: String;
    function Kind: TFSEntryKind;
    function Parent: IFSEntry;
    function Creation: TDateTime;
    function Modified: TDateTime;
    function Exists: Boolean;
    constructor Create(const Parent: IFSEntry; const Path: String);
    class function New(const Parent: IFSEntry; const Path: String): IFSDirectory;
  end;

  TFSDirectoryList = class sealed(TList<IFSDirectory>)
  public
    function IsEmpty: Boolean;
  end;

implementation

function TFSDirectory.Path: String;
begin
  Result := _FSEntry.Path;
end;

function TFSDirectory.Kind: TFSEntryKind;
begin
  Result := _FSEntry.Kind;
end;

function TFSDirectory.Parent: IFSEntry;
begin
  if not Assigned(_Parent) then
    _Parent := TFSDirectory.New(nil, ExtractFilePath(ExcludeTrailingPathDelimiter(Path)));
  Result := _Parent;
end;

function TFSDirectory.Exists: Boolean;
begin
  Result := DirectoryExists(Path);
end;

function TFSDirectory.Creation: TDateTime;
var
  Attrib: WIN32_FILE_ATTRIBUTE_DATA;
  SystemTime, LocalTime: TSystemTime;
begin
  GetFileAttributesEx(PChar(Path), GetFileExInfoStandard, @Attrib);
  if not FileTimeToSystemTime(Attrib.ftCreationTime, SystemTime) then
    RaiseLastOSError;
  if not SystemTimeToTzSpecificLocalTime(nil, SystemTime, LocalTime) then
    RaiseLastOSError;
  Result := SystemTimeToDateTime(LocalTime);
end;

function TFSDirectory.Modified: TDateTime;
var
  Attrib: WIN32_FILE_ATTRIBUTE_DATA;
  SystemTime, LocalTime: TSystemTime;
begin
  GetFileAttributesEx(PChar(Path), GetFileExInfoStandard, @Attrib);
  if not FileTimeToSystemTime(Attrib.ftLastWriteTime, SystemTime) then
    RaiseLastOSError;
  if not SystemTimeToTzSpecificLocalTime(nil, SystemTime, LocalTime) then
    RaiseLastOSError;
  Result := SystemTimeToDateTime(LocalTime);
end;

constructor TFSDirectory.Create(const Parent: IFSEntry; const Path: String);
begin
  _FSEntry := TFSEntry.New(IncludeTrailingPathDelimiter(Path), ekDirectory);
  _Parent := Parent;
end;

class function TFSDirectory.New(const Parent: IFSEntry; const Path: String): IFSDirectory;
begin
  Result := TFSDirectory.Create(Parent, Path);
end;

{ TFSDirectoryList }

function TFSDirectoryList.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

end.
