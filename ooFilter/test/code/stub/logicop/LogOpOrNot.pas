{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LogOpOrNot;

interface

uses
  LogOpOr,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TLogOpOrNot = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TLogOpOrNot.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([TLogOpOr.New.Parse(Beautify), 'NO'])
end;

function TLogOpOrNot.IsEmpty: Boolean;
begin
  Result := False;
end;

function TLogOpOrNot.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TLogOpOrNot.New: IFilterJoin;
begin
  Result := TLogOpOrNot.Create;
end;

end.
