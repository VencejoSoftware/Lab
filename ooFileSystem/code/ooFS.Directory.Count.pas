{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Directory.Count;

interface

uses
  ooFS.Directory, ooFS.Directory.Scan,
  ooFS.Command.Intf;

type
  IFSDirectoryCount = interface(IFSCommand<Integer>)
    ['{B416BE24-9862-418C-9D55-464FF781D74C}']
  end;

  TFSDirectoryCount = class sealed(TInterfacedObject, IFSDirectoryCount)
  strict private
    _Directory: IFSDirectory;
    _Recursively: Boolean;
  public
    function Execute: Integer;
    constructor Create(const Directory: IFSDirectory; const Recursively: Boolean);
    class function New(const Directory: IFSDirectory; const Recursively: Boolean): IFSDirectoryCount;
  end;

implementation

function TFSDirectoryCount.Execute: Integer;
var
  DirectoryList: TFSDirectoryList;
begin
  DirectoryList := TFSDirectoryList.Create;
  try
    Result := TFSDirectoryScan.New(_Directory, DirectoryList, _Recursively).Execute;
  finally
    DirectoryList.Free;
  end;
end;

constructor TFSDirectoryCount.Create(const Directory: IFSDirectory; const Recursively: Boolean);
begin
  _Directory := Directory;
  _Recursively := Recursively;
end;

class function TFSDirectoryCount.New(const Directory: IFSDirectory; const Recursively: Boolean): IFSDirectoryCount;
begin
  Result := TFSDirectoryCount.Create(Directory, Recursively);
end;

end.
