{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Directory_test;

interface

uses
  SysUtils,
  ooFS.Entry, ooFS.Directory,
  ooFSUtils,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFSDirectoryTest = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure DirectoryPathIsDirectoryTest;
    procedure EntryKindIsDirectory;
    procedure ExistsDirectory_test;
    procedure NonExistsDirectory_test1;
    procedure Directory_testCreatedToday;
    procedure Directory_testModifiedNow;
    procedure Directory_testWithParentNil;
    procedure Directory_testPathResolved;
  end;

implementation

procedure TFSDirectoryTest.EntryKindIsDirectory;
begin
  CheckTrue(TFSDirectory.New(nil, '..\Directory_test').Kind = ekDirectory);
end;

procedure TFSDirectoryTest.ExistsDirectory_test;
begin
  CheckTrue(TFSDirectory.New(nil, '..\Directory_test').Exists);
end;

procedure TFSDirectoryTest.DirectoryPathIsDirectoryTest;
begin
  CheckEquals('..\Directory_test\', TFSDirectory.New(nil, '..\Directory_test').Path);
end;

procedure TFSDirectoryTest.Directory_testCreatedToday;
var
  Directory: IFSDirectory;
begin
  Directory := TFSDirectory.New(nil, '..\Directory_test');
  CheckEquals(Date, Trunc(Directory.Creation));
end;

procedure TFSDirectoryTest.Directory_testModifiedNow;
var
  Directory: IFSDirectory;
begin
  Directory := TFSDirectory.New(nil, '..\Directory_test');
  CheckEquals(FormatDateTime('ddmmyyyyhhmmss', Now), FormatDateTime('ddmmyyyyhhmmss', Directory.Modified));
end;

procedure TFSDirectoryTest.Directory_testPathResolved;
begin
  CheckEquals('..\Directory_test1\', TFSDirectory.New(nil, '..\Directory_test1').Path);
end;

procedure TFSDirectoryTest.Directory_testWithParentNil;
begin
  CheckEquals('..\', TFSDirectory.New(nil, '..\Directory_test1').Parent.Path);
end;

procedure TFSDirectoryTest.NonExistsDirectory_test1;
begin
  CheckFalse(TFSDirectory.New(nil, '..\Directory_test1').Exists);
end;

procedure TFSDirectoryTest.SetUp;
begin
  inherited;
  CreatePath('..\Directory_test');
  CreatePath('..\Directory_test\Directory1');
end;

procedure TFSDirectoryTest.TearDown;
begin
  inherited;
  DeletePath('..\Directory_test');
end;

initialization

RegisterTest(TFSDirectoryTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
