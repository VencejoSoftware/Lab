{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Command.Intf;

interface

type
  IFSCommand<T> = interface
    ['{B6D2E46E-EC2D-4852-9FDA-046D7561AC21}']
    function Execute: T;
  end;

implementation

end.
