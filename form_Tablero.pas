unit form_Tablero;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  System.ImageList,
  FMX.ImgList,
  IniFiles,
  idHTTP,
  System.JSON,
  REST.Types,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Response.Adapter,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  System.NetEncoding,
  FMX.ListBox,
  System.Rtti,
  System.Bindings.Outputs,
  Fmx.Bind.Editors,
  Data.Bind.EngExt,
  Fmx.Bind.DBEngExt,
  Data.Bind.DBScope,
  FMX.GIFImage,
  System.Generics.Collections, // agrego el diccionario al form

  System.SyncObjs,System.Threading, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TCamaUI = class
  public
    Borde: TRectangle;
    PanelB: TRectangle;
    etiqueta: TRectangle;
    LyDatos: TLayout;
    LyCama: TLayout;
    lbNroCama: TLabel;
    LbPrincipal: TLabel;
    LbSecundaria: TLabel;
    fotoPac: TImage;
    iconoAislamiento: TImage;
    iconoAislamientoC: TImage;
    iconoAislamientoGC: TImage;
    iconoAislamientoAR: TImage;
    iconoAislamientoN: TImage;
    iconoAislamientoCD: TImage;
    iconoAislamientoSC: TImage;
    lbPrecaucion: TLabel;
    lbAlta :TLabel;
  end;

