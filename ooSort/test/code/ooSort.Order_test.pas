{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort.Order_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  ooSort.Order.Ascending, ooSort.Order.Descending, ooSort.Order.None,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSortOrderTest = class(TTestCase)
  published
    procedure IsAscendingText;
    procedure IsDescendingText;
    procedure SortNoneIsEmpty;
  end;

implementation

procedure TSortOrderTest.IsAscendingText;
begin
  CheckEquals('Field1 ASCENDING', TSortOrderAsc.New('Field1').Parse(TSimpleBeautify.New));
end;

procedure TSortOrderTest.IsDescendingText;
begin
  CheckEquals('Field1 DESCENDING', TSortOrderDesc.New('Field1').Parse(TSimpleBeautify.New));
end;

procedure TSortOrderTest.SortNoneIsEmpty;
begin
  CheckEquals(EmptyStr, TSortOrderNone.New.Parse(TSimpleBeautify.New));
end;

initialization

RegisterTest(TSortOrderTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
