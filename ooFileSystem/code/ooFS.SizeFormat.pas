{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.SizeFormat;

interface

uses
  SysUtils, Math;

type
  IFSSizeFormat = interface
    ['{A88AD3C9-E3FF-4ABD-AEA9-0D8660D2AD6D}']
    function Stylized: String;
  end;

  TFSSizeFormat = class sealed(TInterfacedObject, IFSSizeFormat)
  strict private
    _Stylized: String;
  public
    function Stylized: String;
    constructor Create(const Size: Extended);
    class function New(const Size: Extended): IFSSizeFormat;
  end;

implementation

function TFSSizeFormat.Stylized: String;
begin
  Result := _Stylized;
end;

constructor TFSSizeFormat.Create(const Size: Extended);
const
  SIZE_MEASURE: Array [0 .. 8] of string = ('bytes', 'kb', 'mb', 'gb', 'tb', 'pb', 'eb', 'zb', 'yb');
var
  i: Integer;
begin
  i := 0;
  while Size > Power(1024, i + 1) do
    Inc(i);
  _Stylized := FormatFloat('###0.##', Size / IntPower(1024, i)) + ' ' + SIZE_MEASURE[i];
end;

class function TFSSizeFormat.New(const Size: Extended): IFSSizeFormat;
begin
  Result := TFSSizeFormat.Create(Size);
end;

end.