type
  TformTablero = class(TForm)
    barraTitulo: TLayout;
    Rectangle1: TRectangle;
    panelLogin: TLayout;
    lb_tit_usuarioActivo: TLabel;
    lb_usuarioActivo: TLabel;
    lyMenuLateral: TLayout;
    Rectangle2: TRectangle;
    botonActualizar: TSpeedButton;
    menuSeparador1: TRectangle;
    botonFiltrarPorEstado: TSpeedButton;
    menuSeparador2: TRectangle;
    botonCambiarServicio: TSpeedButton;
    menuSeparador3: TRectangle;
    botonSalir: TSpeedButton;
    menuSeparador4: TRectangle;
    Layout3: TLayout;
    lb_menu_version: TLabel;
    lb_version_fecha: TLabel;
    btnMenu: TImage;
    botonCerrarSesion: TSpeedButton;
    Image2: TImage;
    botonMenu: TLayout;
    nombreServicio: TLabel;
    RelojConsultarCambios: TTimer;
    alertas: TFDMemTable;
    alertasNueva: TFDMemTable;
    relojParpadeo: TTimer;
    alertasidCama: TIntegerField;
    contenedor: TScrollBox;
    barra: TProgressBar;
    espere: TGIFImage;
    botonConsultarCambios: TButton;
    botonConfiguracion: TSpeedButton;
    menuSeparador5: TRectangle;
    camas: TFDMemTable;
    versiones: TFDMemTable;
    versionesversionActual: TFloatField;
    versionesautorizada: TWideStringField;
    versionesversionAutorizada: TFloatField;
    versionesfecha: TWideStringField;
    versionesmensaje: TWideStringField;
    permisos: TFDMemTable;
    apagarAlertasTB: TFDMemTable;
    camasidcama: TIntegerField;
    camascama: TStringField;
    camasidHabitacion: TIntegerField;
    camashabitacion: TStringField;
    camaspiso: TStringField;
    camasidEstado: TIntegerField;
    camasestado: TStringField;
    camascolor: TStringField;
    camasobservaciones: TStringField;
    camaspaciCodigo: TIntegerField;
    camasnombrePaciente: TStringField;
    camasapellidoPaciente: TStringField;
    camasnroDocumento: TStringField;
    camassexo: TStringField;
    camassexoTexto: TStringField;
    camasfechaIngresoInstitucion: TStringField;
    camasfechaIngresoCama: TStringField;
    camascobertura: TStringField;
    camasfantasia: TStringField;
    camasplan: TStringField;
    camasnroAfiliado: TStringField;
    camasidInternacion: TIntegerField;
    camasprofesionalAltaMedica: TStringField;
    camastipoAltaMedica: TStringField;
    camasfotoPaciente: TMemoField;
    camasprocedimientosNoCumplidos: TIntegerField;
    camasmedicacionNoProgramada: TIntegerField;
    camasmedicacionNoAplicada: TIntegerField;
    camasaislamiento_contacto: TStringField;
    camasaislamiento_respiratorio: TStringField;
    camasaislamiento_gota: TStringField;
    camasaislamiento_neutropenico: TStringField;
    camasaislamiento_cd: TStringField;
    camasaislamiento_sc: TStringField;
    camascamaEnAislamiento: TIntegerField;
    camasacompanante: TIntegerField;
    camasobservacionesAcompanante: TStringField;
    camasorden: TIntegerField;
    camascambioCamaPendiente: TIntegerField;
    camasalertas: TIntegerField;
    camastareasPendientes: TIntegerField;
    camasaltaProbableFecha: TStringField;
    camasaltaProbableTipo: TStringField;
    camasaltaProbableDniUsuario: TStringField;
    camasreservaMotivo: TStringField;
    camasreservaFecha: TStringField;
    camasreservadaPorDni: TStringField;
    camasreservadaPorNombre: TStringField;
    camasidReserva: TIntegerField;
    camasreservaFechaCancelada: TStringField;
    camasreservaCanceladaPorDni: TStringField;
    camasreservaCanceladaPorNombre: TStringField;
    camasreservaPacienteDni: TStringField;
    camasreservaPacienteNombre: TStringField;
    camasidMotivoFinReserva: TIntegerField;
    camasreservaIdSolicitudCambio: TIntegerField;
    camas2: TFDMemTable;
    camas2idCama: TIntegerField;
    camas2cama: TStringField;
    camas2idHabitacion: TIntegerField;
    camas2habitacion: TStringField;
    camas2piso: TStringField;
    camas2idEstado: TIntegerField;
    camas2estado: TStringField;
    camas2color: TStringField;
    camas2observaciones: TStringField;
    camas2paciCodigo: TIntegerField;
    camas2nombrePaciente: TStringField;
    camas2apellidoPaciente: TStringField;
    camas2nroDocumento: TStringField;
    camas2sexo: TStringField;
    camas2sexoTexto: TStringField;
    camas2fechaIngresoInstitucion: TStringField;
    camas2fechaIngresoCama: TStringField;
    camas2cobertura: TStringField;
    camas2fantasia: TStringField;
    camas2plan: TStringField;
    camas2nroAfiliado: TStringField;
    camas2idInternacion: TIntegerField;
    camas2profesionalAltaMedica: TStringField;
    camas2tipoAltaMedica: TStringField;
    camas2fotoPaciente: TMemoField;
    camas2procedimientosNoCumplidos: TIntegerField;
    camas2medicacionNoProgramada: TIntegerField;
    camas2medicacionNoAplicada: TIntegerField;
    camas2aislamiento_contacto: TStringField;
    camas2aislamiento_respiratorio: TStringField;
    camas2aislamiento_gota: TStringField;
    camas2aislamiento_neutropenico: TStringField;
    camas2aislamiento_cd: TStringField;
    camas2aislamiento_sc: TStringField;
    camas2camaEnAislamiento: TIntegerField;
    camas2acompanante: TIntegerField;
    camas2observacionesAcompanante: TStringField;
    camas2orden: TIntegerField;
    camas2cambioCamaPendiente: TIntegerField;
    camas2alertas: TIntegerField;
    camas2tareasPendientes: TIntegerField;
    camas2altaProbableFecha: TStringField;
    camas2altaProbableTipo: TStringField;
    camas2altaProbableDniUsuario: TStringField;
    camas2reservaMotivo: TStringField;
    camas2reservaFecha: TStringField;
    camas2reservadaPorDni: TStringField;
    camas2reservadaPorNombre: TStringField;
    camas2idReserva: TIntegerField;
    camas2reservaFechaCancelada: TStringField;
    camas2reservaCanceladaPorDni: TStringField;
    camas2reservaCanceladaPorNombre: TStringField;
    camas2reservaPacienteDni: TStringField;
    camas2reservaPacienteNombre: TStringField;
    camas2idMotivoFinReserva: TIntegerField;
    camas2reservaIdSolicitudCambio: TIntegerField;
    camastdocCodigo: TIntegerField;
    camas2tdocCodigo: TIntegerField;
    servicio: TFDMemTable;
    servicioidServicio: TIntegerField;
    servicionombreServicio: TStringField;
    servicioidTipoInternacion: TIntegerField;
    serviciotipoInternacion: TStringField;
    serviciocambioCamaAreaCerrada: TIntegerField;
    serviciogestionaCamas: TIntegerField;
    serviciopermisos: TMemoField;
    camastdocDescripcion: TStringField;
    camas2tdocDescripcion: TStringField;
    permisosidPermiso: TIntegerField;
    permisosidModulo: TIntegerField;
    permisosnombreModulo: TStringField;
    permisosdescripcionModulo: TStringField;
    permisoscontrolTotal: TIntegerField;
    camaskpc: TIntegerField;
    camas2kpc: TIntegerField;
    botonAutorizar: TSpeedButton;
    Rectangle3: TRectangle;
    camasaltaProbableNombreUsuario: TStringField;
    camas2altaProbableNombreUsuario: TStringField;
    camasfechaAltaMedica: TStringField;
    camas2fechaAltaMedica: TStringField;
    lb_usuarioDocumento: TLabel;
    serviciosUsuario: TFDMemTable;
    serviciosUsuarioidServicio: TIntegerField;
    serviciosUsuarionombreServicio: TStringField;
    serviciosUsuarioidTipoInternacion: TIntegerField;
    serviciosUsuariocambioCamaAreaCerrada: TIntegerField;
    serviciosUsuariogestionaCamas: TIntegerField;
    botonSalirFullScreen: TSpeedButton;
    Image3: TImage;
    procedure botonSalirClick(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure botonCerrarSesionApplyStyleLookup(Sender: TObject);
    procedure botonCerrarSesionClick(Sender: TObject);
    procedure botonActualizarClick(Sender: TObject);
    procedure RelojConsultarCambiosTimer(Sender: TObject);
    procedure ConsultarCambios;
    procedure ActualizarCamas;
    procedure FormShow(Sender: TObject);
    procedure Espera(comando:string);
    procedure botonConsultarCambiosClick(Sender: TObject);
    procedure nuevaAlerta(cama, tipo, idInternacion, paciCodigo: integer);
    procedure verificarIconosAislamientos(idCama: integer);
    procedure relojParpadeoTimer(Sender: TObject);
    procedure blinking(idCama: string);
    procedure botonConfiguracionClick(Sender: TObject);
    procedure ActualizarServicio;
    procedure FormActivate(Sender: TObject);
    procedure botonCambiarServicioClick(Sender: TObject);
    procedure controlarVersion;
    function permisoModulo(idModulo: integer): integer;
    procedure apagarAlertasCamasDisponibles();

    procedure CargarPermisosDesdeJson(const JsonStr: string; Permisos: TFDMemTable);
    procedure FormDestroy(Sender: TObject);
    procedure LimpiarCacheCamas;
    procedure botonAutorizarClick(Sender: TObject);
    procedure botonSalirFullScreenClick(Sender: TObject);

  private
    { Private declarations }
    FApagandoAlertas: Integer;
    FCamasUI: TDictionary<Integer, TCamaUI>;
    gifEspere  : TGIFImage;
    procedure clicBotonCama(sender:TObject);
  public
    { Public declarations }
    anchoScrollVertical:integer;
    filtroEstado:integer; // solo se mostrarán las camas que tengan este estado.

    bordeCama : TRectangle;
    panelB :TRectangle;
    //contenedor: TScrollBox;
    LyFoto, LyDatos, LyIconos, LyCama : TLayout;
    botonCama : TSpeedButton;
    verPaciente:integer;
  end;

var
  formTablero: TformTablero;

implementation

{$R *.fmx}

uses form_login, ModuloDatos, constantes, DetallesCama_form, Configuracion_form, ServiciosCambio_form, UFunciones,
  FMX.Image.Base64, RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D,
  AutorizacionesPendientes_form;

function TformTablero.permisoModulo(idModulo: integer): integer;
begin
  // Permisos: 0 = sin permiso, 1 = solo lectura, 2 = control total

  Result := 0; // valor por defecto, sin permiso

  if permisos.Locate('idModulo', idModulo, []) then
    Result := permisos.FieldByName('controlTotal').AsInteger;
end;

procedure TformTablero.LimpiarCacheCamas;
var
  ui: TCamaUI;
begin
  for ui in FCamasUI.Values do
    ui.Free;

  FCamasUI.Clear;
end;

procedure TformTablero.botonSalirClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TformTablero.botonSalirFullScreenClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TformTablero.RelojConsultarCambiosTimer(Sender: TObject);
begin
  barra.Value := barra.Value  + 1;
  if barra.Value = datos.segundos then
    begin
      RelojConsultarCambios.Enabled := false;
      //barra.Value := 0; // esto debe ir dentro de ConsultarCambios.
      ConsultarCambios;
    end;
end;

procedure TformTablero.relojParpadeoTimer(Sender: TObject);
begin
  if alertas.RecordCount > 0 then
    begin
      alertas.First;
      repeat
        blinking(alertasidCama.AsString);
        alertas.Next;
      until (alertas.Eof);
    end;
end;

procedure TformTablero.verificarIconosAislamientos(idCama: integer);
var
  ui: TCamaUI;
begin
  if FCamasUI.TryGetValue(idCama, ui) then
    begin
      if permisoModulo(3) = 0 then
        begin
          if camas2camaEnAislamiento.AsInteger = 1 then
            begin
              ui.iconoAislamiento.Base64(aislamiento);
              ui.iconoAislamiento.Visible := true;
              ui.lbPrecaucion.Text := 'AISLAMIENTO';
            end
        end
      else
        begin
          if camas2idEstado.AsInteger = 2 then
            begin
                if (camas2aislamiento_contacto.AsString <> '') and (camas2kpc.AsInteger = 1) then
                  ui.iconoAislamientoC.Base64(aislamientoKPC)
                else
                  ui.iconoAislamientoC.Base64(aislamientoAC);

                ui.iconoAislamientoC.Visible  := camas2aislamiento_contacto.AsString <> '';
                ui.iconoAislamientoAR.Visible := camas2aislamiento_respiratorio.AsString <> '';
                ui.iconoAislamientoGC.Visible := camas2aislamiento_gota.AsString <> '';
                ui.iconoAislamientoN.Visible  := camas2aislamiento_neutropenico.AsString <> '';
                ui.iconoAislamientoCD.Visible := camas2aislamiento_cd.AsString <> '';
                ui.iconoAislamientoSC.Visible := camas2aislamiento_sc.AsString <> '';
              end
            else
              begin
                ui.iconoAislamientoC.Visible  := false;
                ui.iconoAislamientoAR.Visible := false;
                ui.iconoAislamientoGC.Visible := false;
                ui.iconoAislamientoN.Visible  := false;
                ui.iconoAislamientoCD.Visible := false;
                ui.iconoAislamientoSC.Visible := false;
              end;
        end;
    end;
end;


procedure TformTablero.FormShow(Sender: TObject);
begin
  ActualizarServicio;
  ActualizarCamas;
end;

procedure TformTablero.nuevaAlerta(cama, tipo, idInternacion, paciCodigo: integer);
var
  response: IResponse;
begin
  // inserta una alerta de acuerdo a los parámetros recibidos.

  response := TRequest.New.BaseURL(datos.urlTC)
                      .Resource('tablerocamas/alertaNueva')
                      .AddHeader('TokenAcceso', datos.tokenAcceso)
                      .AddParam('idCama', cama.ToString)
                      .AddParam('idTipoAlerta', tipo.ToString)
                      .AddParam('paciCodigo', paciCodigo.ToString)
                      .AddParam('idInternacion', idInternacion.ToString)
                      .Accept('application/json')
                      .Adapters(TDataSetSerializeAdapter.New(alertasNueva))
                      .Post;
end;

procedure TformTablero.btnMenuClick(Sender: TObject);
begin
  if lyMenuLateral.Visible then
    lyMenuLateral.Visible := false
  else
    lyMenuLateral.Visible := true;
end;

procedure TformTablero.botonConfiguracionClick(Sender: TObject);
begin
  RelojConsultarCambios.Enabled := false;
  lyMenuLateral.Visible := false;
  Application.CreateForm(Tform_Configuracion, form_Configuracion);
  form_Configuracion.Height := formTablero.Height;
  form_Configuracion.Width := formTablero.Width;
  form_Configuracion.ShowModal;
end;

procedure TformTablero.botonConsultarCambiosClick(Sender: TObject);
begin
  ConsultarCambios;
end;

procedure TformTablero.clicBotonCama(sender: TObject);
var
  idCama:integer;
begin
  if datos.autologin = 0 then
    begin
      // detengo el reloj de actualización de las camas mientras está abierta la ventana de detalles de la cama.
      RelojConsultarCambios.Enabled := false;

      idCama := (sender as TSpeedButton).Tag;

      Application.CreateForm(Tform_DetallesCama, form_DetallesCama);
      form_DetallesCama.idCama := idCama;
      form_DetallesCama.Height  := formTablero.Height;
      form_DetallesCama.Width   := formTablero.Width;
      form_DetallesCama.Actualizar(idCama);
      form_DetallesCama.Showmodal;

      ConsultarCambios;
    end
  else
    begin
      //datos.VerMensaje('ERROR','En modo Autologin, esta funcionalidad no está permitida','Aceptar','ERROR',0);
    end;
end;

{************************
    ACTUALIZAR CAMAS
************************}
procedure TformTablero.ActualizarCamas;
var
  ui: TCamaUI;
  anchoContenedor:Integer;
  nLin, nCol, nPosX, nPosY, nRegistros, nColumnas,totalLineas:integer;
  mens:string; // variable que contendrá el mensaje a mostrar al usuario.

  Input, Output : TStringStream;
  pic:string;
  response: IResponse;
  recursoCamas : string;

  etiqueta: TRectangle;
  lbNroCama: TLabel;
  lbPrincipal: TLabel;
  lbSecundaria: TLabel;
  fotoPac: TImage;
  lb_Alta: TLabel;
  iconoAislamiento, iconoAislamientoC,iconoAislamientoGC, iconoAislamientoAR, iconoAislamientoN, iconoAislamientoCD, iconoAislamientoSC: TImage;
  lbPrecaucion: TLabel;
begin
  LimpiarCacheCamas;

  RelojConsultarCambios.Enabled := false;

  verPaciente := permisoModulo(1);


  // INICIO LA ACTUALIZACIÓN
  Espera('play');

  if Assigned(contenedor) then
      FreeAndNil(contenedor);

  contenedor := TScrollBox.Create(Self);
  contenedor.Parent := formTablero;
  contenedor.Name := 'contenedorCamas';
  contenedor.Align := TAlignLayout.Client;

  filtroEstado := 0;

  anchoContenedor := Trunc(contenedor.Width) - anchoScrollVertical; // Width es tipo sigle, por eso uso Trunc

  // creo un hilo para buscar las camas
  TThread.CreateAnonymousThread(procedure
    begin
      try
        // me contecto a la API del TC para obtener las camas.
        recursoCamas := '/tablerocamas/camas';
        response := TRequest.New
              .BaseURL(datos.urlTC)
              .Resource(recursoCamas)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio', datos.servicio.ToString)
              .AddParam('tareasPendientes', datos.pendientes.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(camas))
              .Get;

        if response.StatusCode = 200 then
          begin
            if camas.RecordCount > 0 then
              begin
                TThread.Synchronize(nil, procedure
                  begin
                    nRegistros := camas.RecordCount;
                    nPosX := 0;
                    nPosY := 0;
                    nColumnas := datos.col;

                    if(nRegistros mod nColumnas) = 0 then
                      totalLineas := (nRegistros div nColumnas)
                    else
                      totalLineas := (nRegistros div nColumnas) + 1;

                    camas.First;
                    nLin := 1;

                    repeat
                      nCol := 1;
                      repeat
                        // creo el rectángulo del borde de la cama
                        bordeCama := TRectangle.Create(Self);
                        bordeCama.Parent := contenedor;
                        bordeCama.Position.X := nPosX + 1;
                        bordeCama.Position.Y := nPosY + 1;
                        bordeCama.Width := (anchoContenedor div nColumnas)-1;
                        bordeCama.Height := datos.alto;
                        bordeCama.Name := 'bordeCama'+ camasidCama.AsString;

                        bordeCama.Padding.Top := datos.pad;
                        bordeCama.Padding.Bottom := datos.pad;
                        bordeCama.Padding.Left := datos.pad;
                        bordeCama.Padding.Right := datos.pad;

                        bordeCama.Fill.Kind := TbrushKind.None;
                        bordeCama.Stroke.Kind := TbrushKind.None;

                        // creo el panelInterior
                        panelB := TRectangle.Create(Self);
                        panelB.Parent := bordeCama;
                        panelB.Position.X := 0;
                        panelB.Position.Y := 0;
                        panelB.Name := 'panelB'+ camasidCama.AsString;
                        panelB.Width := 1;
                        panelB.Height := 1;
                        panelB.Align := TAlignLayout.Client;
                        panelB.Fill.Kind := TbrushKind.Solid;
                        panelB.Fill.Color := TAlphaColorRec.White;
                        panelB.Stroke.Kind := TbrushKind.None;

                        // etiqueta de color
                        etiqueta := TRectangle.Create(Self);
                        with etiqueta do
                          begin
                            Parent := panelB;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 15;
                            Align := TAlignLayout.Left;
                            Name := 'etiqueta'+ camasidCama.AsString;
                            Fill.Kind := TbrushKind.Solid;
                            Fill.Color := TAlphaColor(StrToAlphaColor(camascolor.AsString));
                            Stroke.Kind := TbrushKind.None;
                            HitTest := false;
                          end;

                        // Layout Datos
                        LyDatos := TLayout.Create(Self);
                        LyDatos.Parent := panelB;
                        LyDatos.Position.X :=1;
                        LyDatos.Position.Y := 1;
                        LyDatos.Width := 1;
                        LyDatos.Height := 1;
                        LyDatos.Align := TAlignLayout.Client;
                        LyDatos.Name :=  'lyDatos'+ camasidCama.AsString;
                        LyDatos.Margins.Left := 5;

                        // Layout Cama
                        LyCama := TLayout.Create(Self);
                        LyCama.Parent := LyDatos;
                        LyCama.Position.X :=1;
                        LyCama.Position.Y := 1;
                        LyCama.Height := 40;
                        LyCama.Align := TAlignLayout.Top;
                        LyCama.Name :=  'lyCama'+ camasidCama.AsString;

                        // ALTA MÉDICA
                        lb_Alta := TLabel.Create(Self);
                        with lb_Alta do
                          begin
                            Parent := LyCama;
                            Name := 'lb_Alta' + camasidCama.AsString;
                            Align := TAlignLayout.Right;
                            StyledSettings := [TStyledSetting.Family];
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.Font.Size := 14;
                            TextSettings.WordWrap := true;
                            Visible := true;

                            if (verPaciente <> 0) and (camasfechaAltaMedica.AsString <> '') then
                              begin
                                Text := 'ALTA MÉDICA' + #13 + Copy(camasfechaAltaMedica.AsString, 1, 16);
                                TextSettings.FontColor := TAlphaColorRec.Red;

                              end
                            else
                              begin
                                if camasaltaProbableFecha.AsString <> '' then
                                  begin
                                    Text := 'ALTA PROBABLE' + #13 + Copy(camasaltaProbableFecha.AsString, 1, 16);
                                    TextSettings.FontColor := TAlphaColorRec.Blue;
                                  end
                                else
                                  begin
                                    Text := '';
                                  end;
                              end;
                          end;

//                        // ALTA PROBABLE
//                        lb_AltaProbable := TLabel.Create(Self);
//                        with lb_AltaProbable do
//                          begin
//                            Parent := LyCama;
//                            Name := 'lb_AltaProbable' + camasidCama.AsString;
//                            Align := TAlignLayout.Right;
//                            Text := 'ALTA PROBABLE: ' + #13 + Copy(camasaltaProbableFecha.AsString, 1, 16);
//
//                            StyledSettings := [TStyledSetting.Family];
//                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
//                            TextSettings.Font.Size := 14;
//                            TextSettings.WordWrap := true;
//                            TextSettings.FontColor := TAlphaColorRec.Blue;
//                            if (verPaciente <> 0) and (camasfechaAltaMedica.AsString = '') and (camasaltaProbableFecha.AsString <> '') then
//                              Visible := true
//                            else
//                              Visible := false;
//                          end;


                        // Ícono Alta Probable
//                        iconoAltaProbable := TImage.Create(Self);
//                        with iconoAltaProbable do
//                          begin
//                            Parent := LyCama;
//                            Position.X :=1;
//                            Position.Y := 1;
//                            Width := 40;
//                            Height := 50;
//                            Align := TAlignLayout.Right;
//                            Name := 'IconoAltaProbable'+ camasidCama.AsString;
//                            WrapMode := TImageWrapMode.Fit;
//                            Base64(altaProbable);
//                            HitTest := false;
//                            if (verPaciente <> 0) and (camasfechaAltaMedica.AsString = '') and (camasaltaProbableFecha.AsString <> '') then
//                              Visible := true
//                            else
//                              Visible := false;
//                          end;
//
//                        // Ícono Alta
//                        iconoAlta := TImage.Create(Self);
//                        with iconoAlta do
//                          begin
//                            Parent := LyCama;
//                            Position.X :=1;
//                            Position.Y := 1;
//                            Width := 40;
//                            Height := 50;
//                            Align := TAlignLayout.Right;
//                            Name := 'IconoAlta'+ camasidCama.AsString;
//                            WrapMode := TImageWrapMode.Fit;
//                            Base64(icono_alta);
//                            HitTest := false;
//                            if (verPaciente <> 0) and (camasfechaAltaMedica.AsString <> '') then
//                              Visible := true
//                            else
//                              Visible := false;
//                          end;


                        // Número de Cama
                        lbNroCama := TLabel.Create(Self);
                        with lbNroCama do
                          begin
                            Parent := LyCama;
                            Position.X :=1;
                            Position.Y := 1;
                            Height := 40;
                            Align := TAlignLayout.Client;
                            Name := 'lbNroCama'+ camasidCama.AsString;
                            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
                            TextSettings.Font.Size := 36;
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.HorzAlign := TTextAlign.Leading;
                            Text := camascama.AsString;
                            HitTest := false;
                          end;


                        // Línea secundaria
                        lbSecundaria :=  TLabel.Create(Self);
                        with lbSecundaria do
                          begin
                            Parent := LyDatos;
                            Position.X :=1;
                            Position.Y := 1;
                            Height := 17;
                            Align := TAlignLayout.Top;
                            HitTest := false;
                            Name := 'lb_linea_secundaria'+ camasidCama.AsString;
                            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor, TStyledSetting.Size];
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.HorzAlign := TTextAlign.Leading;
                            HitTest := false;
                            if camasidEstado.AsInteger = 2 then
                              begin
                                if verPaciente <> 0 then
                                  Text := camastdocDescripcion.AsString + ': ' + camasnroDocumento.AsString
                                else
                                  Text := '';
                              end
                            else
                              Text := '';
                          end;

                        // Línea principal
                        lbPrincipal :=  TLabel.Create(Self);
                        with lbPrincipal do
                          begin
                            Parent := LyDatos;
                            Position.X :=1;
                            Position.Y := 1;
                            Height := 22;
                            Align := TAlignLayout.Top;
                            HitTest := false;
                            Name := 'lb_linea_principal'+ camasidCama.AsString;
                            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
                            TextSettings.Font.Size := 13;
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.HorzAlign := TTextAlign.Leading;
                            HitTest := false;
                            if camasidEstado.AsInteger = 2 then
                              if verPaciente <> 0 then
                                Text := camasapellidoPaciente.AsString + ', ' + camasnombrePaciente.AsString
                              else
                                Text := uppercase(camasestado.AsString)
                            else
                              Text := uppercase(camasestado.AsString);
                          end;

                        // Layout Iconos
                        LyIconos := TLayout.Create(Self);
                        LyIconos.Parent := LyDatos;
                        LyIconos.Position.X :=1;
                        LyIconos.Position.Y := 1;
                        LyIconos.Width := 1;
                        LyIconos.Height := 1;
                        LyIconos.Align := TAlignLayout.Client;
                        LyIconos.Name :=  'lyIconos'+ camasidCama.AsString;
                        LyIconos.Margins.Left := 5;
                        LyIconos.HitTest := false;

                        if permisoModulo(3) = 0 then // si no tienen permisos para ver los aislamientos.
                          begin
                            // sin permiso
                            // verifico si tiene algún tipo de aislamiento
                            if camascamaEnAislamiento.AsInteger = 1 then
                              begin
                                iconoAislamiento := TImage.Create(Self);
                                with iconoAislamiento do
                                  begin
                                    Parent := LyIconos;
                                    Position.X :=1;
                                    Position.Y := 1;
                                    Width := 40;
                                    Height := 50;
                                    Align := TAlignLayout.Left;
                                    Name := 'aislamientoNoAccede'+ camasidCama.AsString;
                                    WrapMode := TImageWrapMode.Fit;
                                    Base64(aislamiento);
                                    HitTest := false;
                                    Visible := true;
                                  end;

                                // texto indicando que hay aislamientos
                                lbPrecaucion := TLabel.Create(Self);
                                with lbPrecaucion do
                                  begin
                                    Parent := LyIconos;
                                    Position.X :=45;
                                    Position.Y := 20;
                                    Height := 17;
                                    Align := TAlignLayout.None;
                                    HitTest := false;
                                    Name := 'lb_lineaPrecuacion'+ camasidCama.AsString;
                                    StyledSettings := StyledSettings - [TStyledSetting.Family, TStyledSetting.FontColor, TStyledSetting.Size];
                                    Font.Style := Font.Style - [TFontStyle.fsBold];
                                    TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                                    TextSettings.HorzAlign := TTextAlign.Leading;
                                    TextSettings.FontColor := TAlphaColorRec.Red;
                                    TextSettings.Font.Size := 13;
                                    HitTest := false;
                                    Text := 'AISLAMIENTO';
                                  end;
                              end;
                          end
                        else
                          begin
                            // permiso de lectura (1) y control total (2)

                            // Ícono Aislamiento de Contacto
                            iconoAislamientoC := TImage.Create(Self);
                            with iconoAislamientoC do
                              begin
                                Parent := LyIconos;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 40;
                                Height := 50;
                                Align := TAlignLayout.Left;
                                Name := 'aislamientoAC'+ camasidCama.AsString;
                                WrapMode := TImageWrapMode.Fit;
                                if camaskpc.AsInteger = 0 then
                                  Base64(aislamientoAC)
                                else
                                  Base64(aislamientoKPC);
                                HitTest := false;
                                if camasaislamiento_contacto.AsString <> '' then
                                  Visible := true
                                else
                                  Visible := false;
                              end;


                            // Ícono Aislamiento Gota Contacto
                            iconoAislamientoGC := TImage.Create(Self);
                            with iconoAislamientoGC do
                              begin
                                Parent := LyIconos;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 40;
                                Height := 50;
                                Align := TAlignLayout.Left;
                                Name := 'aislamientoAG'+ camasidCama.AsString;
                                WrapMode := TImageWrapMode.Fit;
                                Base64(aislamientoAG);
                                HitTest := false;
                                if camasaislamiento_gota.AsString <> '' then
                                  Visible := true
                                else
                                  Visible := false;
                              end;


                            // Ícono Aislamiento Aire Respiratorio
                            iconoAislamientoAR := TImage.Create(Self);
                            with iconoAislamientoAR do
                              begin
                                Parent := LyIconos;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 40;
                                Height := 50;
                                Align := TAlignLayout.Left;
                                Name := 'aislamientoAR'+ camasidCama.AsString;
                                WrapMode := TImageWrapMode.Fit;
                                Base64(aislamientoAR);
                                HitTest := false;
                                if camasaislamiento_respiratorio.AsString <> '' then
                                  Visible := true
                                else
                                  Visible := false;
                              end;


                            // Ícono Aislamiento de Protección Neutropenico
                            iconoAislamientoN := TImage.Create(Self);
                            with iconoAislamientoN do
                              begin
                                Parent := LyIconos;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 40;
                                Height := 50;
                                Align := TAlignLayout.Left;
                                Name := 'aislamientoAN'+ camasidCama.AsString;
                                WrapMode := TImageWrapMode.Fit;
                                Base64(aislamientoAN);
                                HitTest := false;
                                if camasaislamiento_neutropenico.AsString <> '' then
                                  Visible := true
                                else
                                  Visible := false;
                              end;


                            // Ícono Aislamiento CD
                            iconoAislamientoCD := TImage.Create(Self);
                            with iconoAislamientoCD do
                              begin
                                Parent := LyIconos;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 40;
                                Height := 50;
                                Align := TAlignLayout.Left;
                                Name := 'aislamientoCD'+ camasidCama.AsString;
                                WrapMode := TImageWrapMode.Fit;
                                Base64(aislamientoCD);
                                HitTest := false;
                                if camasaislamiento_cd.AsString <> '' then
                                  Visible := true
                                else
                                  Visible := false;
                              end;

                            // Ícono Aislamiento SC
                            iconoAislamientoSC := TImage.Create(Self);
                            with iconoAislamientoSC do
                              begin
                                Parent := LyIconos;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 40;
                                Height := 50;
                                Align := TAlignLayout.Left;
                                Name := 'aislamientoSC'+ camasidCama.AsString;
                                WrapMode := TImageWrapMode.Fit;
                                Base64(aislamientoSC);
                                HitTest := false;
                                if camasaislamiento_sc.AsString <> '' then
                                  Visible := true
                                else
                                  Visible := false;
                              end;

                          end;



                        // Boton
                        botonCama := TSpeedButton.Create(Self);
                        botonCama.Parent := panelB;
                        botonCama.Position.X :=1;
                        botonCama.Position.Y := 1;
                        botonCama.Width := 1;
                        botonCama.Height := 1;
                        botonCama.Align := TAlignLayout.Contents;
                        botonCama.Name :=  'botonCama'+ camasidCama.AsString;
                        botonCama.Text := '';
                        botonCama.Cursor := crHandPoint;
                        botonCama.Tag := camasidCama.AsInteger;
                        botonCama.OnClick := clicBotonCama;


                        nPosX := nPosX + Trunc(bordeCama.Width);
                        nCol := nCol +1;

                        // CACHEAR CONTROLES DE ESTA CAMA
                        ui := TCamaUI.Create;
                        ui.Borde := bordeCama;
                        ui.PanelB := panelB;
                        ui.Etiqueta := etiqueta;
                        ui.LyDatos := LyDatos;
                        ui.LyCama := LyCama;
                        ui.LbNroCama := lbNroCama;
                        ui.LbPrincipal := lbPrincipal;
                        ui.LbSecundaria := lbSecundaria;
                        ui.iconoAislamientoC := iconoAislamientoC;
                        ui.iconoAislamientoGC := iconoAislamientoGC;
                        ui.iconoAislamientoAR := iconoAislamientoAR;
                        ui.iconoAislamientoN := iconoAislamientoN;
                        ui.iconoAislamientoCD := iconoAislamientoCD;
                        ui.iconoAislamientoSC := iconoAislamientoSC;
                        ui.lbAlta := lb_Alta;
                        if permisoModulo(3) = 0 then
                          begin
                            ui.iconoAislamiento := iconoAislamiento;
                            ui.lbPrecaucion := lbPrecaucion;
                          end;

                        FCamasUI.AddOrSetValue(camasidCama.AsInteger, ui);

                        camas.Next;
                      until((nCol > nColumnas) or (camas.Eof));
                      nLin := nLin + 1;



                      nPosX := 0;
                      nPosY := nPosY + datos.alto;
                    until(nLin > totalLineas);

                    Espera('stop');
                    // FIN DE LA ACTUALIZACIÓN
                  end);
              end
            else
              begin
                if datos.pendientes = 0 then
                    datos.VerMensaje('No hay camas para vizualisar','Verifique que los filtros aplicados sean los correctos y que el tablero esté configurado para el servicio correcto.','Aceptar','INFO',0);
              end;
          end
        else
          begin
            mens := 'El servicio web '+ datos.urlTC + recursoCamas +' ha retornado status code ' + inttostr(response.StatusCode);
            datos.VerMensaje('ERROR' + response.StatusCode.ToString ,mens,'Aceptar','ERROR',0);
          end;

      except
        on E: Exception do
          begin
            datos.VerMensaje('ERROR','No se pudo completar el proceso de actualizar las camas.','Aceptar','ERROR',0);
          end;
      end;
    end
  ).Start;


  barra.Value := 0;
  RelojConsultarCambios.Enabled := true;
