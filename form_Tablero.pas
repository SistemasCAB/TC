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
  FMX.GIFImage;

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
    alertasid_cama: TIntegerField;
    contenedor: TScrollBox;
    barra: TProgressBar;
    espere: TGIFImage;
    botonConsultarCambios: TButton;
    botonConfiguracion: TSpeedButton;
    Rectangle3: TRectangle;
    camas: TFDMemTable;
    versiones: TFDMemTable;
    versionesversionActual: TFloatField;
    versionesautorizada: TWideStringField;
    versionesversionAutorizada: TFloatField;
    versionesfecha: TWideStringField;
    versionesmensaje: TWideStringField;
    permisos: TFDMemTable;
    permisosid_permiso: TFloatField;
    permisosid_servicio: TFloatField;
    permisosnombreServicio: TWideStringField;
    permisosid_modulo: TFloatField;
    permisosnombreModulo: TWideStringField;
    permisosdescripcion: TWideStringField;
    permisoscontrolTotal: TFloatField;
    apagarAlertasTB: TFDMemTable;
    camasid_cama: TIntegerField;
    camascama: TStringField;
    camasid_habitacion: TIntegerField;
    camashabitacion: TStringField;
    camaspiso: TStringField;
    camasid_estado: TIntegerField;
    camasestado: TStringField;
    camascolor: TStringField;
    camasobservaciones: TStringField;
    camasid_paciente: TIntegerField;
    camasnombre_paciente: TStringField;
    camasapellido_paciente: TStringField;
    camasdni: TStringField;
    camassexo: TStringField;
    camassexo_texto: TStringField;
    camasfecha_ingreso_institucion: TStringField;
    camasfecha_ingreso_cama: TStringField;
    camascobertura: TStringField;
    camasfantasia: TStringField;
    camasplan: TStringField;
    camasnro_afiliado: TStringField;
    camasid_internacion: TIntegerField;
    camasfecha_alta_medica: TStringField;
    camasprofesional_alta_medica: TStringField;
    camastipo_alta_medica: TStringField;
    camasfoto_paciente: TMemoField;
    camasprocedimientos_no_cumplidos: TIntegerField;
    camasmedicacion_no_programada: TIntegerField;
    camasmedicacion_no_aplicada: TIntegerField;
    camasaislamiento_contacto: TStringField;
    camasaislamiento_respiratorio: TStringField;
    camasaislamiento_gota: TStringField;
    camasaislamiento_neutropenico: TStringField;
    camasaislamiento_cd: TStringField;
    camasaislamiento_sc: TStringField;
    camascama_en_aislamiento: TIntegerField;
    camasacompanante: TIntegerField;
    camasobservaciones_acompanante: TStringField;
    camasorden: TIntegerField;
    camascambioCamaPendiente: TIntegerField;
    camasalertas: TIntegerField;
    camastareasPendientes: TIntegerField;
    camasaltaProbable_fecha: TStringField;
    camasaltaProbable_tipo: TStringField;
    camasaltaProbable_dniUsuario: TStringField;
    camasreserva_motivo: TStringField;
    camasfecha_reserva: TStringField;
    camasreservada_por_dni: TStringField;
    camasreservada_por_nombre: TStringField;
    camasid_reserva: TIntegerField;
    camasreserva_fecha_cancelada: TStringField;
    camasreserva_cancelada_por_dni: TStringField;
    camasreserva_cancelada_por_nombre: TStringField;
    camasreserva_paciente_dni: TStringField;
    camasreserva_paciente_nombre: TStringField;
    camasid_motivo_fin_reserva: TIntegerField;
    camasreserva_id_solicitudCambio: TIntegerField;
    camas2: TFDMemTable;
    camas2id_cama: TIntegerField;
    camas2cama: TStringField;
    camas2id_habitacion: TIntegerField;
    camas2habitacion: TStringField;
    camas2piso: TStringField;
    camas2id_estado: TIntegerField;
    camas2estado: TStringField;
    camas2color: TStringField;
    camas2observaciones: TStringField;
    camas2id_paciente: TIntegerField;
    camas2nombre_paciente: TStringField;
    camas2apellido_paciente: TStringField;
    camas2dni: TStringField;
    camas2sexo: TStringField;
    camas2sexo_texto: TStringField;
    camas2fecha_ingreso_institucion: TStringField;
    camas2fecha_ingreso_cama: TStringField;
    camas2cobertura: TStringField;
    camas2fantasia: TStringField;
    camas2plan: TStringField;
    camas2nro_afiliado: TStringField;
    camas2id_internacion: TIntegerField;
    camas2fecha_alta_medica: TStringField;
    camas2profesional_alta_medica: TStringField;
    camas2tipo_alta_medica: TStringField;
    camas2foto_paciente: TMemoField;
    camas2procedimientos_no_cumplidos: TIntegerField;
    camas2medicacion_no_programada: TIntegerField;
    camas2medicacion_no_aplicada: TIntegerField;
    camas2aislamiento_contacto: TStringField;
    camas2aislamiento_respiratorio: TStringField;
    camas2aislamiento_gota: TStringField;
    camas2aislamiento_neutropenico: TStringField;
    camas2aislamiento_cd: TStringField;
    camas2aislamiento_sc: TStringField;
    camas2cama_en_aislamiento: TIntegerField;
    camas2acompanante: TIntegerField;
    camas2observaciones_acompanante: TStringField;
    camas2orden: TIntegerField;
    camas2cambioCamaPendiente: TIntegerField;
    camas2alertas: TIntegerField;
    camas2tareasPendientes: TIntegerField;
    camas2altaProbable_fecha: TStringField;
    camas2altaProbable_tipo: TStringField;
    camas2altaProbable_dniUsuario: TStringField;
    camas2reserva_motivo: TStringField;
    camas2fecha_reserva: TStringField;
    camas2reservada_por_dni: TStringField;
    camas2reservada_por_nombre: TStringField;
    camas2id_reserva: TIntegerField;
    camas2reserva_fecha_cancelada: TStringField;
    camas2reserva_cancelada_por_dni: TStringField;
    camas2reserva_cancelada_por_nombre: TStringField;
    camas2reserva_paciente_dni: TStringField;
    camas2reserva_paciente_nombre: TStringField;
    camas2id_motivo_fin_reserva: TIntegerField;
    camas2reserva_id_solicitudCambio: TIntegerField;
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
    procedure nuevaAlerta(cama, tipo, id_internacion, id_paciente:integer);
    procedure verificarIconoAlta(id_cama:integer);
    procedure verificarIconosAislamientos(id_cama:integer);
    procedure verificarAlertasMedicas(id_cama:integer);
    procedure relojParpadeoTimer(Sender: TObject);
    procedure blinking(id_cama:string);
    procedure botonConfiguracionClick(Sender: TObject);
    procedure ActualizarServicio;
    procedure FormActivate(Sender: TObject);
    procedure botonCambiarServicioClick(Sender: TObject);
    procedure controlarVersion;
    function verificarPermisos(id_servicio,id_modulo: integer): integer;
    procedure apagarAlertas(id_cama:integer);
  private
    { Private declarations }
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
  FMX.Image.Base64, RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D;

