{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Drives.Scan;

interface

uses
  Windows, SysUtils,
  ooFS.Command.Intf,
  ooFS.Drive;

type
  TFSDriveAtributeSet = set of TFSDriveAtribute;

  IFSDrivesScan = interface(IFSCommand<Integer>)
    ['{0C923969-0135-4855-A72C-47E7F35CE526}']
  end;

  TFSDrivesScan = class sealed(TInterfacedObject, IFSDrivesScan)
  strict private
    _Drives: TFSDrives;
    _Filter: TFSDriveAtributeSet;
  public
    function Execute: Integer;
    constructor Create(const Drives: TFSDrives; const Filter: TFSDriveAtributeSet = []);
    class function New(const Drives: TFSDrives; const Filter: TFSDriveAtributeSet = []): IFSDrivesScan;
  end;

implementation

function TFSDrivesScan.Execute: Integer;
var
  LogDrives: LongWord;
  Buffer: array [0 .. 128] of char;
  PDrive: PChar;
  Atribute: TFSDriveAtribute;
begin
  Result := 0;
  LogDrives := GetLogicalDriveStrings(SizeOf(Buffer), Buffer);
  if LogDrives = 0 then
    Exit;
  if LogDrives > SizeOf(Buffer) then
    raise Exception.Create(SysErrorMessage(ERROR_OUTOFMEMORY));
  PDrive := Buffer;
  while PDrive^ <> #0 do
  begin
    Atribute := TFSDriveAtribute(GetDriveType(PDrive));
    if Atribute in _Filter then
      _Drives.Add(TFSDrive.New(PDrive, Atribute));
    Inc(PDrive, 4);
  end;
  Result := _Drives.Count;
end;

constructor TFSDrivesScan.Create(const Drives: TFSDrives; const Filter: TFSDriveAtributeSet);
begin
  _Drives := Drives;
  _Filter := Filter;
end;

class function TFSDrivesScan.New(const Drives: TFSDrives; const Filter: TFSDriveAtributeSet): IFSDrivesScan;
begin
  Result := TFSDrivesScan.Create(Drives, Filter);
end;

end.
