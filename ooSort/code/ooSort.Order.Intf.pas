{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort.Order.Intf;

interface

uses
  SysUtils,
  Generics.Collections,
  ooText.Beautify.Intf;

type
  TSortOrderDirection = (sodNone, sodAscending, sodDescending);

  ISortOrder = interface
    ['{2355162C-BE6C-4FC8-B4D6-D747F2FD7AEC}']
    function Key: String;
    function Direction: TSortOrderDirection;
    function Parse(const Beautify: ITextBeautify): String;
  end;

  TSortOrderList = class(TList<ISortOrder>)
  strict private
    _Separator: String;
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;

    constructor Create(const Separator: String = ','); reintroduce;
  end;

implementation

function TSortOrderList.IsEmpty: Boolean;
begin
  Result := Pred(Count) < 0;
end;

function TSortOrderList.Parse(const Beautify: ITextBeautify): String;
var
  Order: ISortOrder;
begin
  Result := EmptyStr;
  for Order in Self do
    if Result = EmptyStr then
      Result := Order.Parse(Beautify)
    else
      Result := Beautify.Apply([Result, _Separator, Order.Parse(Beautify)]);
end;

constructor TSortOrderList.Create(const Separator: String = ',');
begin
  inherited Create;
  _Separator := Separator;
end;

end.