procedure TformTablero.botonSalirClick(Sender: TObject);
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
        blinking(alertasid_cama.AsString);
        alertas.Next;
      until (alertas.Eof);
    end;
end;

procedure TformTablero.verificarAlertasMedicas(id_cama: integer);
begin
  // verifica si hay alertas médica, en caso positivo muestra la cruz verde sobre la cama.

  // oculto la cruz verde
  with FindComponent('contenedorCamas') as TScrollBox do
    begin
      with FindComponent('bordeCama' + id_cama.ToString) as TRectangle  do
        begin
          with FindComponent('panelB' + id_cama.ToString) as TRectangle  do
            begin
              (FindComponent('cruzVerde' + id_cama.ToString) as TGIFImage).Visible := false;
              (FindComponent('cruzVerde' + id_cama.ToString) as TGIFImage).Stop;
            end;
        end;
    end;

  // verifico si hay que mostrar la cruz verde
  if camas2id_estado.AsInteger = 2 then
    begin
      if (camas2procedimientos_no_cumplidos.AsInteger > 0) or (camas2medicacion_no_programada.AsInteger > 0) or (camas2medicacion_no_aplicada.AsInteger > 0) then
        begin
          with FindComponent('contenedorCamas') as TScrollBox do
            begin
              with FindComponent('bordeCama' + id_cama.ToString) as TRectangle  do
                begin
                  with FindComponent('panelB' + id_cama.ToString) as TRectangle  do
                    begin
                      (FindComponent('cruzVerde' + id_cama.ToString) as TGIFImage).Visible := true;
                      (FindComponent('cruzVerde' + id_cama.ToString) as TGIFImage).Play;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TformTablero.verificarIconoAlta(id_cama: integer);
