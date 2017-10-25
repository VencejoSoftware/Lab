{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.RandomFixed;

interface

uses
  Math,
  ooText;

type
  TRandomTextFixed = class sealed(TInterfacedObject, IText)
  strict private
  const
    CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopkrsyuvwxyz1234567890_-.,:;*+=!¡¿?\[]{}()#$%&/@';
  private
    function Generate: String;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    class function New: IText;
  end;

implementation

function TRandomTextFixed.Generate: String;
var
  i: Integer;
  Buffer: Char;
begin
  Randomize;
  Result := CHARS;
  i := Length(Result);
  while i > 0 do
  begin
    Buffer := Result[i];
    Result[i] := Result[RandomRange(1, i)];
    Result[RandomRange(1, i)] := Buffer;
    Dec(i);
  end;
end;

function TRandomTextFixed.Value: String;
begin
  Result := Generate;
end;

function TRandomTextFixed.IsEmpty: Boolean;
begin
  Result := False;
end;

function TRandomTextFixed.Size: Integer;
begin
  Result := Length(CHARS);
end;

class function TRandomTextFixed.New: IText;
begin
  Result := Create;
end;

end.
