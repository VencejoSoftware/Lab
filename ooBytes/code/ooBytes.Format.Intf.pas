{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooBytes.Format.Intf;

interface

uses
  ooBytes, ooBytes.Convert;

type
  IBytesFormat = interface(IBytes)
    ['{D8FD710B-0A6D-4D50-80D8-AA05CFF776BE}']
    function Build: String;
    function BuildAsType(const ByteScale: TByteScale): String;
  end;

implementation

end.
