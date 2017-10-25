{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.AsString_test;

interface

uses
  SysUtils,
  ooBytes.AsString, ooBytes, ooBytes.Convert,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TBytesAsStringTest = class(TTestCase)
  published
    procedure BytesOf1024Bytes;
    procedure BuildOf1024Bytes;
    procedure BuildAsTypeMBOf6000Bytes;
  end;

implementation

procedure TBytesAsStringTest.BuildAsTypeMBOf6000Bytes;
begin
  CheckEquals('0.01 MB', TBytesAsString.New(TBytesConvert.New(TBytes.New(6000))).BuildAsType(scMB));
end;

procedure TBytesAsStringTest.BuildOf1024Bytes;
begin
  CheckEquals('1.00 KB', TBytesAsString.New(TBytesConvert.New(TBytes.New(1024))).Build);
end;

procedure TBytesAsStringTest.BytesOf1024Bytes;
begin
  CheckEquals(1024, TBytesAsString.New(TBytesConvert.New(TBytes.New(1024))).Bytes);
end;

initialization

RegisterTest(TBytesAsStringTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
