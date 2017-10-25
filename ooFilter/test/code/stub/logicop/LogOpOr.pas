{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LogOpOr;

interface

uses
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TLogOpOr = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TLogOpOr.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'O'
end;

function TLogOpOr.IsEmpty: Boolean;
begin
  Result := False;
end;

function TLogOpOr.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TLogOpOr.New: IFilterJoin;
begin
  Result := TLogOpOr.Create;
end;

end.
