{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  LogOpAnd, LogOpOr, LogOpOrNot, JoinNone,
  CondBetween, CondEqual, CondList, CondNull,
  ooFilter.Condition.Joined,
  ooFilter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFilterTest = class(TTestCase)
  published
    procedure FilterWithNoneOpLog;
    procedure FilterWithTwoConditions;
    procedure FilterWithTwoConditionsAndLogOp;
    procedure FilterWithAnotherFilter;
    procedure FilterIsEmpty;
    procedure FilterIsReplaceable;
    procedure FilterJoinIsNone;
  end;

implementation

procedure TFilterTest.FilterWithNoneOpLog;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TJoinNone.New);
  Filter.AddElement(TEqualCondition.New('Field1', '22'));
  CheckEquals('(Field1 = 22)', Filter.Parse(TSimpleBeautify.New));
end;

procedure TFilterTest.FilterWithTwoConditions;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TJoinNone.New);
  Filter.AddElement(TEqualCondition.New('Field1', '22'));
  Filter.AddElement(TFilterConditionJoined.New(TLogOpOr.New, TListCondition.New('Field1', ['1', '5', '10', '15'])));
  CheckEquals('(Field1 = 22 O (Field1 EN (1, 5, 10, 15)))', Filter.Parse(TSimpleBeautify.New));
end;

procedure TFilterTest.FilterWithTwoConditionsAndLogOp;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TLogOpAnd.New);
  Filter.AddElement(TEqualCondition.New('Field1', '22'));
  Filter.AddElement(TFilterConditionJoined.New(TLogOpOr.New, TListCondition.New('Field1', ['1', '5', '10', '15'])));
  CheckEquals('Y (Field1 = 22 O (Field1 EN (1, 5, 10, 15)))', Filter.Parse(TSimpleBeautify.New));
end;

procedure TFilterTest.FilterIsEmpty;
begin
  CheckTrue(TFilter.New(TJoinNone.New).IsEmpty);
end;

procedure TFilterTest.FilterIsReplaceable;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TJoinNone.New);
  Filter.AddElement(TEqualCondition.New('Field1', ':Value'));
  CheckTrue(Filter.IsReplaceable);
end;

procedure TFilterTest.FilterJoinIsNone;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TJoinNone.New);
  CheckTrue(Filter.Join is TJoinNone);
end;

procedure TFilterTest.FilterWithAnotherFilter;
var
  Filter, InnerFilter: IFilter;
begin
  Filter := TFilter.New(TJoinNone.New);
  Filter.AddElement(TEqualCondition.New('Field1', '22'));
  InnerFilter := TFilter.New(TLogOpAnd.New);
  InnerFilter.AddElement(TEqualCondition.New('Field1', '22'));
  InnerFilter.AddElement(TFilterConditionJoined.New(TLogOpOr.New, TListCondition.New('Field1', ['1', '5', '10', '15']))
    );
  Filter.AddElement(InnerFilter);
  CheckEquals('(Field1 = 22 Y (Field1 = 22 O (Field1 EN (1, 5, 10, 15))))', Filter.Parse(TSimpleBeautify.New));
end;

initialization

RegisterTest(TFilterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
