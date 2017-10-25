{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit CondNull;

interface

uses
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TNullCondition = class sealed(TInterfacedObject, IFilterCondition)
  private
    _Key: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key: String);

    class function New(const Key: String): IFilterCondition;
  end;

implementation

function TNullCondition.IsEmpty: Boolean;
begin
  Result := False;
end;

function TNullCondition.IsReplaceable: Boolean;
begin
  Result := False;
end;

function TNullCondition.IsValid: Boolean;
begin
  Result := (Length(_Key) > 0) and not IsEmpty;
end;

function TNullCondition.Key: String;
begin
  Result := _Key;
end;

function TNullCondition.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'IS NIL']);
end;

constructor TNullCondition.Create(const Key: String);
begin
  _Key := Key;
end;

class function TNullCondition.New(const Key: String): IFilterCondition;
begin
  Result := TNullCondition.Create(Key);
end;

end.
