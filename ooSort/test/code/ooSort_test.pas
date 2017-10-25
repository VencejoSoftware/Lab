{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  ooSort.Order.Ascending, ooSort.Order.Descending, ooSort.Order.None,
  ooSort,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSortTest = class(TTestCase)
  published
    procedure TwoOrderText;
  end;

implementation

procedure TSortTest.TwoOrderText;
var
  Sort: ISort;
begin
  Sort := TSort.New;
  Sort.AddOrder(TSortOrderAsc.New('Field1'));
  Sort.AddOrder(TSortOrderDesc.New('Field2'));
  CheckEquals('Field1 ASCENDING , Field2 DESCENDING', Sort.Parse(TSimpleBeautify.New));
end;

initialization

RegisterTest(TSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
