{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Drive;

interface

uses
  SysUtils,
  Generics.Collections,
  ooFS.Entry;

type
  TFSDriveAtribute = (daUnknown, daNoRootDir, daRemovable, daFixed, daRemote, daCDRom, daRamDisk);

  IFSDrive = interface(IFSEntry)
    ['{7C577776-8DEA-4CB1-A20F-CF04A99174B1}']
    function Attribute: TFSDriveAtribute;
  end;

  TFSDrive = class sealed(TInterfacedObject, IFSDrive)
  strict private
    _FSEntry: IFSEntry;
    _Attribute: TFSDriveAtribute;
  public
    function Path: String;
    function Kind: TFSEntryKind;
    function Attribute: TFSDriveAtribute;
    constructor Create(const Drive: String; const Attribute: TFSDriveAtribute);
    class function New(const Drive: String; const Attribute: TFSDriveAtribute): IFSDrive;
  end;

  TFSDrives = class sealed(TList<IFSDrive>)
  public
    function IsEmpty: Boolean;
  end;

implementation

function TFSDrive.Path: String;
begin
  Result := _FSEntry.Path;
end;

function TFSDrive.Kind: TFSEntryKind;
begin
  Result := _FSEntry.Kind;
end;

function TFSDrive.Attribute: TFSDriveAtribute;
begin
  Result := _Attribute;
end;

constructor TFSDrive.Create(const Drive: String; const Attribute: TFSDriveAtribute);
begin
  _FSEntry := TFSEntry.New(IncludeTrailingPathDelimiter(Drive), ekDrive);
  _Attribute := Attribute;
end;

class function TFSDrive.New(const Drive: String; const Attribute: TFSDriveAtribute): IFSDrive;
begin
  Result := TFSDrive.Create(Drive, Attribute);
end;

{ TFSDrives }

function TFSDrives.IsEmpty: Boolean;
begin
  Result := Count < 1;
end;

end.
