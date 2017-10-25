{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort.Order.None;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  TSortOrderNone = class(TInterfacedObject, ISortOrder)
  public
    function Key: String;
    function Direction: TSortOrderDirection;
    function Parse(const Beautify: ITextBeautify): String;

    class function New: ISortOrder;
  end;

implementation

function TSortOrderNone.Direction: TSortOrderDirection;
begin
  Result := sodAscending;
end;

function TSortOrderNone.Key: String;
begin
  Result := EmptyStr;
end;

function TSortOrderNone.Parse(const Beautify: ITextBeautify): String;
begin
  Result := EmptyStr;
end;

class function TSortOrderNone.New: ISortOrder;
begin
  Result := TSortOrderNone.Create;
end;

end.
