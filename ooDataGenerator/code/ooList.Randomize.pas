{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Randomize;

interface

uses
  Generics.Collections,
  Math,
  ooList.DataGenerate.Intf;

type
  TListRandomize<T> = class(TInterfacedObject, IListDataGenerate<T>)
  public
    procedure Build(List: TList<T>);
    class function New: IListDataGenerate<T>;
  end;

implementation

procedure TListRandomize<T>.Build(List: TList<T>);
var
  iTo: Integer;
begin
  iTo := List.Count;
  while iTo > 0 do
  begin
    Dec(iTo);
    List.Exchange(RandomRange(0, iTo), iTo);
  end;
end;

class function TListRandomize<T>.New: IListDataGenerate<T>;
begin
  Result := TListRandomize<T>.Create;
end;

end.
