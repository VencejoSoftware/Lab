{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Dialogs, Spin,
  Generics.Collections,
  ooList.DataGenerate.Intf,
  ooList.Sequenced.Number, ooList.Sequenced.EvenNumber, ooList.Sequenced.OddNumber,
  ooList.Randomize;

type
  TIntegerList = TList<Integer>;

  TMainForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    btnInc: TButton;
    btnEven: TButton;
    btnOdd: TButton;
    spnSteps: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure btnIncClick(Sender: TObject);
    procedure btnEvenClick(Sender: TObject);
    procedure btnOddClick(Sender: TObject);
  private
    procedure DisplayList(aList: TIntegerList);
  end;

var
  NewMainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.DisplayList(aList: TIntegerList);
var
  i: Integer;
begin
  Memo1.Clear;
  Memo1.Lines.BeginUpdate;
  try
    for i in aList do
      Memo1.Lines.Add(IntToStr(i));
  finally
    Memo1.Lines.EndUpdate;
  end;
end;

procedure TMainForm.btnIncClick(Sender: TObject);
var
  IntegerList: TIntegerList;
  SequenceList: IListDataGenerate<Integer>;
begin
  IntegerList := TIntegerList.Create;
  try
    SequenceList := TListSequencedNumber.New(50, 70, spnSteps.Value);
    SequenceList.Build(IntegerList);
    DisplayList(IntegerList);
  finally
    IntegerList.Free;
  end;
end;

procedure TMainForm.btnEvenClick(Sender: TObject);
var
  IntegerList: TIntegerList;
  SequenceList: IListDataGenerate<Integer>;
begin
  IntegerList := TIntegerList.Create;
  try
    SequenceList := TListSequencedEvenNumber.New(50, 70, spnSteps.Value);
    SequenceList.Build(IntegerList);
    DisplayList(IntegerList);
  finally
    IntegerList.Free;
  end;
end;

procedure TMainForm.btnOddClick(Sender: TObject);
var
  IntegerList: TIntegerList;
  SequenceList: IListDataGenerate<Integer>;
begin
  IntegerList := TIntegerList.Create;
  try
    SequenceList := TListSequencedOddNumber.New(50, 70, spnSteps.Value);
    SequenceList.Build(IntegerList);
    DisplayList(IntegerList);
  finally
    IntegerList.Free;
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  i: Integer;
  IntegerList: TIntegerList;
  RandomizeList: IListDataGenerate<Integer>;
begin
  IntegerList := TIntegerList.Create;
  for i := 0 to 100 do
    IntegerList.Add(i);
  try
    RandomizeList := TListRandomize<Integer>.New;
    RandomizeList.Build(IntegerList);
    DisplayList(IntegerList);
  finally
    IntegerList.Free;
  end;
end;

end.
