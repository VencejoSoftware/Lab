{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit CondEqual;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TEqualCondition = class sealed(TInterfacedObject, IFilterCondition)
  private
    _Key, _Value: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key, Value: String);

    class function New(const Key, Value: String): IFilterCondition;
  end;

implementation

function HasDynamicPrefix(const Value: String): Boolean;
begin
  Result := TrimLeft(Value)[1] = ':';
end;

function TEqualCondition.IsEmpty: Boolean;
begin
  Result := Length(_Value) < 1;
end;

function TEqualCondition.IsReplaceable: Boolean;
begin
  if IsEmpty then
    Result := False
  else
    Result := HasDynamicPrefix(_Value);
end;

function TEqualCondition.IsValid: Boolean;
begin
  Result := (Length(_Key) > 0) and not IsEmpty;
end;

function TEqualCondition.Key: String;
begin
  Result := _Key;
end;

function TEqualCondition.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, '=', _Value]);
end;

constructor TEqualCondition.Create(const Key, Value: String);
begin
  _Key := Key;
  _Value := Value;
end;

class function TEqualCondition.New(const Key, Value: String): IFilterCondition;
begin
  Result := TEqualCondition.Create(Key, Value);
end;

end.