begin
  // busco el icono del alta y lo oculto o muestro según corresponda
  with FindComponent('contenedorCamas') as TScrollBox do
    begin
      with FindComponent('bordeCama' + id_cama.ToString) as TRectangle  do
        begin
          with FindComponent('panelB' + id_cama.ToString) as TRectangle  do
            begin
              with FindComponent('LyDatos' + id_cama.ToString) as TLayout  do
                begin
                  with FindComponent('LyCama' + id_cama.ToString) as TLayout  do
                    begin
                      if camas2id_estado.AsInteger = 2 then
                        begin
                          if camas2fecha_alta_medica.AsString = '' then
                            (FindComponent('IconoAlta' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('IconoAlta' + id_cama.ToString) as TImage).Visible := true;
                        end
                      else
                        begin
                          (FindComponent('IconoAlta' + id_cama.ToString) as TImage).Visible := false;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TformTablero.verificarIconosAislamientos(id_cama: integer);
begin
  with FindComponent('contenedorCamas') as TScrollBox do
    begin
      with FindComponent('bordeCama' + id_cama.ToString) as TRectangle  do
        begin
          with FindComponent('panelB' + id_cama.ToString) as TRectangle  do
            begin
              with FindComponent('LyDatos' + id_cama.ToString) as TLayout  do
                begin
                  with FindComponent('LyIconos' + id_cama.ToString) as TLayout  do
                    begin
                      if camas2id_estado.AsInteger = 2 then
                        begin
                          // AISLAMIENTO DE CONTACTO
                          if camas2aislamiento_contacto.AsString = '' then
                            (FindComponent('aislamientoAC' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('aislamientoAC' + id_cama.ToString) as TImage).Visible := true;


                          // AISLAMIENTO DE AIRE RESPIRATORIO
                          if camas2aislamiento_respiratorio.AsString = '' then
                            (FindComponent('aislamientoAR' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('aislamientoAR' + id_cama.ToString) as TImage).Visible := true;

                          // AISLAMIENTO DE GOTA
                          if camas2aislamiento_gota.AsString = '' then
                            (FindComponent('aislamientoAG' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('aislamientoAG' + id_cama.ToString) as TImage).Visible := true;

                          // AISLAMIENTO DE PROTECCIÓN NEUTROPÉNICO
                          if camas2aislamiento_neutropenico.AsString = '' then
                            (FindComponent('aislamientoAN' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('aislamientoAN' + id_cama.ToString) as TImage).Visible := true;

                          // AISLAMIENTO DE CD
                          if camas2aislamiento_cd.AsString = '' then
                            (FindComponent('aislamientoCD' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('aislamientoCD' + id_cama.ToString) as TImage).Visible := true;

                          // AISLAMIENTO SC
                          if camas2aislamiento_sc.AsString = '' then
                            (FindComponent('aislamientoSC' + id_cama.ToString) as TImage).Visible := false
                          else
                            (FindComponent('aislamientoSC' + id_cama.ToString) as TImage).Visible := true;
                        end
                      else
                        begin
                          // AISLAMIENTO DE CONTACTO
                          (FindComponent('aislamientoAC' + id_cama.ToString) as TImage).Visible := false;

                          // AISLAMIENTO RESPIRATORIO
                          (FindComponent('aislamientoAR' + id_cama.ToString) as TImage).Visible := false;

                          // AISLAMIENTO DE GOTA
                          (FindComponent('aislamientoAG' + id_cama.ToString) as TImage).Visible := false;

                          // AISLAMIENTO NEUTROPÉNICO
                          (FindComponent('aislamientoAN' + id_cama.ToString) as TImage).Visible := false;

                          // AISLAMIENTO CD
                          (FindComponent('aislamientoCD' + id_cama.ToString) as TImage).Visible := false;

                          // AISLAMIENTO SC
                          (FindComponent('aislamientoSC' + id_cama.ToString) as TImage).Visible := false;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function TformTablero.verificarPermisos(id_servicio,id_modulo: integer): integer;
// verifica si el servicio tiene permisos sobre el módulo.
// devuelve 0=no tiene permiso, 1=tiene permisos de lectura, 2= tiene permiso de control total
var
  response : IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC + '/tablerocamas/permisoModuloPaciente_ver')
                    .AddHeader('TokenAcceso', datos.tokenAcceso)
                    .AddParam('id_modulo', id_modulo.ToString)
                    .AddParam('id_servicio', id_servicio.ToString)
                    .Accept('application/json')
                    .Adapters(TDataSetSerializeAdapter.New(permisos))
                    .Get;

  if permisos.RecordCount = 1 then
    begin
      if permisoscontrolTotal.AsInteger = 1 then
        verificarPermisos := 2 // control total
      else
        verificarPermisos := 1; // solo lectura
    end
  else
    begin
      verificarPermisos := 0; // acceso denegado
    end;
end;

procedure TformTablero.FormShow(Sender: TObject);
begin
  ActualizarCamas;
end;

procedure TformTablero.nuevaAlerta(cama, tipo, id_internacion, id_paciente: integer);
var
  response: IResponse;
begin
  // inserta una alerta de acuerdo a los parámetros recibidos.

  response := TRequest.New.BaseURL(datos.urlTC)
                      .Resource('alertas/nueva')
                      .AddHeader('TokenAcceso', datos.tokenAcceso)
                      .AddParam('id_cama', cama.ToString)
                      .AddParam('id_tipo_alerta', tipo.ToString)
                      .AddParam('id_paciente', id_paciente.ToString)
                      .AddParam('id_internacion', id_internacion.ToString)
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
  id_cama:integer;
begin
  if datos.autologin = 0 then
    begin
      // detengo el reloj de actualización de las camas mientras está abierta la ventana de detalles de la cama.
      RelojConsultarCambios.Enabled := false;

      id_cama := (sender as TSpeedButton).Tag;

      Application.CreateForm(Tform_DetallesCama, form_DetallesCama);
      form_DetallesCama.id_cama := id_cama;
      form_DetallesCama.Height  := formTablero.Height;
      form_DetallesCama.Width   := formTablero.Width;
      form_DetallesCama.Actualizar(id_cama);
      form_DetallesCama.Showmodal;

      ConsultarCambios;
    end
  else
    begin
      datos.VerMensaje('ERROR','En modo Autologin, esta funcionalidad no está permitida','Aceptar','ERROR',0);
    end;
end;

{************************
    ACTUALIZAR CAMAS
************************}
procedure TformTablero.ActualizarCamas;
var
  anchoContenedor:Integer;
  nLin, nCol, nPosX, nPosY, nRegistros, nColumnas,totalLineas:integer;
  mens:string; // variable que contendrá el mensaje a mostrar al usuario.
  lp:string;

  Input, Output : TStringStream;
  pic:string;
  response: IResponse;
  recursoCamas : string;
begin
  RelojConsultarCambios.Enabled := false;

  // INICIO LA ACTUALIZACIÓN
  Espera('play');

  if Assigned(contenedor) then
      contenedor.Destroy;

  contenedor := TScrollBox.Create(formTablero);
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
                        bordeCama := TRectangle.Create(contenedor);
                        bordeCama.Parent := contenedor;
                        bordeCama.Position.X := nPosX + 1;
                        bordeCama.Position.Y := nPosY + 1;
                        bordeCama.Width := (anchoContenedor div nColumnas)-1;
                        bordeCama.Height := datos.alto;
                        bordeCama.Name := 'bordeCama'+ camasid_cama.AsString;

                        bordeCama.Padding.Top := datos.pad;
                        bordeCama.Padding.Bottom := datos.pad;
                        bordeCama.Padding.Left := datos.pad;
                        bordeCama.Padding.Right := datos.pad;

                        bordeCama.Fill.Kind := TbrushKind.None;
                        bordeCama.Stroke.Kind := TbrushKind.None;

                        // creo el panelInterior
                        panelB := TRectangle.Create(bordeCama);
                        panelB.Parent := bordeCama;
                        panelB.Position.X := 0;
                        panelB.Position.Y := 0;
                        panelB.Name := 'panelB'+ camasid_cama.AsString;
                        panelB.Width := 1;
                        panelB.Height := 1;
                        panelB.Align := TAlignLayout.Client;
                        panelB.Fill.Kind := TbrushKind.Solid;
                        panelB.Fill.Color := TAlphaColorRec.White;
                        panelB.Stroke.Kind := TbrushKind.None;

                        // etiqueta de color
                        with TRectangle.Create(panelB) do
                          begin
                            Parent := panelB;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 15;
                            Align := TAlignLayout.Left;
                            Name := 'etiqueta'+ camasid_cama.AsString;
                            Fill.Kind := TbrushKind.Solid;
                            Fill.Color := TAlphaColor(StrToAlphaColor(camascolor.AsString));
                            Stroke.Kind := TbrushKind.None;
                            HitTest := false;
                          end;


                        // Layout Foto
                        LyFoto := TLayout.Create(panelB);
                        LyFoto.Parent := panelB;
                        LyFoto.Position.X :=1;
                        LyFoto.Position.Y := 1;
                        LyFoto.Width := 80;
                        LyFoto.Height := 1;
                        LyFoto.Align := TAlignLayout.Right;
                        LyFoto.Name := 'lyFoto'+ camasid_cama.AsString;
                        LyFoto.Margins.Top := 5;
                        LyFoto.Margins.Left := 5;
                        LyFoto.Margins.Right := 5;
                        LyFoto.Margins.Bottom := 5;
                        LyFoto.HitTest := false;

                        pic := camasfoto_paciente.AsString;

                        if camasid_estado.AsInteger = 2 then
                          begin
                            // Foto
                            with TImage.Create(LyFoto) do
                              begin
                                Parent := LyFoto;
                                Position.X :=1;
                                Position.Y := 1;
                                Width := 1;
                                Height := 101;
                                Align := TAlignLayout.Top;
                                Name := 'FotoPaciente'+ camasid_cama.AsString;
                                WrapMode := TImageWrapMode.Fit;

                                if camasfoto_paciente.AsString = '' then
                                  Base64(sin_foto)
                                else
                                if verPaciente <> 0 then // tiene permiso para ver datos del paciente?
                                  begin
                                    if camasfoto_paciente.AsString = '' then
                                      Base64(sin_foto)
                                    else
                                      Base64(camasfoto_paciente.AsString);
                                  end
                                else
                                  begin
                                    Base64(sin_foto);
                                  end;
                                HitTest := false;
                              end;
                          end;

                        // Layout Datos
                        LyDatos := TLayout.Create(panelB);
                        LyDatos.Parent := panelB;
                        LyDatos.Position.X :=1;
                        LyDatos.Position.Y := 1;
                        LyDatos.Width := 1;
                        LyDatos.Height := 1;
                        LyDatos.Align := TAlignLayout.Client;
                        LyDatos.Name :=  'lyDatos'+ camasid_cama.AsString;
                        LyDatos.Margins.Left := 5;

                        // Layout Cama
                        LyCama := TLayout.Create(LyDatos);
                        LyCama.Parent := LyDatos;
                        LyCama.Position.X :=1;
                        LyCama.Position.Y := 1;
                        LyCama.Height := 40;
                        LyCama.Align := TAlignLayout.Top;
                        LyCama.Name :=  'lyCama'+ camasid_cama.AsString;


                        // Ícono Alta
                        with TImage.Create(LyCama) do
                          begin
                            Parent := LyCama;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Right;
                            Name := 'IconoAlta'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(icono_alta);
                            HitTest := false;
                            if camasfecha_alta_medica.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;


                        // Número de Cama
                        with TLabel.Create(LyCama) do
                          begin
                            Parent := LyCama;
                            Position.X :=1;
                            Position.Y := 1;
                            Height := 40;
                            Align := TAlignLayout.Client;
                            Name := 'lbNroCama'+ camasid_cama.AsString;
                            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
                            TextSettings.Font.Size := 36;
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.HorzAlign := TTextAlign.Leading;
                            Text := camascama.AsString;
                            HitTest := false;
                          end;


                        // Línea secundaria
                        with TLabel.Create(LyDatos) do
                          begin
                            Parent := LyDatos;
                            Position.X :=1;
                            Position.Y := 1;
                            Height := 17;
                            Align := TAlignLayout.Top;
                            HitTest := false;
                            Name := 'lb_linea_secundaria'+ camasid_cama.AsString;
                            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor, TStyledSetting.Size];
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.HorzAlign := TTextAlign.Leading;
                            HitTest := false;
                            if camasid_estado.AsInteger = 2 then
                              begin
                                if verPaciente <> 0 then
                                  Text := 'DNI: ' + camasdni.AsString
                                else
                                  Text := '';
                              end
                            else
                              Text := '';
                          end;

                        // Línea principal
                        with TLabel.Create(LyDatos) do
                          begin
                            Parent := LyDatos;
                            Position.X :=1;
                            Position.Y := 1;
                            Height := 22;
                            Align := TAlignLayout.Top;
                            HitTest := false;
                            Name := 'lb_linea_principal'+ camasid_cama.AsString;
                            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
                            TextSettings.Font.Size := 13;
                            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                            TextSettings.HorzAlign := TTextAlign.Leading;
                            HitTest := false;
                            if camasid_estado.AsInteger = 2 then
                              if verPaciente <> 0 then
                                Text := camasapellido_paciente.AsString + ', ' + camasnombre_paciente.AsString
                              else
                                begin
                                  if camassexo.AsString = 'F' then
                                    Text := 'MUJER'
                                  else
                                    Text := 'HOMBRE';
                                end
                            else
                              Text := camasestado.AsString;
                          end;

                        // Layout Iconos
                        LyIconos := TLayout.Create(LyDatos);
                        LyIconos.Parent := LyDatos;
                        LyIconos.Position.X :=1;
                        LyIconos.Position.Y := 1;
                        LyIconos.Width := 1;
                        LyIconos.Height := 1;
                        LyIconos.Align := TAlignLayout.Client;
                        LyIconos.Name :=  'lyIconos'+ camasid_cama.AsString;
                        LyIconos.Margins.Left := 5;
                        LyIconos.HitTest := false;


                        // Ícono Aislamiento de Contacto
                        with TImage.Create(LyIconos) do
                          begin
                            Parent := LyIconos;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Left;
                            Name := 'aislamientoAC'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(aislamientoAC);
                            HitTest := false;
                            if camasaislamiento_contacto.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;


                        // Ícono Aislamiento Gota Contacto
                        with TImage.Create(LyIconos) do
                          begin
                            Parent := LyIconos;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Left;
                            Name := 'aislamientoAG'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(aislamientoAG);
                            HitTest := false;
                            if camasaislamiento_gota.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;


                        // Ícono Aislamiento Aire Respiratorio
                        with TImage.Create(LyIconos) do
                          begin
                            Parent := LyIconos;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Left;
                            Name := 'aislamientoAR'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(aislamientoAR);
                            HitTest := false;
                            if camasaislamiento_respiratorio.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;


                        // Ícono Aislamiento de Protección Neutropenico
                        with TImage.Create(LyIconos) do
                          begin
                            Parent := LyIconos;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Left;
                            Name := 'aislamientoAN'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(aislamientoAN);
                            HitTest := false;
                            if camasaislamiento_neutropenico.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;


                        // Ícono Aislamiento CD
                        with TImage.Create(LyIconos) do
                          begin
                            Parent := LyIconos;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Left;
                            Name := 'aislamientoCD'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(aislamientoCD);
                            HitTest := false;
                            if camasaislamiento_cd.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;

                        // Ícono Aislamiento SC
                        with TImage.Create(LyIconos) do
                          begin
                            Parent := LyIconos;
                            Position.X :=1;
                            Position.Y := 1;
                            Width := 40;
                            Height := 50;
                            Align := TAlignLayout.Left;
                            Name := 'aislamientoSC'+ camasid_cama.AsString;
                            WrapMode := TImageWrapMode.Fit;
                            Base64(aislamientoSC);
                            HitTest := false;
                            if camasaislamiento_sc.AsString <> '' then
                              Visible := true
                            else
                              Visible := false;
                          end;


                        // Cruz Verde
                        with TGIFImage.Create(panelB) do
                          begin
                            Parent := panelB;
                            Position.X :=1;
                            Position.Y := 1;
                            Align := TAlignLayout.Contents;
                            Name := 'cruzVerde'+ camasid_cama.AsString;
                            LoadFromBase64(cruz_verde);
                            Play;
                            LoadFromFile('c:\tc\img\cruz-verde.gif');
                            HitTest := false;
                            Visible := false;
                          end;


                        // Boton
                        botonCama := TSpeedButton.Create(panelB);
                        botonCama.Parent := panelB;
                        botonCama.Position.X :=1;
                        botonCama.Position.Y := 1;
                        botonCama.Width := 1;
                        botonCama.Height := 1;
                        botonCama.Align := TAlignLayout.Contents;
                        botonCama.Name :=  'botonCama'+ camasid_cama.AsString;
                        botonCama.Text := '';
                        botonCama.Cursor := crHandPoint;
                        botonCama.Tag := camasid_cama.AsInteger;
                        botonCama.OnClick := clicBotonCama;


                        nPosX := nPosX + Trunc(bordeCama.Width);
                        nCol := nCol +1;

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
begin
  barra.Value := 0;
  RelojConsultarCambios.Enabled := false;

  try
    // me contecto a la API del TC (10.99.8.107) para obtener las camas
    recursoCamas := '/camas/obtenerCamas_v2';
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

            repeat
              // apago cualquier alerta que haya quedado en rojo
              with contenedor do
                begin
                  with (FindComponent('bordeCama'+ camas2id_cama.AsString) as TRectangle) do
                    begin
                      (FindComponent('panelB'+ camas2id_cama.AsString) as TRectangle).Fill.Color := TAlphaColorRec.White;
                    end;
                end;


              // verifico si hubo ingreso de paciente o alta médica. Si hubo cambios, ingreso una alerta en la tabla alertas
              // y luego ingreso un registro en alertas (tabla local)

              nueva_alerta := 0;

              if camas2id_estado.AsInteger = 2 then
                begin
                  if camasid_estado.AsInteger <> 2 then
                    begin
                      // alerta ingreso de paciente.
                      nuevaAlerta(camas2id_cama.AsInteger,1,camas2id_internacion.AsInteger,camas2id_paciente.AsInteger);
                      nueva_alerta := nueva_alerta + 1;
                    end;

                  // si el médico indicó el alta médica
                  if camas2fecha_alta_medica.AsString <> '' then
                    begin
                      if ((camasfecha_alta_medica.AsString <> camas2fecha_alta_medica.AsString)) then
                        begin
                          // inserto una alerta de alta medica
                          nuevaAlerta(camas2id_cama.AsInteger,2,camas2id_internacion.AsInteger,camas2id_paciente.AsInteger);
                          nueva_alerta := nueva_alerta + 1;
                        end;
                    end;
                end;


              // si la cama está disponible, apago todas las alertas de la cama
              if camas2id_estado.AsInteger = 1 then
                begin
                  // apagar alertas
                  apagarAlertas(camas2id_cama.AsInteger);
                end
              else
                begin
                  // si hay alertas para esta cama, agrego en la tabla alertas el id de la cama.
                  // guardaré en la tabla alertas, el id de las camas que tienen alertas para luego ejecutar la alerta.

                  if ((camas2alertas.AsInteger > 0) or (nueva_alerta = 1)) then
                    begin
                      alertas.Append;
                      alertas.Fields[0].AsInteger := camas2id_cama.AsInteger;
                      alertas.Post;
                    end;
                end;




              // si cambió el id_cama
              if camasid_cama.AsInteger <> camas2id_cama.AsInteger then
                begin
                  cambios := cambios + 1;
                end
              else
                begin
                  // actualizo la cama con la nueva información, aunque no haya cambiado.
                  with contenedor do
                    begin
                      with (FindComponent('bordeCama'+ camas2id_cama.AsString) as TRectangle) do
                        begin
                          with (FindComponent('panelB'+ camas2id_cama.AsString) as TRectangle) do
                            begin
                              // servicio gestiona camas
                              if datos.gestionaCamas = 1 then // si el servicio tiene la función de Admisión y Egreso
                                begin
                                  // pinto la cama de color violeta si hay cambios de cama pendientes de autorización
                                  if camas2cambioCamaPendiente.AsInteger = 1 then
                                    begin
                                      Fill.Kind := TbrushKind.Solid;
                                      //Fill.Color := TAlphaColor(StrToAlphaColor('$00FFA4D1'));
                                      Fill.Color := TAlphaColorRec.Darkorchid; // color violeta.
                                    end
                                  else
                                    begin
                                      Fill.Kind := TbrushKind.Solid;
                                      Fill.Color := TAlphaColorRec.White;
                                    end;
                                end;


                              // etiqueta de color (estado)
                                 with (FindComponent('etiqueta'+ camas2id_cama.AsString) as TRectangle) do
                                  begin
                                    Fill.Kind := TbrushKind.Solid;
                                    Fill.Color := TAlphaColor(StrToAlphaColor(camas2color.AsString));
                                  end;

                                with (FindComponent('LyDatos'+ camas2id_cama.AsString) as TLayout) do
                                  begin
                                    // nro de cama
                                    with (FindComponent('LyCama'+ camas2id_cama.AsString) as TLayout) do
                                      begin
                                        (FindComponent('lbNroCama'+ camas2id_cama.AsString) as TLabel).Text := camas2cama.AsString;
                                      end;

                                    // linea principal
                                   if camas2id_estado.AsInteger = 2 then
                                    begin
                                      if verPaciente <> 0 then // tiene permisos para ver los datos del paciente
                                        (FindComponent('lb_linea_principal'+ camas2id_cama.AsString) as TLabel).Text := camas2apellido_paciente.AsString  + ', ' + camas2nombre_paciente.AsString
                                      else
                                        (FindComponent('lb_linea_principal'+ camas2id_cama.AsString) as TLabel).Text := camas2sexo_texto.AsString;
                                    end
                                   else
                                    (FindComponent('lb_linea_principal'+ camas2id_cama.AsString) as TLabel).Text := camas2estado.AsString;

                                   // linea secundaria
                                   if camas2id_estado.AsInteger = 2 then
                                    begin
                                      if verPaciente <> 0 then // tiene permisos para ver los datos del paciente
                                        (FindComponent('lb_linea_secundaria'+ camas2id_cama.AsString) as TLabel).Text := 'DNI: ' + camas2dni.AsString
                                      else
                                        (FindComponent('lb_linea_secundaria'+ camas2id_cama.AsString) as TLabel).Text := '';
                                    end
                                   else
                                    (FindComponent('lb_linea_secundaria'+ camas2id_cama.AsString) as TLabel).Text := '';

                                  end;

                            end;
                        end;
                    end;

                    verificarIconoAlta(camas2id_cama.AsInteger);
                    verificarIconosAislamientos(camas2id_cama.AsInteger);

                    verificarAlertasMedicas(camas2id_cama.AsInteger);
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
                  FieldByName('id_cama').Value := camas2id_cama.AsInteger;
                  FieldByName('cama').Value := camas2cama.AsString;
                  FieldByName('id_habitacion').Value := camas2id_habitacion.AsInteger;
                  FieldByName('habitacion').Value := camas2habitacion.AsString;
                  FieldByName('piso').Value := camas2piso.AsString;
                  FieldByName('id_estado').Value := camas2id_estado.AsInteger;
                  FieldByName('estado').Value := camas2estado.AsString;
                  FieldByName('color').Value := camas2color.AsString;
                  FieldByName('id_paciente').Value := camas2id_paciente.AsInteger;
                  FieldByName('nombre_paciente').Value := camas2nombre_paciente.AsString;
                  FieldByName('apellido_paciente').Value := camas2apellido_paciente.AsString;
                  FieldByName('dni').Value := camas2dni.AsString;
                  FieldByName('sexo').Value := camas2sexo.AsString;
                  FieldByName('fecha_ingreso_institucion').Value := camas2fecha_ingreso_cama.AsString;
                  FieldByName('fecha_ingreso_cama').Value := camas2fecha_ingreso_cama.AsString;
                  FieldByName('cobertura').Value := camas2cobertura.AsString;
                  FieldByName('fantasia').Value := camas2fantasia.AsString;
                  FieldByName('plan').Value := camas2plan.AsString;
                  FieldByName('nro_afiliado').Value := camas2nro_afiliado.AsString;
                  FieldByName('id_internacion').Value := camas2id_internacion.AsInteger;
                  FieldByName('fecha_alta_medica').Value := camas2fecha_alta_medica.AsString;
                  FieldByName('profesional_alta_medica').Value := camas2profesional_alta_medica.AsString;
                  FieldByName('cama_en_aislamiento').Value := camas2cama_en_aislamiento.AsString;
                  FieldByName('observaciones').Value := camas2observaciones.AsString;
                  FieldByName('procedimientos_no_cumplidos').Value := camas2procedimientos_no_cumplidos.AsString;
                  FieldByName('medicacion_no_programada').Value := camas2medicacion_no_programada.AsString;
                  FieldByName('medicacion_no_aplicada').Value := camas2medicacion_no_aplicada.asString;

                  FieldByName('aislamiento_contacto').Value := camas2aislamiento_contacto.AsString;
                  FieldByName('aislamiento_gota').Value := camas2aislamiento_gota.AsString;
                  FieldByName('aislamiento_respiratorio').Value := camas2aislamiento_respiratorio.AsString;
                  FieldByName('aislamiento_neutropenico').Value := camas2aislamiento_neutropenico.AsString;
                  FieldByName('aislamiento_cd').Value := camas2aislamiento_cd.AsString;
                  FieldByName('aislamiento_sc').Value := camas2aislamiento_sc.AsString;

                  FieldByName('tipo_alta_medica').Value := camas2tipo_alta_medica.AsString;
                  FieldByName('acompanante').Value := camas2acompanante.AsInteger;
                  FieldByName('observaciones_acompanante').Value := camas2observaciones_acompanante.AsString;
                  FieldByName('orden').Value := camas2orden.AsInteger;
                  FieldByName('cambioCamaPendiente').Value := camas2cambioCamaPendiente.AsInteger;
                  FieldByName('alertas').Value := camas2alertas.AsInteger;
                  FieldByName('tareasPendientes').Value := camas2tareasPendientes.AsInteger;
                  FieldByName('altaProbable_fecha').Value := camas2altaProbable_fecha.AsString;
                  FieldByName('altaProbable_tipo').Value := camas2altaProbable_tipo.AsString;
                  FieldByName('altaProbable_dniUsuario').Value := camas2altaProbable_dniUsuario.AsInteger;
                  FieldByName('reserva_motivo').Value := camas2reserva_motivo.AsString;
                  FieldByName('fecha_reserva').Value := camas2fecha_reserva.AsString;
                  FieldByName('reservada_por_dni').Value := camas2reservada_por_dni.AsInteger;
                  FieldByName('reservada_por_nombre').Value := camas2reservada_por_nombre.AsString;
                  FieldByName('id_reserva').Value := camas2id_reserva.AsInteger;
                  FieldByName('reserva_fecha_cancelada').Value := camas2reserva_fecha_cancelada.AsString;
                  FieldByName('reserva_cancelada_por_dni').Value := camas2reserva_cancelada_por_dni.AsInteger;
                  FieldByName('reserva_cancelada_por_nombre').Value := camas2reserva_cancelada_por_nombre.AsString;
                  FieldByName('reserva_paciente_dni').Value := camas2reserva_paciente_dni.AsString;
                  FieldByName('reserva_paciente_nombre').Value := camas2reserva_paciente_nombre.AsString;
                  FieldByName('id_motivo_fin_reserva').Value := camas2id_motivo_fin_reserva.AsInteger;
                  FieldByName('reserva_id_solicitudCambio').Value := camas2reserva_id_solicitudCambio.AsInteger;
                  FieldByName('foto_paciente').Value := camas2foto_paciente.AsString;
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
              datos.VerMensaje('ERROR ','No se pudo verificar si los datos de las camas cambiaron','Aceptar','ERROR',10);
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
                    .AddParam('nro_version', datos.GetAppVersion().ToString)
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
  ActualizarServicio;
end;

procedure TformTablero.FormCreate(Sender: TObject);
begin
  ControlarVersion;

 // obtenerPermisosModulosPaciente(datos.servicio); // obtengo los permisos que tiene este servicio.

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
    end;

  if datos.cambiarServicio = 1 then
    botonCambiarServicio.Enabled := true
  else
    botonCambiarServicio.Enabled := false;

  lyMenuLateral.Visible := false;
  Espera('stop');
end;

procedure TformTablero.ActualizarServicio;
var
  http: TidHTTP;
  respuesta_json:string;
  JSonObject:TJSonObject;
  JSonValue:TJSonValue;
  arreglo:TJSONArray;
  i:integer;
begin
  http := TidHTTP.Create();
  try
    http.Request.CustomHeaders.Values['TokenAcceso'] := datos.tokenAcceso;
    http.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
    http.Request.ContentType := 'application/json';
    http.Request.CharSet:='utf-8';
    try
      respuesta_json := http.Get(datos.urlTC +'/tablerocamas/serviciosVerUno?idservicio='+inttostr(datos.servicio));
    except
      on E: Exception do
        begin
          datos.VerMensaje('ERROR','No se puedo conectar a la api','Aceptar','ERROR',0);
        end;
    end;

    if http.ResponseCode = 200 then
      begin
        JSonObject  := TJSonObject.Create;
        JsonValue   := JSonObject.ParseJSONValue(respuesta_json);
        if (JSONValue is TJSONArray) then
          begin
            arreglo := JSONValue as TJSONArray;
            for i := 0 to arreglo.Count - 1 do
              begin
                nombreServicio.Text := ((JSONValue as TJSONArray).Items[i] as TJSonObject).Get('nombreServicio').JSONValue.Value;
                nombreServicio.TextSettings.FontColor := TAlphaColorRec.White;
                datos.cambioCama_areaCerrada := strtoint(((JSONValue as TJSONArray).Items[i] as TJSonObject).Get('cambioCama_areaCerrada').JSONValue.Value);
                datos.gestionaCamas := strtoint(((JSONValue as TJSONArray).Items[i] as TJSonObject).Get('gestionaCamas').JSONValue.Value);

                verPaciente := verificarPermisos(datos.servicio,1) // 1 = modulo paciente (información del paciente)
              end;
          end;
        JSonObject.Free;
      end
    else
      begin
        if http.ResponseCode = 404 then
          begin
            datos.VerMensaje('ERROR 404','Recurso no encontrado','Aceptar','ERROR',0);
          end;
      end;

  finally
    http.Free;
  end;
end;

procedure TformTablero.apagarAlertas(id_cama: integer);
var
  response : IResponse;
begin
  // marca como leidas todas las alertas de esta cama.
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('alertas/apagar')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_cama', id_cama.ToString)
              .AddParam('dni', '0') // no pongo el dni del usuario, porque el usuario no está llamando a esta proceso, sino que se ejecuta en forma automática (el usuario no apagó la alerta, lo hizo el sistema)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(apagaralertasTB))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR','No fue posible apagar las alertas de esta cama','Aceptar','ERROR',0);
    end;
end;

procedure TformTablero.blinking(id_cama: string);
var
  e:boolean;
begin
  if Assigned(contenedor) then
    begin
      with contenedor do
        begin
          if Assigned(FindComponent('bordeCama'+id_cama) as TRectangle) then
            begin
              with (FindComponent('bordeCama'+id_cama) as TRectangle) do
                begin
                  e := camas2.Locate('id_cama',id_cama,[]);
                  if camas2cambioCamaPendiente.AsInteger = 1 then
                    begin
                      if Assigned((FindComponent('panelB'+id_cama) as TRectangle)) then
                        begin
                          if (FindComponent('panelB'+id_cama) as TRectangle).Fill.Color = TAlphaColorRec.Red then
                            (FindComponent('panelB'+id_cama) as TRectangle).Fill.Color := TAlphaColor(StrToAlphaColor('#FFA4D1'))
                          else
                            (FindComponent('panelB'+id_cama) as TRectangle).Fill.Color := TAlphaColorRec.Red;
                        end;
                    end
                  else
                    begin
                      if Assigned((FindComponent('panelB'+id_cama) as TRectangle)) then
                        begin
                          if (FindComponent('panelB'+id_cama) as TRectangle).Fill.Color = TAlphaColorRec.White then
                            (FindComponent('panelB'+id_cama) as TRectangle).Fill.Color := TAlphaColorRec.Red
                          else
                            (FindComponent('panelB'+id_cama) as TRectangle).Fill.Color := TAlphaColorRec.White;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TformTablero.botonActualizarClick(Sender: TObject);
begin
  lyMenuLateral.Visible := false;
  ActualizarCamas;
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
