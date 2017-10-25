{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LogOpAnd;

interface

uses
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TLogOpAnd = class sealed(TInterfacedObject, IFilterJoin)
  public
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;

    class function New: IFilterJoin;
  end;

implementation

function TLogOpAnd.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'Y'
end;

function TLogOpAnd.IsEmpty: Boolean;
begin
  Result := False;
end;

function TLogOpAnd.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TLogOpAnd.New: IFilterJoin;
begin
  Result := TLogOpAnd.Create;
end;

end.
