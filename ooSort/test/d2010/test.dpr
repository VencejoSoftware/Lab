{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooSort.Order_test in '..\code\ooSort.Order_test.pas',
  ooSort_test in '..\code\ooSort_test.pas',
  ooSort.Order.Ascending in '..\code\stub\ooSort.Order.Ascending.pas',
  ooSort.Order.Descending in '..\code\stub\ooSort.Order.Descending.pas',
  ooSort.Order.None in '..\code\stub\ooSort.Order.None.pas';

{$R *.RES}

begin
  Run;

end.
