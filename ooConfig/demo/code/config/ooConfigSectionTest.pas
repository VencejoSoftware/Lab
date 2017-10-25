{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooConfigSectionTest;

interface

uses
  ooTextKey,
  ooDataInput.Intf, ooDataOutput.Intf,
  ooConfig.Intf;

type
  TConfigSectionTest = class sealed(TInterfacedObject, IConfigSection)
  strict private
  const
    INT_KEY = 'IntegerValue';
    STR_KEY = 'StringValue';
    BOOL_KEY = 'BooleanValue';
  public
    ValueInteger: Longint;
    ValueString: string;
    ValueBoolean: Boolean;
    function Marshal(const DataOutput: IDataOutput): Boolean;
    function Unmarshal(const DataInput: IDataInput): Boolean;
    function Name: String;
    function Description: String;

    class function New: IConfigSection;
  end;

implementation

function TConfigSectionTest.Name: String;
begin
  Result := 'SECTION_TEST';
end;

function TConfigSectionTest.Description: String;
begin
  Result := 'Config test';
end;

function TConfigSectionTest.Unmarshal(const DataInput: IDataInput): Boolean;
begin
  ValueInteger := DataInput.ReadInteger(TTextKey.New(INT_KEY));
  ValueString := DataInput.ReadString(TTextKey.New(STR_KEY));
  ValueBoolean := DataInput.ReadBoolean(TTextKey.New(BOOL_KEY));
  Result := True;
end;

function TConfigSectionTest.Marshal(const DataOutput: IDataOutput): Boolean;
begin
  DataOutput.WriteInteger(TTextKey.New(INT_KEY), ValueInteger);
  DataOutput.WriteString(TTextKey.New(STR_KEY), ValueString);
  DataOutput.WriteBoolean(TTextKey.New(BOOL_KEY), ValueBoolean);
  Result := True;
end;

class function TConfigSectionTest.New: IConfigSection;
begin
  Result := TConfigSectionTest.Create;
end;

end.
