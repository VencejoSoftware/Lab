{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter.Condition.Intf;

interface

uses
  ooFilter.Element.Intf;

type
  IFilterCondition = interface(IFilterElement)
    ['{C6560F45-DDA0-47D3-9B3A-C3CA72D84C50}']
    function IsValid: Boolean;
    function Key: String;
  end;

implementation

end.