end;


{************************
   CONSULTAR CAMBIOS
************************}
procedure TformTablero.ConsultarCambios;
var
  cambios:integer;
  nueva_alerta:integer;
  response: IResponse;
  recursoCamas:string;
  ui: TCamaUI;
  idCama: Integer;
begin
  barra.Value := 0;
  RelojConsultarCambios.Enabled := false;

  try
    recursoCamas := '/tablerocamas/camas';
    response := TRequest.New.BaseURL(datos.urlTC)
                        .Resource(recursoCamas)
                        .AddHeader('TokenAcceso', datos.tokenAcceso)
                        .AddParam('idServicio', datos.servicio.ToString)
                        .AddParam('tareasPendientes', datos.pendientes.ToString)
                        .Accept('application/json')
                        .Adapters(TDataSetSerializeAdapter.New(camas2))
                        .Get;

    if response.StatusCode = 200 then
      begin
        if camas2.RecordCount = camas.RecordCount then  // si la cantidad de camas no cambió
          begin
            // verifico si cambió algún dato de la cama, para actualizarlo.
            camas2.First;
            camas.First;
            cambios := 0;

            alertas.Close;
            alertas.Open;

            // apago todas las alertas de las camas que están disponibles.
            if TInterlocked.CompareExchange(FApagandoAlertas, 1, 0) <> 0 then
              Exit;

            TTask.Run(
              procedure
              begin
                try
                  apagarAlertasCamasDisponibles;
                finally
                  TInterlocked.Exchange(FApagandoAlertas, 0);
                end;
              end);


            repeat
              idCama := camas2idCama.AsInteger;

              if not FCamasUI.TryGetValue(idCama, ui) then
                Exit;

              if not Assigned(ui) then
                Exit;


              // apago cualquier alerta que haya quedado en rojo
              ui.PanelB.Fill.Color := TAlphaColorRec.White;

              // verifico si hubo ingreso de paciente o alta médica. Si hubo cambios, ingreso una alerta en la tabla alertas
              // y luego ingreso un registro en alertas (tabla local)

              nueva_alerta := 0;

              if camas2idEstado.AsInteger = 2 then
                begin
                  if camasidEstado.AsInteger <> 2 then
                    begin
                      // alerta ingreso de paciente.
                      nuevaAlerta(camas2idCama.AsInteger,1,camas2idInternacion.AsInteger,camas2paciCodigo.AsInteger);
                      nueva_alerta := nueva_alerta + 1;
                    end;

                  // si el médico indicó el alta médica
                  if camas2fechaAltaMedica.AsString <> '' then
                    begin
                      if ((camasfechaAltaMedica.AsString <> camas2fechaAltaMedica.AsString)) then
                        begin
                          // inserto una alerta de alta medica
                          nuevaAlerta(camas2idCama.AsInteger,2,camas2idInternacion.AsInteger,camas2paciCodigo.AsInteger);
                          nueva_alerta := nueva_alerta + 1;
                        end;
                    end;

                  // si el médico indicó el alta probable
                  if camas2altaProbableFecha.AsString <> '' then
                    begin
                      if ((camasaltaProbableFecha.AsString <> camas2altaProbableFecha.AsString)) then
                        begin
                          // inserto una alerta de alta medica
                          nuevaAlerta(camas2idCama.AsInteger,15,camas2idInternacion.AsInteger,camas2paciCodigo.AsInteger);
                          nueva_alerta := nueva_alerta + 1;
                        end;
                    end;
                end;

              // si la cama no está disponible y si hay alertas para esta cama, agrego en la tabla alertas el id de la cama.
              // guardaré en la tabla alertas, el id de las camas que tienen alertas para luego ejecutar la alerta.
              if(camas2idEstado.AsInteger <> 1) and ((camas2alertas.AsInteger > 0) or (nueva_alerta = 1)) then
                begin
                  alertas.Append;
                  alertas.Fields[0].AsInteger := camas2idCama.AsInteger;
                  alertas.Post;
                end;


              // si cambió el idCama
              if camasidCama.AsInteger <> camas2idCama.AsInteger then
                begin
                  cambios := cambios + 1;
                end
              else
                begin
                  // ACTUALIZO LA CAMA CON LA NUEVA INFORMACIÓN AUNQUE NO HAYA CAMBIADO.


                  // pinto la cama de color violeta si hay cambios de cama y es admision (si el servicio tiene gestionaCamas = 1)

                  if (datos.gestionaCamas = 1) and (camas2cambioCamaPendiente.AsInteger = 1) then
                    begin
                      ui.PanelB.Fill.Kind := TbrushKind.Solid;
                      ui.PanelB.Fill.Color := TAlphaColorRec.Darkorchid; // color violeta.
                    end;


                  // pinto la etiqueta del color correspondiente según el estado de la cama
                  ui.etiqueta.Fill.Kind := TbrushKind.Solid;
                  ui.etiqueta.Fill.Color := TAlphaColor(StrToAlphaColor(camas2color.AsString));

                  // coloco el nro de cama en el label lbNroCama
                  ui.lbNroCama.Text := camas2cama.AsString;

                  // completo la linea principal
                  if camas2idEstado.AsInteger = 2 then
                    begin
                      if verPaciente <> 0 then // tiene permisos para ver los datos del paciente
                        ui.LbPrincipal.Text := camas2apellidoPaciente.AsString  + ', ' + camas2nombrePaciente.AsString
                      else
                        ui.LbPrincipal.Text := uppercase(camas2estado.AsString);
                    end
                   else
                    ui.LbPrincipal.Text := uppercase(camas2estado.AsString);

                  // completo la linea secundaria
                  if camas2idEstado.AsInteger = 2 then
                    begin
                      if verPaciente <> 0 then // tiene permisos para ver los datos del paciente
                        ui.LbSecundaria.Text := 'DNI: ' + camas2nroDocumento.AsString
                      else
                        ui.LbSecundaria.Text := '';
                    end
                  else
                    ui.LbSecundaria.Text := '';

                  // verifico Alta y Alta Probable
                  if camas2idEstado.AsInteger = 2 then
                    begin
                      if (verPaciente <> 0) and (camas2fechaAltaMedica.AsString <> '') then
                        begin
                          // hay epicrisis
                          ui.lbAlta.Text := 'ALTA MÉDICA' + #13 + Copy(camasfechaAltaMedica.AsString, 1, 16);
                          ui.lbAlta.FontColor := TAlphaColorRec.Red;
                        end
                      else
                        begin
                          // no hay epicrisis
                          if (verPaciente <> 0) and (camas2altaProbableFecha.AsString <> '') and (camas2fechaAltaMedica.AsString = '') then
                            begin
                              ui.lbAlta.Text := 'ALTA PROBABLE' + #13 + Copy(camas2altaProbableFecha.AsString, 1, 16);
                            ui.lbAlta.FontColor := TAlphaColorRec.Blue;
                            end
                          else
                            begin
                              ui.lbAlta.Text := '';
                            end;
                        end;
                    end
                  else
                    begin
                      ui.lbAlta.Text := '';
                    end;




                  verificarIconosAislamientos(camas2idCama.AsInteger);

                  //verificarAlertasMedicas(camas2idCama.AsInteger);
                end;

              camas2.Next;
              camas.Next;
            until (camas2.Eof);

            if cambios > 0 then
              ActualizarCamas;


            // actualizo la tabla camas para que tenga la misma información que camas2
            camas2.First;
            camas.Close;
            camas.Open;
            repeat
              with camas do
                begin
                  Append;
                  FieldByName('idCama').Value := camas2idCama.AsInteger;
                  FieldByName('cama').Value := camas2cama.AsString;
                  FieldByName('idHabitacion').Value := camas2idHabitacion.AsInteger;
                  FieldByName('habitacion').Value := camas2habitacion.AsString;
                  FieldByName('piso').Value := camas2piso.AsString;
                  FieldByName('idEstado').Value := camas2idEstado.AsInteger;
                  FieldByName('estado').Value := camas2estado.AsString;
                  FieldByName('color').Value := camas2color.AsString;
                  FieldByName('paciCodigo').Value := camas2paciCodigo.AsInteger;
                  FieldByName('nombrePaciente').Value := camas2nombrePaciente.AsString;
                  FieldByName('apellidoPaciente').Value := camas2apellidoPaciente.AsString;
                  FieldByName('tdocCodigo').Value := camas2tdocCodigo.AsInteger;
                  FieldByName('nroDocumento').Value := camas2nroDocumento.AsString;
                  FieldByName('sexo').Value := camas2sexo.AsString;
                  FieldByName('fechaIngresoInstitucion').Value := camas2fechaIngresoInstitucion.AsString;
                  FieldByName('fechaIngresoCama').Value := camas2fechaIngresoCama.AsString;
                  FieldByName('cobertura').Value := camas2cobertura.AsString;
                  FieldByName('fantasia').Value := camas2fantasia.AsString;
                  FieldByName('plan').Value := camas2plan.AsString;
                  FieldByName('nroAfiliado').Value := camas2nroAfiliado.AsString;
                  FieldByName('idInternacion').Value := camas2idInternacion.AsInteger;

                  FieldByName('fechaAltaMedica').Value := camas2fechaAltaMedica.AsString;

                  FieldByName('profesionalAltaMedica').Value := camas2profesionalAltaMedica.AsString;
                  FieldByName('camaEnAislamiento').Value := camas2camaEnAislamiento.AsString;
                  FieldByName('observaciones').Value := camas2observaciones.AsString;
                  FieldByName('procedimientosNoCumplidos').Value := camas2procedimientosNoCumplidos.AsString;
                  FieldByName('medicacionNoProgramada').Value := camas2medicacionNoProgramada.AsString;
                  FieldByName('medicacionNoAplicada').Value := camas2medicacionNoAplicada.asString;

                  FieldByName('kpc').Value := camas2kpc.AsInteger;
                  FieldByName('aislamiento_contacto').Value := camas2aislamiento_contacto.AsString;
                  FieldByName('aislamiento_gota').Value := camas2aislamiento_gota.AsString;
                  FieldByName('aislamiento_respiratorio').Value := camas2aislamiento_respiratorio.AsString;
                  FieldByName('aislamiento_neutropenico').Value := camas2aislamiento_neutropenico.AsString;
                  FieldByName('aislamiento_cd').Value := camas2aislamiento_cd.AsString;
                  FieldByName('aislamiento_sc').Value := camas2aislamiento_sc.AsString;

                  FieldByName('tipoAltaMedica').Value := camas2tipoAltaMedica.AsString;
                  FieldByName('acompanante').Value := camas2acompanante.AsInteger;
                  FieldByName('observacionesAcompanante').Value := camas2observacionesAcompanante.AsString;
                  FieldByName('orden').Value := camas2orden.AsInteger;
                  FieldByName('cambioCamaPendiente').Value := camas2cambioCamaPendiente.AsInteger;
                  FieldByName('alertas').Value := camas2alertas.AsInteger;
                  FieldByName('tareasPendientes').Value := camas2tareasPendientes.AsInteger;
                  FieldByName('altaProbableFecha').Value := camas2altaProbableFecha.AsString;
                  FieldByName('altaProbableTipo').Value := camas2altaProbableTipo.AsString;
                  FieldByName('altaProbableDniUsuario').Value := camas2altaProbableDniUsuario.AsInteger;
                  FieldByName('altaProbableNombreUsuario').Value := camas2altaProbableNombreUsuario.AsString;
                  FieldByName('reservaMotivo').Value := camas2reservaMotivo.AsString;
                  FieldByName('reservaFecha').Value := camas2reservaFecha.AsString;
                  FieldByName('reservadaPorDni').Value := camas2reservadaPorDni.AsInteger;
                  FieldByName('reservadaPorNombre').Value := camas2reservadaPorNombre.AsString;
                  FieldByName('idReserva').Value := camas2idReserva.AsInteger;
                  FieldByName('reservaFechaCancelada').Value := camas2reservaFechaCancelada.AsString;
                  FieldByName('reservaCanceladaPorDni').Value := camas2reservaCanceladaPorDni.AsInteger;
                  FieldByName('reservaCanceladaPorNombre').Value := camas2reservaCanceladaPorNombre.AsString;
                  FieldByName('reservaPacienteDni').Value := camas2reservaPacienteDni.AsString;
                  FieldByName('reservaPacienteNombre').Value := camas2reservaPacienteNombre.AsString;
                  FieldByName('idMotivoFinReserva').Value := camas2idMotivoFinReserva.AsInteger;
                  FieldByName('reservaIdSolicitudCambio').Value := camas2reservaIdSolicitudCambio.AsInteger;
                  FieldByName('fotoPaciente').Value := camas2fotoPaciente.AsString;
                  Post;
                end;
              camas2.Next;
            until (camas2.Eof);

            // ejecuto las alertas.
            // si hay alertas (tabla alertas) ejecuto el timer que las mostrará
            if alertas.RecordCount > 0 then
              relojParpadeo.Enabled := true
            else
              relojParpadeo.Enabled := false;
          end
        else
          begin
            // la cantidad de camas no es la misma. Actualizo todo.
            ActualizarCamas;
          end;
      end
    else
      begin
        // mensaje mostrando el código de error que devolvío la api.
        datos.VerMensaje('ERROR ' + response.statusCode.ToString  ,'El WS '+ datos.urlTC + recursoCamas +' a retornado el siguiente código de estado: ' + response.StatusCode.ToString,'Aceptar','ERROR',0);
      end;
  except
    on E:Exception do
      begin
        if datos.autologin = 0 then
          begin
            if datos.pendientes = 0 then
              datos.VerMensaje('ERROR ','No se pudo verificar si los datos de las camas cambiaron.','Aceptar','ERROR',10);
          end
        else
          begin
            datos.VerMensaje('ERROR','No se pudo verificar si los datos de las camas cambiaron','Aceptar','ERROR',0);
          end;
      end;
  end;


  RelojConsultarCambios.Enabled := true;
