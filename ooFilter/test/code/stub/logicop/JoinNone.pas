{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit JoinNone;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TJoinNone = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TJoinNone.Parse(const Beautify: ITextBeautify): String;
begin
  Result := EmptyStr;
end;

function TJoinNone.IsEmpty: Boolean;
begin
  Result := False;
end;

function TJoinNone.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TJoinNone.New: IFilterJoin;
begin
  Result := TJoinNone.Create;
end;

end.
