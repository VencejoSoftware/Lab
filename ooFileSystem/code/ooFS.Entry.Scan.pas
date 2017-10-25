{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Entry.Scan;

interface

uses
  Windows, SysUtils,
  ooFS.Command.Intf,
  ooFS.Entry, ooFS.Directory, ooFS.Archive;

type
  IFSEntryScan = interface(IFSCommand<Integer>)
    ['{9D3749A6-724D-4199-B675-08A577B98069}']
  end;

  TFSEntryScan = class sealed(TInterfacedObject, IFSEntryScan)
  strict private
    _Path: IFSEntry;
    _EntryList: TFSEntryList;
    _Recursively: Boolean;
    _FilterMask: String;
  private
    procedure ScanPath(const Path: IFSEntry; const EntryList: TFSEntryList; const Recursively: Boolean;
      const FilterMask: String);
    function IsFolder(const SearchRec: TSearchRec): Boolean;
    function IsFile(const SearchRec: TSearchRec): Boolean;
  public
    function Execute: Integer;
    constructor Create(const Path: IFSEntry; const EntryList: TFSEntryList; const Recursively: Boolean;
      const FilterMask: String);
    class function New(const Path: IFSEntry; const EntryList: TFSEntryList; const Recursively: Boolean;
      const FilterMask: String = '*.*'): IFSEntryScan;
  end;

implementation

function TFSEntryScan.IsFile(const SearchRec: TSearchRec): Boolean;
begin
{$WARN SYMBOL_PLATFORM OFF}
  Result := ((SearchRec.Attr and faArchive) <> 0) or ((SearchRec.Attr and faNormal) <> 0) or
    ((SearchRec.Attr and faTemporary) <> 0);
{$WARN SYMBOL_PLATFORM ON}
end;

function TFSEntryScan.IsFolder(const SearchRec: TSearchRec): Boolean;
const
  CURRENT_FOLDER = '.';
  PARENT_FOLDER = '..';
begin
  Result := ((SearchRec.Attr and faDirectory) <> 0) and (SearchRec.Name <> CURRENT_FOLDER) and
    (SearchRec.Name <> PARENT_FOLDER);
end;

procedure TFSEntryScan.ScanPath(const Path: IFSEntry; const EntryList: TFSEntryList; const Recursively: Boolean;
  const FilterMask: String);
var
  SearchRec: TSearchRec;
  Entry: IFSEntry;
begin
  if FindFirst(Path.Path + FilterMask, faAnyFile, SearchRec) = 0 then
    try
      repeat
        if IsFolder(SearchRec) then
        begin
          Entry := TFSDirectory.New(Path, Path.Path + SearchRec.Name);
          EntryList.Add(Entry);
          if Recursively then
            ScanPath(Entry, EntryList, Recursively, FilterMask);
        end
        else
          if IsFile(SearchRec) then
          begin
            Entry := TFSArchive.New(Path, Path.Path + SearchRec.Name);
            EntryList.Add(Entry);
          end;
      until FindNext(SearchRec) <> 0;
    finally
      FindClose(SearchRec);
    end;
end;

function TFSEntryScan.Execute: Integer;
begin
  ScanPath(_Path, _EntryList, _Recursively, _FilterMask);
  Result := _EntryList.Count;
end;

constructor TFSEntryScan.Create(const Path: IFSEntry; const EntryList: TFSEntryList; const Recursively: Boolean;
  const FilterMask: String);
begin
  _Path := Path;
  _EntryList := EntryList;
  _Recursively := Recursively;
  _FilterMask := FilterMask;
end;

class function TFSEntryScan.New(const Path: IFSEntry; const EntryList: TFSEntryList; const Recursively: Boolean;
  const FilterMask: String): IFSEntryScan;
begin
  Result := TFSEntryScan.Create(Path, EntryList, Recursively, FilterMask);
end;

end.
