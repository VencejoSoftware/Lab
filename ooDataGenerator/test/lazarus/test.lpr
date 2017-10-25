{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooRandomize_test in '..\code\ooRandomize_test.pas',
  ooList.Sequenced.Number_test in '..\code\ooList.Sequenced.Number_test.pas',
  ooList.Sequenced.OddNumber_test in '..\code\ooList.Sequenced.OddNumber_test.pas',
  ooList.Sequenced.EvenNumber_test in '..\code\ooList.Sequenced.EvenNumber_test.pas';

{R *.RES}

begin
  Run;

end.
