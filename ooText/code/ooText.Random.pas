{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooText.Random;

interface

uses
  ooText;

type
  TRandomText = class sealed(TInterfacedObject, IText)
  strict private
  const
    CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopkrsyuvwxyz1234567890_-.,:;*+=!¡¿?\[]{}()#$%&/@';
  strict private
    _Size: Integer;
  private
    function Generate: String;
  public
    function Size: Integer;
    function Value: String;
    function IsEmpty: Boolean;

    constructor Create(const Count: Integer);

    class function New(const Count: Integer): IText;
  end;

implementation

function TRandomText.Generate: String;
var
  i, ValidLen: Integer;
begin
  Randomize;
  ValidLen := Length(CHARS);
  SetLength(Result, _Size);
  for i := 1 to _Size do
    Result[i] := CHARS[Succ(Random(ValidLen))];
end;

function TRandomText.Value: String;
begin
  Result := Generate;
end;

function TRandomText.IsEmpty: Boolean;
begin
  Result := Size < 1;
end;

function TRandomText.Size: Integer;
begin
  Result := _Size;
end;

constructor TRandomText.Create(const Count: Integer);
begin
  _Size := Count;
end;

class function TRandomText.New(const Count: Integer): IText;
begin
  Result := TRandomText.Create(Count);
end;

end.
