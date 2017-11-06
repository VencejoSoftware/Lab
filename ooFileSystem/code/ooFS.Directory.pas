{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Directory object
  @created(10/02/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooFS.Directory;

interface

uses
  Windows, SysUtils,
  Generics.Collections,
  ooFS.Entry, ooFS.Drive;

type
{$REGION 'documentation'}
{
  @abstract(Interface of directory definition)
  @member(
    Parent Directory parent path
    @return(@link(IFSEntry parent object))
  )
  @member(
    AbsolutePath Full directory path
    @return(String with the absolute path)
  )
  @member(
    Creation Return creation datetime
    @return(DateTime with archive creation time)
  )
  @member(
    Modified Return modified datetime
    @return(DateTime with archive modification time)
  )
  @member(
    Exists Check if archive exist
    @return(@true if exists, @false if not)
  )
}
{$ENDREGION}
  IFSDirectory = interface(IFSEntry)
    ['{7C577776-8DEA-4CB1-A20F-CF04A99174B1}']
    function Parent: IFSEntry;
    function AbsolutePath: String;
    function Creation: TDateTime;
    function Modified: TDateTime;
    function Exists: Boolean;
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IFSDirectory))
  Directory object
  @member(Path @seealso(IFSEntry.Path))
  @member(Kind @seealso(IFSEntry.Kind))
  @member(Parent @seealso(IFSDirectory.Parent))
  @member(AbsolutePath @seealso(IFSDirectory.AbsolutePath))
  @member(Creation @seealso(IFSDirectory.Creation))
  @member(Modified @seealso(IFSDirectory.Modified))
  @member(Exists @seealso(IFSDirectory.Exists))
  @member(
    Create Object constructor
    @param(Parent @link(IFSEntry Parent object))
    @param(Path Directory path)
  )
  @member(
    New Create a new @classname as interface
    @param(Parent @link(IFSEntry Parent object))
    @param(Path Directory path)
  )
}
{$ENDREGION}

  TFSDirectory = class sealed(TInterfacedObject, IFSDirectory)
  strict private
    _Parent: IFSEntry;
    _FSEntry: IFSEntry;
  private
    function BuildParent: IFSEntry;
  public
    function Path: String;
    function AbsolutePath: String;
    function Kind: TFSEntryKind;
    function Parent: IFSEntry;
    function Creation: TDateTime;
    function Modified: TDateTime;
    function Exists: Boolean;
    constructor Create(const Parent: IFSEntry; const Path: String);
    class function New(const Parent: IFSEntry; const Path: String): IFSDirectory;
  end;
{$REGION 'documentation'}
{
  @abstract(Collection of @link(IFSDirectory directories))
  @member(
    IsEmpty Check if the list is empty
    @param(@true if not has items, @false if has items)
  )
}
{$ENDREGION}

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

function TFSDirectory.AbsolutePath: String;
begin
  if Exists then
    Result := ExpandFileName(_FSEntry.Path)
  else
    Result := _FSEntry.Path;
end;

function TFSDirectory.BuildParent: IFSEntry;
var
  ParentPath: String;
  Drive: IFSDrive;
begin
  Result := nil;
  if Length(AbsolutePath) > 1 then
  begin
    Drive := TFSDrive.New(ExtractFileDrive(AbsolutePath), Unknown);
    ParentPath := ExtractRelativePath(Drive.Path, ExtractFilePath(ExcludeTrailingPathDelimiter(AbsolutePath)));
    Result := TFSDirectory.New(Drive, ParentPath);
  end;
end;

function TFSDirectory.Parent: IFSEntry;
begin
  if not Assigned(_Parent) then
    _Parent := BuildParent;
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
  _FSEntry := TFSEntry.New(IncludeTrailingPathDelimiter(Path), TFSEntryKind.Directory);
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
