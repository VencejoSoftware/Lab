{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter.Item_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  CondEqual, CondBetween,
  JoinNone, LogOpOrNot,
  ooFilter.Condition.Joined,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFilterConditionJoinedTest = class(TTestCase)
  published
    procedure LopOpNoneAndField1Equal22;
    procedure LopOpOrNotAndField1Between1And100;
    procedure ItemIsEmpty;
    procedure ItemIsReplaceable;
    procedure ItemJoinIsNone;
  end;

implementation

procedure TFilterConditionJoinedTest.ItemIsEmpty;
begin
  CheckTrue(TFilterConditionJoined.New(TJoinNone.New, TEqualCondition.New('Field1', EmptyStr)).IsEmpty);
end;

procedure TFilterConditionJoinedTest.ItemIsReplaceable;
begin
  CheckTrue(TFilterConditionJoined.New(TJoinNone.New, TEqualCondition.New('Field1', ':VALUE')).IsReplaceable);
end;

procedure TFilterConditionJoinedTest.ItemJoinIsNone;
begin
  CheckTrue(TFilterConditionJoined.New(TJoinNone.New, TEqualCondition.New('Field1', ':VALUE')).Join is TJoinNone);
end;

procedure TFilterConditionJoinedTest.LopOpNoneAndField1Equal22;
begin
  CheckEquals('(Field1 = 22)', TFilterConditionJoined.New(TJoinNone.New, TEqualCondition.New('Field1', '22')).Parse
      (TSimpleBeautify.New));
end;

procedure TFilterConditionJoinedTest.LopOpOrNotAndField1Between1And100;
begin
  CheckEquals('O NO (Field1 BETWEEN 1 Y 100)', TFilterConditionJoined.New(TLogOpOrNot.New,
      TBetweenCondition.New('Field1', '1', '100')).Parse(TSimpleBeautify.New));
end;

initialization

RegisterTest(TFilterConditionJoinedTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
