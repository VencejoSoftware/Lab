{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit CondBetween;

interface

uses
  SysUtils,
  LogOpAnd,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TBetweenCondition = class sealed(TInterfacedObject, IFilterCondition)
  private
    _Key, _Value1, _Value2: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key, Value1, Value2: String);

    class function New(const Key, Value1, Value2: String): IFilterCondition;
  end;

implementation

function HasDynamicPrefix(const Value: String): Boolean;
begin
  Result := TrimLeft(Value)[1] = ':';
end;

function TBetweenCondition.IsEmpty: Boolean;
begin
  Result := (Length(_Value1) < 1) or (Length(_Value2) < 1);
end;

function TBetweenCondition.IsReplaceable: Boolean;
begin
  if IsEmpty then
    Result := False
  else
    Result := HasDynamicPrefix(_Value1) or HasDynamicPrefix(_Value2);
end;

function TBetweenCondition.IsValid: Boolean;
begin
  Result := (Length(_Key) > 0) and not IsEmpty;
end;

function TBetweenCondition.Key: String;
begin
  Result := _Key;
end;

function TBetweenCondition.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'BETWEEN', _Value1, TLogOpAnd.New.Parse(Beautify), _Value2]);
end;

constructor TBetweenCondition.Create(const Key, Value1, Value2: String);
begin
  _Key := Key;
  _Value1 := Value1;
  _Value2 := Value2;
end;

class function TBetweenCondition.New(const Key, Value1, Value2: String): IFilterCondition;
begin
  Result := TBetweenCondition.Create(Key, Value1, Value2);
end;

end.
