{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFilter.Element.Intf;

interface

uses
  SysUtils,
  Generics.Collections,
  ooText.Beautify.Intf;

type
  IFilterElement = interface
    ['{2355162C-BE6C-4FC8-B4D6-D747F2FD7AEC}']
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
  end;

  TFilterElementList = class(TList<IFilterElement>)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
  end;

implementation

function TFilterElementList.IsEmpty: Boolean;
begin
  Result := Pred(Count) < 0;
end;

function TFilterElementList.IsReplaceable: Boolean;
var
  Element: IFilterElement;
begin
  Result := False;
  for Element in Self do
  begin
    Result := Element.IsReplaceable;
    if Result then
      Break;
  end;
end;

function TFilterElementList.Parse(const Beautify: ITextBeautify): String;
var
  Element: IFilterElement;
begin
  Result := EmptyStr;
  for Element in Self do
    Result := Beautify.Apply([Result, Element.Parse(Beautify)]);
end;

end.
