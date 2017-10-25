{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSort;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  ISort = interface
    ['{97806885-D80F-455F-B63C-4443FC169523}']
    function AddOrder(const Order: ISortOrder): Integer;
    function Parse(const Beautify: ITextBeautify): String;
  end;

  TSort = class sealed(TInterfacedObject, ISort)
  strict private
    _OrderList: TSortOrderList;
  public
    function Parse(const Beautify: ITextBeautify): String;
    function AddOrder(const Order: ISortOrder): Integer;
    function IsEmpty: Boolean;

    constructor Create;
    destructor Destroy; override;

    class function New: ISort;
  end;

implementation

function TSort.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_OrderList.Parse(Beautify)]);
end;

function TSort.IsEmpty: Boolean;
begin
  Result := _OrderList.IsEmpty;
end;

function TSort.AddOrder(const Order: ISortOrder): Integer;
begin
  Result := _OrderList.Add(Order);
end;

constructor TSort.Create;
begin
  _OrderList := TSortOrderList.Create;
end;

destructor TSort.Destroy;
begin
  _OrderList.Free;
  inherited;
end;

class function TSort.New: ISort;
begin
  Result := TSort.Create;
end;

end.
