{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFS.Archive.Copy;

interface

uses
  Windows, SysUtils,
  ooFS.Command.Delay,
  ooFS.Archive,
  ooFS.Command.Intf;

type
  IFSArchiveCopy = interface(IFSCommand<Boolean>)
    ['{2896C3DA-A266-4D40-82C8-C8E84C395278}']
  end;

  TFSArchiveCopy = class sealed(TInterfacedObject, IFSArchiveCopy)
  strict private
  const
    DELAY_IN_TRY = 200;
  strict private
    _Archive: IFSArchive;
    _DestinationFileName: String;
    _MaxTries: Byte;
  private
    function TryCopy(const Tries: Byte): Boolean;
    function BuildDestinationFileName(const FileName, Destination: String): String;
  public
    function Execute: Boolean;
    constructor Create(const Archive: IFSArchive; const Destination: String; const MaxTries: Byte = 10);
    class function New(const Archive: IFSArchive; const Destination: String; const MaxTries: Byte = 10): IFSArchiveCopy;
  end;

implementation

function TFSArchiveCopy.TryCopy(const Tries: Byte): Boolean;
begin
  Result := CopyFile(PChar(_Archive.Path), PChar(_DestinationFileName), False);
  if not Result and (Tries < _MaxTries) then
  begin
    TFSCommandDelay.New(DELAY_IN_TRY).Execute;
    Result := TryCopy(Tries + 1);
  end;
end;

function TFSArchiveCopy.Execute: Boolean;
begin
  Result := TryCopy(0);
end;

function TFSArchiveCopy.BuildDestinationFileName(const FileName, Destination: String): String;
begin
  if Length(ExtractFileName(Destination)) < 1 then
    Result := IncludeTrailingPathDelimiter(Destination) + _Archive.Name
  else
    Result := Destination;
end;

constructor TFSArchiveCopy.Create(const Archive: IFSArchive; const Destination: String; const MaxTries: Byte);
begin
  _Archive := Archive;
  _MaxTries := MaxTries;
  _DestinationFileName := BuildDestinationFileName(_Archive.Path, Destination);
end;

class function TFSArchiveCopy.New(const Archive: IFSArchive; const Destination: String;
  const MaxTries: Byte): IFSArchiveCopy;
begin
  Result := TFSArchiveCopy.Create(Archive, Destination, MaxTries);
end;

end.
