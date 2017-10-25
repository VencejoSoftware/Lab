{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.Convert;

interface

uses
  Math,
  ooBytes;

type
  TByteScale = (scBytes, scKB, scMB, scGB, scTB, scPB, scEB, scZB, scYB);

  IBytesConvert = interface(IBytes)
    ['{554430DF-59D1-4B1E-8A09-082CA6B066F8}']
    function AsType(const Scale: TByteScale): Extended;
    function FitSizeType: TByteScale;
  end;

  TBytesConvert = class(TInterfacedObject, IBytesConvert)
  strict private
    _Bytes: IBytes;
  public
    function Bytes: Extended;
    function AsType(const Scale: TByteScale): Extended;
    function FitSizeType: TByteScale;
    constructor Create(const Bytes: IBytes);
    class function New(const Bytes: IBytes): IBytesConvert;
  end;

implementation

function TBytesConvert.Bytes: Extended;
begin
  Result := _Bytes.Bytes;
end;

function TBytesConvert.FitSizeType: TByteScale;
begin
  for Result := Low(TByteScale) to High(TByteScale) do
    if Bytes < Power(1024, Succ(Ord(Result))) then
      Break;
end;

function TBytesConvert.AsType(const Scale: TByteScale): Extended;
begin
  Result := Bytes / IntPower(1024, Ord(Scale));
end;

constructor TBytesConvert.Create(const Bytes: IBytes);
begin
  _Bytes := Bytes;
end;

class function TBytesConvert.New(const Bytes: IBytes): IBytesConvert;
begin
  Result := TBytesConvert.Create(Bytes);
end;

end.
