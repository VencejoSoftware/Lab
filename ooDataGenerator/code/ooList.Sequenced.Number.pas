{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Sequenced.Number;

interface

uses
  Generics.Collections,
  ooList.DataGenerate.Intf;

type
  TListSequencedNumber = class(TInterfacedObject, IListDataGenerate<Integer>)
  strict private
    _FromValue, _ToValue, _Step: Integer;
  public
    procedure Build(List: TList<Integer>);
    constructor Create(const FromValue, ToValue, Step: Integer);
    class function New(const FromValue, ToValue, Step: Integer): IListDataGenerate<Integer>;
  end;

implementation

procedure TListSequencedNumber.Build(List: TList<Integer>);
var
  i: Integer;
begin
  List.Clear;
  List.Capacity := _ToValue;
  for i := 0 to _ToValue do
    List.Add(_FromValue + i * _Step);
end;

constructor TListSequencedNumber.Create(const FromValue, ToValue, Step: Integer);
begin
  _Step := Step;
  if FromValue > ToValue then
  begin
    _FromValue := ToValue;
    _ToValue := FromValue - ToValue;
  end
  else
  begin
    _FromValue := FromValue;
    _ToValue := ToValue - FromValue;
  end;
end;

class function TListSequencedNumber.New(const FromValue, ToValue, Step: Integer): IListDataGenerate<Integer>;
begin
  Result := TListSequencedNumber.Create(FromValue, ToValue, Step);
end;

end.