end;

procedure TformTablero.controlarVersion;
var
  response : IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC + '/tablerocamas/version')
                    .AddHeader('TokenAcceso', datos.tokenAcceso)
                    .AddParam('idAplicacion', '4') // 4= Tablero de Camas (ver tabla CAB.dbo.aplicaciones)
                    .AddParam('nroVersion', datos.GetAppVersion().ToString)
                    .Accept('application/json')
                    .Adapters(TDataSetSerializeAdapter.New(versiones))
                    .Get;

  if response.StatusCode <> 200 then
    begin
      // la versión no es la correcta
      datos.VerMensaje('Versión del sistema incorrecta',versionesmensaje.AsString,'Aceptar','ERROR',0);
      Application.Terminate;
    end;
end;

procedure TformTablero.Espera(comando: string);
begin
  if comando = 'play' then
    begin
      espere.Visible := true;
      espere.Play;
      espere.BringToFront;
    end;

  if comando = 'stop' then
    begin
      espere.Stop;
      espere.Visible := false;
    end;
end;

procedure TformTablero.FormActivate(Sender: TObject);
begin
  lb_menu_version.Text := 'Versión: ' + datos.GetAppVersion().ToString;
end;

procedure TformTablero.FormCreate(Sender: TObject);
begin
  FCamasUI := TDictionary<Integer, TCamaUI>.Create;

  ControlarVersion;

  //obtenerPermisosModulosPaciente(datos.servicio); // obtengo los permisos que tiene este servicio.

  barra.Max := datos.segundos;
  barra.Value := 0;


  if datos.fullscreen = 1 then
    begin
      BorderStyle := TFmxFormBorderStyle.None;
      WindowState := TwindowState.wsMaximized;
      anchoScrollVertical := 0;
    end
  else
    begin
      anchoScrollVertical := 8;
    end;


  if datos.autologin = 0 then
    begin
      botonSalirFullScreen.Visible := false;
      barraTitulo.Height := 64;
      panelLogin.Visible := true;
      botonMenu.Visible  := true;

      // LOGIN
      Application.CreateForm(TformLogin, formLogin);
      formLogin.ShowModal;
      formLogin.Free;
    end
  else
    begin
      barraTitulo.Height := 40;
      panelLogin.Visible := false;
      botonMenu.Visible  := false;
      botonSalirFullScreen.Visible := true;
    end;

