{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooBytes.AsString_test in '..\code\ooBytes.AsString_test.pas',
  ooBytes.Convert_test in '..\code\ooBytes.Convert_test.pas',
  ooBytes.IntToByte_test in '..\code\ooBytes.IntToByte_test.pas';

{$R *.RES}

begin
  Run;

end.
