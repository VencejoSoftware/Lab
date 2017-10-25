{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Command.Delay;

interface

uses
  Forms, Windows,
  ooFS.Command.Intf;

type
  IFSCommandDelay = interface(IFSCommand<Boolean>)
    ['{9DD5BCCF-3C08-4398-8403-9F18FE9B6EBF}']
  end;

  TFSCommandDelay = class sealed(TInterfacedObject, IFSCommandDelay)
  strict private
    _Milliseconds: Integer;
  public
    function Execute: Boolean;
    constructor Create(const Milliseconds: Integer);
    class function New(const Milliseconds: Integer): IFSCommandDelay;
  end;

implementation

function TFSCommandDelay.Execute: Boolean;
var
  FirstTickCount: DWORD;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
    Sleep(1);
  until ((GetTickCount - FirstTickCount) >= DWORD(_Milliseconds)) or Application.Terminated;
  Result := True;
end;

constructor TFSCommandDelay.Create(const Milliseconds: Integer);
begin
  _Milliseconds := Milliseconds;
end;

class function TFSCommandDelay.New(const Milliseconds: Integer): IFSCommandDelay;
begin
  Result := TFSCommandDelay.Create(Milliseconds);
end;

end.
