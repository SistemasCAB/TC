program TableroCamas;

uses
  System.StartUpCopy,
  FMX.Forms,
  Windows,
  FMX.Dialogs,
  form_Tablero in 'form_Tablero.pas' {formTablero},
  form_login in 'form_login.pas' {formLogin},
  ModuloDatos in 'ModuloDatos.pas' {datos: TDataModule},
  mensajes_form in 'mensajes_form.pas' {form_mensajes},
  constantes in 'constantes.pas',
  DetallesCama_form in 'DetallesCama_form.pas' {form_DetallesCama},
  UFunciones in 'UFunciones.pas',
  Configuracion_form in 'Configuracion_form.pas' {form_Configuracion},
  CambioDeCama_form in 'CambioDeCama_form.pas' {form_CambioDeCama},
  CambioDeCamaAdmision_form in 'CambioDeCamaAdmision_form.pas' {form_CambioCamaAdmision},
  ServiciosCambio_form in 'ServiciosCambio_form.pas' {form_ServiciosCambio},
  FMX.Image.Base64 in 'FMX.Image.Base64.pas',
  mensajeConfirmacion_form in 'mensajeConfirmacion_form.pas' {form_mensajeConfirmacion},
  AltaDefinitiva_form in 'AltaDefinitiva_form.pas' {form_AltaDefinitiva},
  Aislamientos_form in 'Aislamientos_form.pas' {formAislamiento},
  DateTimeMaskEdit_unit in 'DateTimeMaskEdit_unit.pas',
  AutorizacionesPendientes_form in 'AutorizacionesPendientes_form.pas' {form_AutorizacionesPendientes},
  AltaProbable_form in 'AltaProbable_form.pas' {formAltaProbable},
  TareasReparacion_form in 'TareasReparacion_form.pas' {formTareasReparacion},
  TareasReparacionDetalle_form in 'TareasReparacionDetalle_form.pas' {form_TareasReparacionDetalle};

{$R *.res}

begin
  // Evitar ejecuciones simultánes. Para que funcione debe estar declaradas en uses Windows y Vcl.Dialogs
  CreateMutex(nil, False, 'TC30500974016');
  if GetLastError <> 0 then
    begin
      ShowMessage('La aplicación Tablero de Camas ya está en ejecución.' + #13 + #13 + 'Verifique la barra de tareas, que seguramente la aplicación está minimizada.' + #13 + #13 + 'Gracias');
      Exit;
    end;
  // fin Evitar ejecuciones simultánes
  Application.Initialize;
  Application.CreateForm(Tdatos, datos);
  Application.CreateForm(TformTablero, formTablero);
  Application.Run;
end.
