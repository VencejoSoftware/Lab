{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.DataGenerate.Intf;

interface

uses
  Generics.Collections;

type
  IListDataGenerate<T> = interface
    ['{F117DDF0-00A0-4B9F-B2F8-81BF839B1473}']
    procedure Build(List: TList<T>);
  end;

implementation

end.
