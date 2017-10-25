{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter.Condition_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  CondBetween, CondEqual, CondList, CondNull,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLogicalOperatorTest = class(TTestCase)
  published
    procedure EqualIsInvalidForValue;
    procedure EqualIsInvalidForKey;
    procedure EqualIsEmpty;
    procedure EqualIsNotEmpty;
    procedure Field1Equal22;
    procedure Field1IsNull;
    procedure Field1Between90and200;
    procedure Field1InList;
    procedure Field1Replaceable;
  end;

implementation

procedure TLogicalOperatorTest.EqualIsEmpty;
begin
  CheckTrue(TEqualCondition.New('Field1', EmptyStr).IsEmpty);
end;

procedure TLogicalOperatorTest.EqualIsInvalidForKey;
begin
  CheckFalse(TEqualCondition.New(EmptyStr, '22').IsValid);
end;

procedure TLogicalOperatorTest.EqualIsInvalidForValue;
begin
  CheckFalse(TEqualCondition.New('Field1', EmptyStr).IsValid);
end;

procedure TLogicalOperatorTest.EqualIsNotEmpty;
begin
  CheckFalse(TEqualCondition.New('Field1', 'Something').IsEmpty);
end;

procedure TLogicalOperatorTest.Field1Between90and200;
begin
  CheckEquals('Field1 BETWEEN 90 Y 200', TBetweenCondition.New('Field1', '90', '200').Parse(TSimpleBeautify.New));
end;

procedure TLogicalOperatorTest.Field1Equal22;
begin
  CheckEquals('Field1 = 22', TEqualCondition.New('Field1', '22').Parse(TSimpleBeautify.New));
end;

procedure TLogicalOperatorTest.Field1InList;
begin
  CheckEquals('Field1 EN (1, 5, 10, 15)',
    TListCondition.New('Field1', ['1', '5', '10', '15']).Parse(TSimpleBeautify.New));
end;

procedure TLogicalOperatorTest.Field1IsNull;
begin
  CheckEquals('Field1 IS NIL', TNullCondition.New('Field1').Parse(TSimpleBeautify.New));
end;

procedure TLogicalOperatorTest.Field1Replaceable;
begin
  CheckTrue(TEqualCondition.New('Field1', ':Field1').IsReplaceable);
  CheckTrue(TEqualCondition.New('Field1', ' :Field1').IsReplaceable);
end;

initialization

RegisterTest(TLogicalOperatorTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
