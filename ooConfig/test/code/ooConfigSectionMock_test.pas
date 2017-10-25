{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooConfigSectionMock_test;

interface

uses
  SysUtils, Forms,
  ooConfig.Intf, ooINIConfig,
  ooConfigSectionMock,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  Windows,
  TestFramework
{$ENDIF};

type
  TConfigSectionMockTest = class(TTestCase)
  private
    function IniFileName: String;
    function SerializeSection(const Section: IConfigSection): Boolean;
    function CreateSection: IConfigSection;
  published
    procedure SerializeConfig;
    procedure DeserializeConfig;
  end;

implementation

function TConfigSectionMockTest.IniFileName: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  Result := Result + 'Config.ini';
end;

function TConfigSectionMockTest.CreateSection: IConfigSection;
begin
  Result := TConfigSectionMock.New;
  with TConfigSectionMock(Result) do
  begin
    ValueInteger := 99987;
    ValueString := 'Test mock string.';
    ValueBoolean := True;
    ValueFloat := 123.456;
    ValueDateTime := Date;
  end;
end;

function TConfigSectionMockTest.SerializeSection(const Section: IConfigSection): Boolean;
begin
  Result := TINIConfig.New(IniFileName).SaveSection(Section);
end;

procedure TConfigSectionMockTest.SerializeConfig;
begin
  if FileExists(IniFileName) then
    SysUtils.DeleteFile(IniFileName);
  CheckTrue(SerializeSection(CreateSection));
  CheckTrue(FileExists(IniFileName));
end;

procedure TConfigSectionMockTest.DeserializeConfig;
var
  Section: IConfigSection;
begin
  if not FileExists(IniFileName) then
    SerializeSection(CreateSection);
  Section := TConfigSectionMock.New;
  TINIConfig.New(IniFileName).LoadSection(Section);
  CheckEquals(99987, TConfigSectionMock(Section).ValueInteger);
  CheckEquals('Test mock string.', TConfigSectionMock(Section).ValueString);
  CheckTrue(TConfigSectionMock(Section).ValueBoolean);
  CheckEquals(123.456, TConfigSectionMock(Section).ValueFloat);
  CheckEquals(Date, TConfigSectionMock(Section).ValueDateTime);
end;

initialization

RegisterTest(TConfigSectionMockTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
