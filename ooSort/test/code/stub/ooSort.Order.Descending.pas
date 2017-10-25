{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort.Order.Descending;

interface

uses
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  TSortOrderDesc = class(TInterfacedObject, ISortOrder)
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

function TSortOrderDesc.Direction: TSortOrderDirection;
begin
  Result := sodAscending;
end;

function TSortOrderDesc.Key: String;
begin
  Result := _Key;
end;

function TSortOrderDesc.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'DESCENDING']);
end;

constructor TSortOrderDesc.Create(const Key: String);
begin
  _Key := Key;
end;

class function TSortOrderDesc.New(const Key: String): ISortOrder;
begin
  Result := TSortOrderDesc.Create(Key);
end;

end.
