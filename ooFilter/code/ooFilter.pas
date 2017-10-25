{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter;

interface

uses
  SysUtils,
  ooFilter.Element.Intf,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  IFilter = interface(IFilterElement)
    ['{6227E3AE-223F-4D09-A659-376E68352157}']
    function Join: IFilterJoin;
    function AddElement(const Element: IFilterElement): Integer;
    function Elements: TFilterElementList;
  end;

  TFilter = class sealed(TInterfacedObject, IFilter)
  strict private
    _Elements: TFilterElementList;
    _Join: IFilterJoin;
  public
    function Join: IFilterJoin;
    function Parse(const Beautify: ITextBeautify): String;
    function AddElement(const Element: IFilterElement): Integer;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Elements: TFilterElementList;

    constructor Create(const Join: IFilterJoin);
    destructor Destroy; override;

    class function New(const Join: IFilterJoin): IFilter;
  end;

implementation

function TFilter.Join: IFilterJoin;
begin
  Result := _Join;
end;

function TFilter.Elements: TFilterElementList;
begin
  Result := _Elements;
end;

function TFilter.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Join.Parse(Beautify), Beautify.DelimitedList(_Elements.Parse(Beautify))]);
end;

function TFilter.IsEmpty: Boolean;
begin
  Result := _Elements.IsEmpty;
end;

function TFilter.IsReplaceable: Boolean;
begin
  Result := _Elements.IsReplaceable;
end;

function TFilter.AddElement(const Element: IFilterElement): Integer;
begin
  Result := _Elements.Add(Element);
end;

constructor TFilter.Create(const Join: IFilterJoin);
begin
  _Elements := TFilterElementList.Create;
  _Join := Join;
end;

destructor TFilter.Destroy;
begin
  _Elements.Free;
  inherited;
end;

class function TFilter.New(const Join: IFilterJoin): IFilter;
begin
  Result := TFilter.Create(Join);
end;

end.
