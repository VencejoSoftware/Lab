{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooFilter.Condition_test in '..\code\ooFilter.Condition_test.pas',
  ooFilter.Item_test in '..\code\ooFilter.Item_test.pas',
  ooFilter.Join_test in '..\code\ooFilter.Join_test.pas',
  ooFilter_test in '..\code\ooFilter_test.pas',
  CondBetween in '..\code\stub\condition\CondBetween.pas',
  CondEqual in '..\code\stub\condition\CondEqual.pas',
  CondList in '..\code\stub\condition\CondList.pas',
  CondNull in '..\code\stub\condition\CondNull.pas',
  JoinNone in '..\code\stub\logicop\JoinNone.pas',
  LogOpAnd in '..\code\stub\logicop\LogOpAnd.pas',
  LogOpOr in '..\code\stub\logicop\LogOpOr.pas',
  LogOpOrNot in '..\code\stub\logicop\LogOpOrNot.pas';

{R *.RES}

begin
  Run;

end.
