{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.Convert_test;

interface

uses
  SysUtils,
  Math,
  ooBytes, ooBytes.Convert,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TBytesConvertTest = class(TTestCase)
  published
    procedure BytesFit;
    procedure KBFit;
    procedure MBFit;
    procedure GBFit;
    procedure TBFit;
    procedure PBFit;
    procedure EBFit;
    procedure ZBFit;
    procedure YBFit;
  end;

implementation

procedure TBytesConvertTest.BytesFit;
begin
  CheckTrue(scBytes = TBytesConvert.New(TBytes.New((Power(1024, Ord(scBytes))))).FitSizeType);
end;

procedure TBytesConvertTest.KBFit;
begin
  CheckTrue(scKB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scKB))))).FitSizeType);
end;

procedure TBytesConvertTest.MBFit;
begin
  CheckTrue(scMB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scMB))))).FitSizeType);
end;

procedure TBytesConvertTest.GBFit;
begin
  CheckTrue(scGB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scGB))))).FitSizeType);
end;

procedure TBytesConvertTest.TBFit;
begin
  CheckTrue(scTB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scTB))))).FitSizeType);
end;

procedure TBytesConvertTest.PBFit;
begin
  CheckTrue(scPB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scPB))))).FitSizeType);
end;

procedure TBytesConvertTest.EBFit;
begin
  CheckTrue(scEB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scEB))))).FitSizeType);
end;

procedure TBytesConvertTest.ZBFit;
begin
  CheckTrue(scYB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scYB))))).FitSizeType);
end;

procedure TBytesConvertTest.YBFit;
begin
  CheckTrue(scZB = TBytesConvert.New(TBytes.New((Power(1024, Ord(scZB))))).FitSizeType);
end;

initialization

RegisterTest(TBytesConvertTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