//  if datos.cambiarServicio = 1 then
//    botonCambiarServicio.Enabled := true
//  else
//    botonCambiarServicio.Enabled := false;

  if serviciosUsuario.RecordCount > 1 then
    botonCambiarServicio.Enabled := true
  else
    botonCambiarServicio.Enabled := false;

  lyMenuLateral.Visible := false;
  Espera('stop');
end;


procedure TformTablero.FormDestroy(Sender: TObject);
var
  ui: TCamaUI;
begin
  for ui in FCamasUI.Values do
    ui.Free;

  FCamasUI.Free;
end;

procedure TformTablero.CargarPermisosDesdeJson(const JsonStr: string; Permisos: TFDMemTable);
var
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  I: Integer;
begin
  Permisos.DisableControls;
  try
    Permisos.Close;
    Permisos.Open;
    Permisos.EmptyDataSet;

    JsonValue := TJSONObject.ParseJSONValue(JsonStr);

    if not Assigned(JsonValue) then
      raise Exception.Create('JSON inválido o vacío');

    if not (JsonValue is TJSONArray) then
      raise Exception.Create('El JSON no es un array');

    JsonArray := JsonValue as TJSONArray;

    try
      for I := 0 to JsonArray.Count - 1 do
      begin
        if not (JsonArray.Items[I] is TJSONObject) then
          Continue;

        JsonObj := JsonArray.Items[I] as TJSONObject;

        Permisos.Append;

        Permisos.FieldByName('idPermiso').AsInteger := JsonObj.GetValue<Integer>('idPermiso');

        Permisos.FieldByName('idModulo').AsInteger := JsonObj.GetValue<Integer>('idModulo');

        Permisos.FieldByName('nombreModulo').AsString := JsonObj.GetValue<string>('nombreModulo');

        Permisos.FieldByName('descripcionModulo').AsString := JsonObj.GetValue<string>('descripcionModulo');

        Permisos.FieldByName('controlTotal').AsString := JsonObj.GetValue<string>('controlTotal');

        Permisos.Post;
      end;
    finally
      JsonArray.Free;
    end;

  finally
    Permisos.EnableControls;
  end;
