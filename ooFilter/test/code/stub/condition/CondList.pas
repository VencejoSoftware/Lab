{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit CondList;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TListCondition = class sealed(TInterfacedObject, IFilterCondition)
  private
    _Key: String;
    _Values: Array of string;
    function PlainValues: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key: String; const Values: Array of string);

    class function New(const Key: String; const Values: Array of string): IFilterCondition;
  end;

implementation

function HasDynamicPrefix(const Value: String): Boolean;
begin
  Result := TrimLeft(Value)[1] = ':';
end;

function TListCondition.IsEmpty: Boolean;
begin
  Result := Pred(Length(_Values)) = - 1;
end;

function TListCondition.IsReplaceable: Boolean;
var
  Item: String;
begin
  Result := False;
  if IsEmpty then
    Exit;
  for Item in _Values do
    if Length(Item) > 0 then
      if HasDynamicPrefix(Item) then
      begin
        Result := True;
        Break;
      end;
end;

function TListCondition.IsValid: Boolean;
begin
  Result := (Length(_Key) > 0) and not IsEmpty;
end;

function TListCondition.Key: String;
begin
  Result := _Key;
end;

function TListCondition.PlainValues: String;
var
  Item: String;
begin
  Result := EmptyStr;
  if IsEmpty then
    Exit;
  for Item in _Values do
    Result := Result + Item + ', ';
  Result := Copy(Result, 1, Length(Result) - 2);
end;

function TListCondition.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'EN', Beautify.DelimitedList(PlainValues)]);
end;

constructor TListCondition.Create(const Key: String; const Values: Array of string);
var
  i: Integer;
begin
  _Key := Key;
  SetLength(_Values, Length(Values));
  for i := 0 to High(Values) do
    _Values[i] := Values[i];
end;

class function TListCondition.New(const Key: String; const Values: Array of string): IFilterCondition;
begin
  Result := TListCondition.Create(Key, Values);
end;

end.
