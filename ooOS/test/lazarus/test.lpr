{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooOS.UserName_test in '..\code\ooOS.UserName_test.pas',
  ooOS.LocalMacAddress_test in '..\code\ooOS.LocalMacAddress_test.pas',
  ooOS.LocalIP_test in '..\code\ooOS.LocalIP_test.pas',
  ooOS.ComputerName_test in '..\code\ooOS.ComputerName_test.pas',
  ooOS.RemoteMacAddress_test in '..\code\ooOS.RemoteMacAddress_test.pas';

{R *.RES}

begin
  Run;

end.