end;

procedure TformTablero.ActualizarServicio;
var
  response: IResponse;
  recurso : string;

  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  PermisosArray: TJSONArray;
begin
  recurso := '/tablerocamas/serviciosVerUno';
  response := TRequest.New
        .BaseURL(datos.urlTC)
        .Resource(recurso)
        .AddHeader('TokenAcceso', datos.tokenAcceso)
        .AddParam('idServicio', datos.servicio.ToString)
        .Accept('application/json')
        .Adapters(TDataSetSerializeAdapter.New(servicio))
        .Get;

  if response.StatusCode = 200 then
    begin
      nombreServicio.Text := servicionombreServicio.AsString;
      nombreServicio.TextSettings.FontColor := TAlphaColorRec.White;
      datos.cambioCamaAreaCerrada := serviciocambioCamaAreaCerrada.AsInteger;
      datos.gestionaCamas := serviciogestionaCamas.AsInteger;


      JsonValue := TJSONObject.ParseJSONValue(response.Content);
      JsonObj := JsonValue as TJSONObject;
      PermisosArray := JsonObj.GetValue<TJSONArray>('permisos');

      CargarPermisosDesdeJson(PermisosArray.ToJSON, permisos);
    end
  else
    begin
      datos.VerMensaje('ERROR ' +response.StatusCode.ToString ,'Ocurrió un error en el recurso ' + datos.urlTC + recurso ,'Aceptar','ERROR',0);
    end;
