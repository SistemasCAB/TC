program TCUpdater;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.IOUtils,
  WinApi.Windows,
  Winapi.ShellAPI;

procedure WaitForProcess(const AProcessName: string; TimeoutMs: Integer);
var
  StartTime: Cardinal;
begin
  StartTime := GetTickCount;
  while (GetTickCount - StartTime < Cardinal(TimeoutMs)) do
  begin
    // Esperar que el proceso principal termine
    Sleep(500);
    // Verificar si sigue corriendo (opcional, por simplicidad esperamos fijo)
  end;
end;

var
  SourceFile, DestFile, AppToLaunch: string;
  Attempts: Integer;
  Updated: Boolean;
begin
  // Parámetros: TCUpdater.exe "origen" "destino" "app_a_relanzar"
  if ParamCount < 3 then
    begin
      Writeln('Uso: TCUpdater.exe "origen" "destino" "app_a_relanzar"');
      Writeln('Presione Enter para salir...');
      Readln;
      Exit;
    end;

  SourceFile   := ParamStr(1);  // \\servidor\tablerocamas\TableroCamas.exe
  DestFile     := ParamStr(2);  // C:\TC\TableroCamas.exe
  AppToLaunch  := ParamStr(3);  // C:\TC\TableroCamas.exe

  Writeln('=== TCUpdater iniciado ===');
  Writeln('Origen  : ' + SourceFile);
  Writeln('Destino : ' + DestFile);
  Writeln('Relanzar: ' + AppToLaunch);
  Writeln('Esperando que TableroCamas.exe se cierre...');

  // Esperar que TableroCamas.exe termine (3 segundos)
  Sleep(3000);

  // Intentar copiar hasta 5 veces
  Attempts := 0;
  while Attempts < 5 do
  begin
    try
      Writeln('Intento ' + IntToStr(Attempts + 1) + ' de copia...');
      TFile.Copy(SourceFile, DestFile, True);
      Writeln('Copia exitosa.');
      Updated := True;
      Break;
    except
      on E: Exception do
      begin
        Inc(Attempts);
        Writeln('Error: ' + E.Message);
        Sleep(1000);
      end;
    end;
  end;

  if Updated then
    begin
      if TFile.Exists(AppToLaunch) then
        begin
          Writeln('Relanzando ' + AppToLaunch + '...');
          ShellExecute(0, 'open', PChar(AppToLaunch), nil, nil, SW_SHOWNORMAL);
        end
      else
        Writeln('No se encontró la app a relanzar: ' + AppToLaunch);
    end
  else
    begin
      Writeln('');
      Writeln('No se pudo actualizar después de 5 intentos.');
      Writeln('Verifique acceso a la red y permisos en C:\TC\');
      Writeln('Presione Enter para salir...');
      Readln;  // Pausa solo en caso de error, para poder leer el mensaje
    end;
end.
