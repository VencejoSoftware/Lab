{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.IntToByte;

interface

type
  ICastByte = interface
    ['{1321FEEE-BEC0-44F8-A9D0-259893984898}']
    function Value: Byte;
  end;

  TIntToByte = class(TInterfacedObject, ICastByte)
  strict private
    _Source: Integer;
  public
    function Value: Byte;
    constructor Create(const Source: Integer);
    class function New(const Source: Integer): ICastByte;
  end;

function RangeByte(const Value: Integer): Byte;

implementation

function TIntToByte.Value: Byte;
begin
  Result := RangeByte(_Source);
end;

constructor TIntToByte.Create(const Source: Integer);
begin
  _Source := Source;
end;

class function TIntToByte.New(const Source: Integer): ICastByte;
begin
  Result := TIntToByte.Create(Source);
end;

function RangeByte(const Value: Integer): Byte;
{$IFDEF FPC}
begin
  if Value < 0 then
     Result := 0
  else if Value > 255 then
     Result := 255
  else
     Result := Value;
{$ELSE}
asm
  MOV  EAX, Value       // store value in EAX register (32-bit register)
  CMP  EAX, 254         // compare it to 254
  JG   @SETHI           // if greater than 254 then go set to 255 (max value)
  CMP  EAX, 1           // if less than 255, compare to 1
  JL   @SETLO           // if less than 1 go set to 0 (min value)
  RET                   // otherwise it doesn't change, just exit
@SETHI:                 // Set value to 255
  MOV  EAX, 255         // Move 255 into the EAX register
  RET                   // Exit (result value is the EAX register value)
@SETLO:                 // Set value to 0
  MOV  EAX, 0           // Move 0 into EAX register
{$ENDIF}
end;

end.