end;

procedure TformTablero.apagarAlertasCamasDisponibles();
var
  response : IResponse;
begin
  // marca como leidas todas las alertas de esta camas disponibles.
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('tablerocamas/apagarAlertasCamasDisponibles')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(apagaralertasTB))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR','No fue posible apagar las alertas de las camas que están en estado disponible' + #13+#13+'Servicio web: apagarAlertasCamasDisponibles','Aceptar','ERROR',0);
    end;
end;

procedure TformTablero.blinking(idCama: string);
var
  e:boolean;
  ui:TCamaUI;
begin
  if not FCamasUI.TryGetValue(idCama.ToInteger(), ui) then
    Exit;

  e := camas2.Locate('idCama',idCama,[]);
  if camas2cambioCamaPendiente.AsInteger = 1 then
    begin
      if ui.panelB.Fill.Color =  TAlphaColorRec.Red then
        ui.panelB.Fill.Color := TAlphaColor(StrToAlphaColor('#FFA4D1'))
      else
        ui.panelB.Fill.Color := TAlphaColorRec.Red;
    end
  else
    begin
      if ui.panelB.Fill.Color =  TAlphaColorRec.White then
        ui.panelB.Fill.Color := TAlphaColorRec.Red
      else
        ui.panelB.Fill.Color := TAlphaColorRec.White;
    end;
