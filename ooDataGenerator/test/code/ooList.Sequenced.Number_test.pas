{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Sequenced.Number_test;

interface

uses
  ooList.Sequenced.Number,
  Generics.Collections,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListSequencedNumberTest = class(TTestCase)
  published
    procedure CountOfRange10to20;
    procedure CountOfRange20to10;
    procedure SequencedListWith10Items;
    procedure SequencedListWith10ItemsStep3;
  end;

implementation

procedure TListSequencedNumberTest.CountOfRange10to20;
var
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedNumber.New(10, 20, 1).Build(IntegerList);
    CheckEquals(10, Pred(IntegerList.Count));
  finally
    IntegerList.Free;
  end;
end;

procedure TListSequencedNumberTest.CountOfRange20to10;
var
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedNumber.New(20, 10, 1).Build(IntegerList);
    CheckEquals(10, Pred(IntegerList.Count));
  finally
    IntegerList.Free;
  end;
end;

procedure TListSequencedNumberTest.SequencedListWith10Items;
var
  i, Index: Integer;
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedNumber.New(10, 20, 1).Build(IntegerList);
    Index := 0;
    for i := 10 to 20 do
    begin
      CheckEquals(i, IntegerList.Items[Index]);
      Inc(Index);
    end;
  finally
    IntegerList.Free;
  end;
end;

procedure TListSequencedNumberTest.SequencedListWith10ItemsStep3;
var
  i, Index: Integer;
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedNumber.New(10, 20, 3).Build(IntegerList);
    Index := 0;
    i := 10;
    while Index < IntegerList.Count do
    begin
      CheckEquals(i, IntegerList.Items[Index]);
      Inc(Index);
      Inc(i, 3);
    end;
  finally
    IntegerList.Free;
  end;
end;

initialization

RegisterTest(TListSequencedNumberTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
