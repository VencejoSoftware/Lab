{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooINIConfig;

interface

uses
  INIFiles,
  ooINI.DataInput, ooINI.DataOutput,
  ooConfig.Intf;

type
  TINIConfig = class sealed(TInterfacedObject, IConfig)
  strict private
    _IniFile: TIniFile;
  public
    function LoadSection(const ConfigSection: IConfigSection): Boolean;
    function SaveSection(const ConfigSection: IConfigSection): Boolean;
    constructor Create(const FileName: String);
    destructor Destroy; override;
    class function New(const FileName: String): IConfig;
  end;

implementation

function TINIConfig.LoadSection(const ConfigSection: IConfigSection): Boolean;
begin
  ConfigSection.Unmarshal(TINIDataInput.New(_IniFile, ConfigSection.Name));
  Result := True;
end;

function TINIConfig.SaveSection(const ConfigSection: IConfigSection): Boolean;
begin
  ConfigSection.Marshal(TINIDataOutput.New(_IniFile, ConfigSection.Name));
  Result := True;
end;

constructor TINIConfig.Create(const FileName: String);
begin
  _IniFile := TIniFile.Create(FileName);
end;

destructor TINIConfig.Destroy;
begin
  _IniFile.Destroy;
  inherited;
end;

class function TINIConfig.New(const FileName: String): IConfig;
begin
  Result := TINIConfig.Create(FileName);
end;

end.
