{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Directory_test;

interface

uses
  SysUtils,
  ooFS.Entry, ooFS.Drive, ooFS.Directory,
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
    procedure CreatedToday;
    procedure ModifiedNow;
    procedure ParentPathNotExists;
    procedure ParentPathExists;
    procedure ParentPathDefinedExists;
    procedure ParentPathDefinedNotExists;
    procedure PathResolved;
    procedure AbsolutePathExists;
    procedure AbsolutePathNotExists;
  end;

implementation

procedure TFSDirectoryTest.EntryKindIsDirectory;
begin
  CheckTrue(TFSDirectory.New(nil, '..\Directory_test').Kind = TFSEntryKind.Directory);
end;

procedure TFSDirectoryTest.ExistsDirectory_test;
begin
  CheckTrue(TFSDirectory.New(nil, '..\Directory_test').Exists);
end;

procedure TFSDirectoryTest.DirectoryPathIsDirectoryTest;
begin
  CheckEquals('..\Directory_test\', TFSDirectory.New(nil, '..\Directory_test').Path);
end;

procedure TFSDirectoryTest.CreatedToday;
var
  Directory: IFSDirectory;
begin
  Directory := TFSDirectory.New(nil, '..\Directory_test');
  CheckEquals(Date, Trunc(Directory.Creation));
end;

procedure TFSDirectoryTest.ModifiedNow;
var
  Directory: IFSDirectory;
begin
  Directory := TFSDirectory.New(nil, '..\Directory_test');
  CheckEquals(FormatDateTime('ddmmyyyyhhmmss', Now), FormatDateTime('ddmmyyyyhhmmss', Directory.Modified));
end;

procedure TFSDirectoryTest.PathResolved;
begin
  CheckEquals('..\Directory_test1\', TFSDirectory.New(nil, '..\Directory_test1').Path);
end;

procedure TFSDirectoryTest.ParentPathNotExists;
begin
  CheckEquals('..\', TFSDirectory.New(nil, 'folder_test99').Parent.Path);
end;

procedure TFSDirectoryTest.ParentPathExists;
var
  ParentPath: String;
  Directory: IFSDirectory;
begin
  Directory := TFSDirectory.New(nil, '..\Directory_test');
  ParentPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  ParentPath := ExpandFileName(ParentPath + '..\');
  ParentPath := ExtractRelativePath(ExtractFileDrive(ParentPath), ParentPath);
  CheckEquals(ParentPath, Directory.Parent.Path);
end;

procedure TFSDirectoryTest.ParentPathDefinedNotExists;
var
  ParentPath: String;
  Parent: IFSDirectory;
begin
  ParentPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  ParentPath := ExpandFileName(ParentPath + '..\');
  ParentPath := ExtractRelativePath(ExtractFileDrive(ParentPath), ParentPath);
  Parent := TFSDirectory.New(TFSDrive.New(ExtractFileDrive(ExtractFilePath(ParamStr(0))), Unknown), ParentPath);
  CheckEquals('..\..\', TFSDirectory.New(nil, '..\not_exists').Parent.Path);
end;

procedure TFSDirectoryTest.ParentPathDefinedExists;
var
  ParentPath: String;
  Parent: IFSDirectory;
begin
  ParentPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  ParentPath := ExpandFileName(ParentPath + '..\');
  ParentPath := ExtractRelativePath(ExtractFileDrive(ParentPath), ParentPath);
  Parent := TFSDirectory.New(TFSDrive.New(ExtractFileDrive(ExtractFilePath(ParamStr(0))), Unknown), ParentPath);
  CheckEquals(ParentPath, TFSDirectory.New(nil, '..\Directory_test').Parent.Path);
end;

procedure TFSDirectoryTest.NonExistsDirectory_test1;
begin
  CheckFalse(TFSDirectory.New(nil, '..\Directory_test1').Exists);
end;

procedure TFSDirectoryTest.AbsolutePathExists;
var
  ParentPath: String;
begin
  ParentPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  ParentPath := ExpandFileName(ParentPath + '..\Directory_test\');
  CheckEquals(ParentPath, TFSDirectory.New(nil, '..\Directory_test').AbsolutePath);
end;

procedure TFSDirectoryTest.AbsolutePathNotExists;
begin
  CheckEquals('..\not_exists\', TFSDirectory.New(nil, '..\not_exists').AbsolutePath);
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
