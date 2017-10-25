{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.AsString;

interface

uses
  SysUtils,
  ooBytes.Convert,
  ooBytes.Format.Intf;

type
  TBytesAsString = class(TInterfacedObject, IBytesFormat)
  strict private
    _BytesConvert: IBytesConvert;
  private
    function SizeTypeAsString(const Scale: TByteScale): String;
  public
    function Bytes: Extended;
    function Build: String;
    function BuildAsType(const Scale: TByteScale): String;
    constructor Create(const Bytes: IBytesConvert);
    class function New(const Bytes: IBytesConvert): IBytesFormat;
  end;

implementation

function TBytesAsString.Bytes: Extended;
begin
  Result := _BytesConvert.Bytes;
end;

function TBytesAsString.SizeTypeAsString(const Scale: TByteScale): String;
const
  SIZE_TYPE: array [TByteScale] of string = ('Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
begin
  Result := SIZE_TYPE[Scale];
end;

function TBytesAsString.BuildAsType(const Scale: TByteScale): String;
begin
  Result := Format('%n %s', [_BytesConvert.AsType(Scale), SizeTypeAsString(Scale)]);
end;

function TBytesAsString.Build: String;
begin
  Result := BuildAsType(_BytesConvert.FitSizeType);
end;

constructor TBytesAsString.Create(const Bytes: IBytesConvert);
begin
  _BytesConvert := Bytes;
end;

class function TBytesAsString.New(const Bytes: IBytesConvert): IBytesFormat;
begin
  Result := Create(Bytes);
end;

end.
