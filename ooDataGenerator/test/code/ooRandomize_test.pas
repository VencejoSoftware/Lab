{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooRandomize_test;

interface

uses
  Generics.Collections,
  ooList.DataGenerate.Intf,
  ooList.Randomize,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListRandomizeTest = class(TTestCase)
  published
    procedure RandomizeIntegerList;
  end;

implementation

procedure TListRandomizeTest.RandomizeIntegerList;
var
  i: Integer;
  IntegerList: TList<Integer>;
  RandomizeList: IListDataGenerate<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  for i := 0 to 100 do
    IntegerList.Add(i);
  try
    RandomizeList := TListRandomize<Integer>.New;
    RandomizeList.Build(IntegerList);
    CheckNotEquals(0, IntegerList.items[0]);
    CheckNotEquals(100, IntegerList.items[100]);
  finally
    IntegerList.Free;
  end;
end;

initialization

RegisterTest(TListRandomizeTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
