{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooList.Sequenced.EvenNumber_test;

interface

uses
  ooList.Sequenced.EvenNumber,
  Generics.Collections,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TListSequencedEvenNumberTest = class(TTestCase)
  published
    procedure CountOfRange10to20;
    procedure CountOfRange20to10;
    procedure SequencedListWith10Items;
    procedure SequencedListWith10ItemsStep3;
  end;

implementation

procedure TListSequencedEvenNumberTest.CountOfRange10to20;
var
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedEvenNumber.New(10, 20, 1).Build(IntegerList);
    CheckEquals(10, Pred(IntegerList.Count));
  finally
    IntegerList.Free;
  end;
end;

procedure TListSequencedEvenNumberTest.CountOfRange20to10;
var
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedEvenNumber.New(20, 10, 1).Build(IntegerList);
    CheckEquals(10, Pred(IntegerList.Count));
  finally
    IntegerList.Free;
  end;
end;

procedure TListSequencedEvenNumberTest.SequencedListWith10Items;
var
  i, Index: Integer;
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedEvenNumber.New(10, 20, 1).Build(IntegerList);
    Index := 0;
    i := 0;
    while Index < IntegerList.Count do
    begin
      CheckEquals(10 + i * 2, IntegerList.Items[Index]);
      Inc(Index);
      Inc(i);
    end;
  finally
    IntegerList.Free;
  end;
end;

procedure TListSequencedEvenNumberTest.SequencedListWith10ItemsStep3;
var
  i, Index: Integer;
  IntegerList: TList<Integer>;
begin
  IntegerList := TList<Integer>.Create;
  try
    TListSequencedEvenNumber.New(10, 20, 3).Build(IntegerList);
    Index := 0;
    i := 0;
    while Index < IntegerList.Count do
    begin
      CheckEquals(10 + i * 3 * 2, IntegerList.Items[Index]);
      Inc(Index);
      Inc(i);
    end;
  finally
    IntegerList.Free;
  end;
end;

initialization

RegisterTest(TListSequencedEvenNumberTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