end;

procedure TformTablero.botonActualizarClick(Sender: TObject);
begin
  lyMenuLateral.Visible := false;
  ActualizarCamas;
end;

procedure TformTablero.botonAutorizarClick(Sender: TObject);
begin
  RelojConsultarCambios.Enabled := false;
  lyMenuLateral.Visible := false;
  Application.CreateForm(Tform_AutorizacionesPendientes, form_AutorizacionesPendientes);
  form_AutorizacionesPendientes.Height := formTablero.Height;
  form_AutorizacionesPendientes.Width := formTablero.Width;
  form_AutorizacionesPendientes.pagina.tabIndex := 0;
  form_AutorizacionesPendientes.ShowModal;
end;

procedure TformTablero.botonCambiarServicioClick(Sender: TObject);
begin
  RelojConsultarCambios.Enabled := false;
  lyMenuLateral.Visible := false;
  Application.CreateForm(Tform_ServiciosCambio, form_ServiciosCambio);
  form_ServiciosCambio.Height := formTablero.Height;
  form_ServiciosCambio.Width := formTablero.Width;
  form_ServiciosCambio.ShowModal;
end;

procedure TformTablero.botonCerrarSesionApplyStyleLookup(Sender: TObject);
var
  Button: TCustomButton;
  Control: TControl;
  TextObj: TFmxObject;
begin
  Button := (Sender as TCustomButton);
  for Control in Button.Controls do
  begin
    TextObj := Button.FindStyleResource('text');
    (TextObj as TText).Margins.Left := 40;
  end;
end;

procedure TformTablero.botonCerrarSesionClick(Sender: TObject);
begin
  Application.CreateForm(TformLogin, formLogin);
  formLogin.ShowModal;
end;

end.
