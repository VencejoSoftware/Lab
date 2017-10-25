{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooConfig.Intf;

interface

uses
  ooEntity.Intf;

type
  IConfigSection = interface(IEntity)
    ['{37CB5072-49D6-4EC1-AACF-70AA572C03A2}']
    function Name: String;
    function Description: String;
  end;

  IConfig = interface
    ['{18547F4D-59DF-4B56-9CF4-772F9B47D7E2}']
    function LoadSection(const ConfigSection: IConfigSection): Boolean;
    function SaveSection(const ConfigSection: IConfigSection): Boolean;
  end;

implementation

end.
