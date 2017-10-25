{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.IntToByte_test;

interface

uses
  SysUtils,
  ooBytes.IntToByte,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIntToByteTest = class(TTestCase)
  published
    procedure MinorZero;
    procedure Mayor255;
    procedure Is128;
    procedure Is255;
  end;

implementation

procedure TIntToByteTest.Is128;
begin
  CheckEquals(128, TIntToByte.New(128).Value);
end;

procedure TIntToByteTest.Is255;
begin
  CheckEquals(255, TIntToByte.New(255).Value);
end;

procedure TIntToByteTest.Mayor255;
begin
  CheckEquals(255, TIntToByte.New(1000).Value);
end;

procedure TIntToByteTest.MinorZero;
begin
  CheckEquals(0, TIntToByte.New( - 1000).Value);
end;

initialization

RegisterTest(TIntToByteTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
