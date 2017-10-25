{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes;

interface

type
  IBytes = interface
    ['{4D09BE05-8382-4817-B707-5A233180C768}']
    function Bytes: Extended;
  end;

  TBytes = class(TInterfacedObject, IBytes)
  strict private
    _Bytes: Extended;
  public
    function Bytes: Extended;
    constructor Create(const Bytes: Extended);
    class function New(const Bytes: Extended): IBytes;
  end;

implementation

function TBytes.Bytes: Extended;
begin
  Result := _Bytes;
end;

constructor TBytes.Create(const Bytes: Extended);
begin
  _Bytes := Bytes;
end;

class function TBytes.New(const Bytes: Extended): IBytes;
begin
  Result := TBytes.Create(Bytes);
end;

end.
