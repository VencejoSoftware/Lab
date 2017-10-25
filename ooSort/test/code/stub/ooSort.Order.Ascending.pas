{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort.Order.Ascending;

interface

uses
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  TSortOrderAsc = class(TInterfacedObject, ISortOrder)
  strict private
    _Key: String;
  public
    function Key: String;
    function Direction: TSortOrderDirection;
    function Parse(const Beautify: ITextBeautify): String;

    constructor Create(const Key: String);

    class function New(const Key: String): ISortOrder;
  end;

implementation

function TSortOrderAsc.Direction: TSortOrderDirection;
begin
  Result := sodAscending;
end;

function TSortOrderAsc.Key: String;
begin
  Result := _Key;
end;

function TSortOrderAsc.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'ASCENDING']);
end;

constructor TSortOrderAsc.Create(const Key: String);
begin
  _Key := Key;
end;

class function TSortOrderAsc.New(const Key: String): ISortOrder;
begin
  Result := TSortOrderAsc.Create(Key);
end;

end.
