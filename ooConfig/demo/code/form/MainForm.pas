{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Spin,
  ooConfig.Intf, ooINIConfig, ooConfigSectionTest;

type
  TMainForm = class(TForm)
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    SaveButton: TButton;
    LoadButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
  private
    ConfigSectionTest: TConfigSectionTest;
    function IniFileName: String;
    procedure ConfigToControls;
    procedure ControlsToConfig;
  end;

var
  NewMainForm: TMainForm;

implementation

{$R *.dfm}

function TMainForm.IniFileName: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config.ini';
end;

procedure TMainForm.ConfigToControls;
begin
  Edit1.Text := ConfigSectionTest.ValueString;
  CheckBox1.Checked := ConfigSectionTest.ValueBoolean;
  SpinEdit1.Value := ConfigSectionTest.ValueInteger;
end;

procedure TMainForm.ControlsToConfig;
begin
  ConfigSectionTest.ValueString := Edit1.Text;
  ConfigSectionTest.ValueBoolean := CheckBox1.Checked;
  ConfigSectionTest.ValueInteger := SpinEdit1.Value;
end;

procedure TMainForm.SaveButtonClick(Sender: TObject);
begin
  ControlsToConfig;
  TINIConfig.New(IniFileName).SaveSection(ConfigSectionTest);
end;

procedure TMainForm.LoadButtonClick(Sender: TObject);
begin
  TINIConfig.New(IniFileName).LoadSection(ConfigSectionTest);
  ConfigToControls;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ConfigSectionTest := TConfigSectionTest.Create;
  LoadButtonClick(Self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ConfigSectionTest.Free;
end;

end.
