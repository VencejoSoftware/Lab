{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter.Condition.Joined;

interface

uses
  ooText.Beautify.Intf,
  ooFilter.Join.Intf,
  ooFilter.Condition.Intf,
  ooFilter.Element.Intf;

type
  IFilterConditionJoined = interface(IFilterElement)
    ['{B5D7BD71-7838-4D53-9148-DE50B33044F7}']
    function Join: IFilterJoin;
    function Condition: IFilterCondition;
  end;

  TFilterConditionJoined = class sealed(TInterfacedObject, IFilterConditionJoined)
  strict private
    _Condition: IFilterCondition;
    _Join: IFilterJoin;
  public
    function Join: IFilterJoin;
    function Condition: IFilterCondition;
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    constructor Create(const Join: IFilterJoin; const Condition: IFilterCondition);
    class function New(const Join: IFilterJoin; const Condition: IFilterCondition): IFilterConditionJoined;
  end;

implementation

function TFilterConditionJoined.Condition: IFilterCondition;
begin
  Result := _Condition;
end;

function TFilterConditionJoined.Join: IFilterJoin;
begin
  Result := _Join;
end;

function TFilterConditionJoined.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Join.Parse(Beautify), Beautify.DelimitedList(_Condition.Parse(Beautify))]);
end;

constructor TFilterConditionJoined.Create(const Join: IFilterJoin; const Condition: IFilterCondition);
begin
  _Join := Join;
  _Condition := Condition;
end;

function TFilterConditionJoined.IsEmpty: Boolean;
begin
  Result := Condition.IsEmpty;
end;

function TFilterConditionJoined.IsReplaceable: Boolean;
begin
  Result := Condition.IsReplaceable;
end;

class function TFilterConditionJoined.New(const Join: IFilterJoin; const Condition: IFilterCondition)
  : IFilterConditionJoined;
begin
  Result := TFilterConditionJoined.Create(Join, Condition);
end;

end.
