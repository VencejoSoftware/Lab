{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter.Join_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  LogOpAnd, LogOpOr, LogOpOrNot,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLogicalOperatorTest = class(TTestCase)
  published
    procedure LogOpAndIsY;
    procedure LogOpOrIsO;
    procedure LogOpOrNotIsO_NO;
  end;

implementation

procedure TLogicalOperatorTest.LogOpOrIsO;
begin
  CheckEquals('O', TLogOpOr.New.Parse(TSimpleBeautify.New));
end;

procedure TLogicalOperatorTest.LogOpOrNotIsO_NO;
begin
  CheckEquals('O NO', TLogOpOrNot.New.Parse(TSimpleBeautify.New));
end;

procedure TLogicalOperatorTest.LogOpAndIsY;
begin
  CheckEquals('Y', TLogOpAnd.New.Parse(TSimpleBeautify.New));
end;

initialization

RegisterTest(TLogicalOperatorTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
