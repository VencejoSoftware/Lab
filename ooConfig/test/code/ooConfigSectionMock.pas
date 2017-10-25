{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooConfigSectionMock;

interface

uses
  ooTextKey,
  ooDataInput.Intf, ooDataOutput.Intf,
  ooConfig.Intf;

type
  TConfigSectionMock = class sealed(TInterfacedObject, IConfigSection)
  strict private
  const
    INTEGER_KEY = 'IntegerKey';
    STRING_KEY = 'StringKey';
    BOOLEAN_KEY = 'BooleanKey';
    FLOAT_KEY = 'FloatKey';
    DATETIME_KEY = 'DateTimeKey';
  public
    ValueInteger: Longint;
    ValueString: string;
    ValueBoolean: Boolean;
    ValueFloat: Extended;
    ValueDateTime: TDateTime;
    function Marshal(const DataOutput: IDataOutput): Boolean;
    function Unmarshal(const DataInput: IDataInput): Boolean;
    function Name: String;
    function Description: String;
    class function New: IConfigSection;
  end;

implementation

function TConfigSectionMock.Name: String;
begin
  Result := 'SECTION_ONE';
end;

function TConfigSectionMock.Description: String;
begin
  Result := 'Config mock';
end;

function TConfigSectionMock.Unmarshal(const DataInput: IDataInput): Boolean;
begin
  ValueInteger := DataInput.ReadInteger(TTextKey.New(INTEGER_KEY));
  ValueString := DataInput.ReadString(TTextKey.New(STRING_KEY));
  ValueBoolean := DataInput.ReadBoolean(TTextKey.New(BOOLEAN_KEY));
  ValueFloat := DataInput.ReadFloat(TTextKey.New(FLOAT_KEY));
  ValueDateTime := DataInput.ReadDateTime(TTextKey.New(DATETIME_KEY));
  Result := True;
end;

function TConfigSectionMock.Marshal(const DataOutput: IDataOutput): Boolean;
begin
  DataOutput.WriteInteger(TTextKey.New(INTEGER_KEY), ValueInteger);
  DataOutput.WriteString(TTextKey.New(STRING_KEY), ValueString);
  DataOutput.WriteBoolean(TTextKey.New(BOOLEAN_KEY), ValueBoolean);
  DataOutput.WriteFloat(TTextKey.New(FLOAT_KEY), ValueFloat);
  DataOutput.WriteDateTime(TTextKey.New(DATETIME_KEY), ValueDateTime);
  Result := True;
end;

class function TConfigSectionMock.New: IConfigSection;
begin
  Result := TConfigSectionMock.Create;
end;

end.
