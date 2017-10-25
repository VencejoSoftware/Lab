{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Archive;

interface

uses
  Windows, SysUtils,
  Generics.Collections,
  ooFS.Entry, ooFS.Directory;

type
  TFSArchiveAttribute = (fiaReadOnly, fiaHidden);
  TFSArchiveAttributeSet = set of TFSArchiveAttribute;

  IFSArchive = interface(IFSEntry)
    ['{DAF50D64-38DA-41C2-B61E-02E8C835ABCA}']
    function Parent: IFSEntry;
    function Name: String;
    function Creation: TDateTime;
    function Modified: TDateTime;
    function LastAccess: TDateTime;
    function Exists: Boolean;
    function Size: Integer;
    function Extension: String;
    function Attributes: TFSArchiveAttributeSet;
  end;

  TFSArchive = class sealed(TInterfacedObject, IFSArchive)
  strict private
    _Parent: IFSEntry;
    _FSEntry: IFSEntry;
  public
    function Path: String;
    function Kind: TFSEntryKind;
    function Parent: IFSEntry;
    function Name: String;
    function Creation: TDateTime;
    function Modified: TDateTime;
    function LastAccess: TDateTime;
    function Exists: Boolean;
    function Size: Integer;
    function Extension: String;
    function Attributes: TFSArchiveAttributeSet;

    constructor Create(const Parent: IFSEntry; const Path: String);
    class function New(const Parent: IFSEntry; const Path: String): IFSArchive;
  end;

  TFSArchiveList = class sealed(TList<IFSArchive>)
  public
    function IsEmpty: Boolean;
  end;

implementation

function TFSArchive.Path: String;
begin
  Result := _FSEntry.Path;
end;

function TFSArchive.Kind: TFSEntryKind;
begin
  Result := _FSEntry.Kind;
end;

function TFSArchive.Parent: IFSEntry;
begin
  if not Assigned(_Parent) then
    _Parent := TFSDirectory.New(nil, ExtractFilePath(Path));
  Result := _Parent;
end;

function TFSArchive.Exists: Boolean;
begin
  Result := FileExists(Path);
end;

function TFSArchive.Name: String;
begin
  Result := ExtractFileName(Path);
end;

function TFSArchive.Extension: String;
begin
  Result := ExtractFileExt(Path);
  if Length(Result) > 1 then
    Result := Copy(Result, 2, Pred(Length(Result)));
end;

function TFSArchive.Size: Integer;
var
  FileHandle: file of Byte;
begin
  try
    AssignFile(FileHandle, Path);
    try
      Reset(FileHandle);
      Result := FileSize(FileHandle);
    finally
      CloseFile(FileHandle);
    end;
  except
    Result := - 1;
  end;
end;

function TFSArchive.Creation: TDateTime;
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

function TFSArchive.LastAccess: TDateTime;
var
  Attrib: WIN32_FILE_ATTRIBUTE_DATA;
  SystemTime, LocalTime: TSystemTime;
begin
  GetFileAttributesEx(PChar(Path), GetFileExInfoStandard, @Attrib);
  if not FileTimeToSystemTime(Attrib.ftLastAccessTime, SystemTime) then
    RaiseLastOSError;
  if not SystemTimeToTzSpecificLocalTime(nil, SystemTime, LocalTime) then
    RaiseLastOSError;
  Result := SystemTimeToDateTime(LocalTime);
end;

function TFSArchive.Modified: TDateTime;
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

function TFSArchive.Attributes: TFSArchiveAttributeSet;
var
  Attrib: WIN32_FILE_ATTRIBUTE_DATA;
begin
  Result := [];
  GetFileAttributesEx(PChar(Path), GetFileExInfoStandard, @Attrib);
  if (Attrib.dwFileAttributes and FILE_ATTRIBUTE_READONLY) > 0 then
    Include(Result, fiaReadOnly);
  if (Attrib.dwFileAttributes and FILE_ATTRIBUTE_HIDDEN) > 0 then
    Include(Result, fiaHidden);
end;

constructor TFSArchive.Create(const Parent: IFSEntry; const Path: String);
begin
  _FSEntry := TFSEntry.New(Path, ekFile);
  _Parent := Parent;
end;

class function TFSArchive.New(const Parent: IFSEntry; const Path: String): IFSArchive;
begin
  Result := TFSArchive.Create(Parent, Path);
end;

{ TFSArchiveList }

function TFSArchiveList.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

end.
