{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Entry;

interface

uses
  Generics.Collections;

type
  TFSEntryKind = (ekUnknown, ekDrive, ekDirectory, ekFile);

  IFSEntry = interface
    ['{CDD73A1E-77F6-4A48-AE71-D460584CB8D9}']
    function Path: String;
    function Kind: TFSEntryKind;
  end;

  TFSEntry = class sealed(TInterfacedObject, IFSEntry)
  strict private
    _Path: String;
    _Kind: TFSEntryKind;
  public
    function Path: String;
    function Kind: TFSEntryKind;
    constructor Create(const Path: String; const Kind: TFSEntryKind);
    class function New(const Path: String; const Kind: TFSEntryKind): IFSEntry;
  end;

  TFSEntryList = class sealed(TList<IFSEntry>)
  public
    function IsEmpty: Boolean;
  end;

implementation

function TFSEntry.Path: String;
begin
  Result := _Path;
end;

function TFSEntry.Kind: TFSEntryKind;
begin
  Result := _Kind;
end;

constructor TFSEntry.Create(const Path: String; const Kind: TFSEntryKind);
begin
  _Path := Path;
  _Kind := Kind;
end;

class function TFSEntry.New(const Path: String; const Kind: TFSEntryKind): IFSEntry;
begin
  Result := TFSEntry.Create(Path, Kind);
end;

{ TFSEntryList }

function TFSEntryList.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

end.
