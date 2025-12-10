unit UFunciones;

interface

uses
  SysUtils, System.UITypes;

function StrToAlphaColor(color:string):TAlphaColor;

implementation

function StrToAlphaColor(color:string):TAlphaColor;
begin
  if color[1] = '#' then
    // quito el hash
    color := StringReplace(color,'#','',[rfReplaceAll]);

  color := '$FF'+ color;
  StrToAlphaColor := TAlphaColor(strtoint(color));
end;

end.
