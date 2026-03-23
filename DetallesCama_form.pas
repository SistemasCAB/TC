unit DetallesCama_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Effects, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,

  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Edit,
  System.JSON,System.DateUtils
  ;

type
  Tform_DetallesCama = class(TForm)
    Formulario: TRectangle;
    contenedorPrincipal: TLayout;
    lyBotones: TLayout;
    rBotonSalir: TRectangle;
    Image1: TImage;
    Label2: TLabel;
    botonSalir: TSpeedButton;
    rBotonActualizar: TRectangle;
    Image4: TImage;
    Label22: TLabel;
    botonActualizar: TSpeedButton;
    ly_panelCentral: TLayout;
    recReserva: TRectangle;
    ShadowEffect3: TShadowEffect;
    Rectangle4: TRectangle;
    Label23: TLabel;
    lb_reserva_observaciones: TLabel;
    lyDatosInternacion: TLayout;
    panelCama: TRectangle;
    etiquetaEstado: TRectangle;
    Label1: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    lb_cama: TLabel;
    lb_estado: TLabel;
    lb_id_cama: TLabel;
    ShadowEffect1: TShadowEffect;
    panelPaciente: TRectangle;
    ShadowEffect2: TShadowEffect;
    foto: TImage;
    lbTituloApellido: TLabel;
    lb_apellido: TLabel;
    lbTituloNombre: TLabel;
    lb_nombre: TLabel;
    lbTituloDocumento: TLabel;
    lb_nro_documento: TLabel;
    lb_TituloCobertura: TLabel;
    lb_cobertura: TLabel;
    lb_TituloPlan: TLabel;
    lb_plan: TLabel;
    lb_TituloNroAfiliado: TLabel;
    lb_nro_afiliado: TLabel;
    Rectangle2: TRectangle;
    lb_tituloPaciente: TLabel;
    panelInternacion: TRectangle;
    ShadowEffect4: TShadowEffect;
    Label9: TLabel;
    lb_ingreso_institucion: TLabel;
    lb_fecha_alta_medica: TLabel;
    Label11: TLabel;
    lb_ingreso_cama: TLabel;
    icono_alta_medica: TImage;
    lb_tipoAlta: TLabel;
    lb_altaProfesional: TLabel;
    Rectangle1: TRectangle;
    lb_tituloInternacion: TLabel;
    panelAislamientos: TRectangle;
    panelAislamientosTitulo: TRectangle;
    Label14: TLabel;
    ShadowEffect5: TShadowEffect;
    recCambioCama: TRectangle;
    ShadowEffect6: TShadowEffect;
    rectTituloCambioCambio: TRectangle;
    lb_cambioCama: TLabel;
    CalloutPanel1: TCalloutPanel;
    lb_cama_origen: TLabel;
    rCambioCama: TRectangle;
    lb_cama_destino: TLabel;
    botonCambioCama: TSpeedButton;
    Image5: TImage;
    Label28: TLabel;
    Label29: TLabel;
    botonReserva: TRectangle;
    SpeedButton1: TSpeedButton;
    Image6: TImage;
    lb_botonReserva: TLabel;
    Layout6: TLayout;
    rBotonReparacion: TRectangle;
    Image12: TImage;
    Label31: TLabel;
    botonReparacion: TSpeedButton;
    botonQuirofano: TRectangle;
    Image13: TImage;
    lb_botonQuirofano: TLabel;
    SpeedButton3: TSpeedButton;
    Layout7: TLayout;
    Layout8: TLayout;
    botonAltaDefinitiva: TRectangle;
    Image14: TImage;
    Label33: TLabel;
    btn_AltaDefinitiva: TSpeedButton;
    separadorDatosPaciente: TRectangle;
    recProcedimiento: TRectangle;
    ShadowEffect7: TShadowEffect;
    lb_cantidad_procedimientos: TLabel;
    Label32: TLabel;
    recMedicacionNoProgramada: TRectangle;
    ShadowEffect8: TShadowEffect;
    lb_indicaciones_no_programadas: TLabel;
    Label35: TLabel;
    recMedicacionNoAplicada: TRectangle;
    ShadowEffect9: TShadowEffect;
    lb_medicacion_no_aplicada: TLabel;
    Label37: TLabel;
    camas: TFDMemTable;
    apagarAlertasTb: TFDMemTable;
    apagarAlertasTbestado: TFloatField;
    apagarAlertasTbmensaje: TWideStringField;
    Rectangle5: TRectangle;
    fecha: TFDMemTable;
    fecharesultado: TWideStringField;
    fechafecha_servidor: TWideStringField;
    rectAlertaCambioCama: TRectangle;
    lb_botonCambioCama: TLabel;
    lb_paciCodigo: TLabel;
    lb_id_internacion: TLabel;
    FondoTransparente: TRectangle;
    recAlertas: TRectangle;
    ShadowEffect10: TShadowEffect;
    lb_alertasTexto: TLabel;
    contenedorAlertas: TLayout;
    Button2: TButton;
    alertas: TFDMemTable;
    alertasid_alerta: TWideStringField;
    alertasid_tipo_alerta: TWideStringField;
    alertastipo_alerta: TWideStringField;
    alertasid_cama: TWideStringField;
    alertasfecha: TWideStringField;
    alertasleida: TWideStringField;
    camasidCama: TWideStringField;
    camascama: TWideStringField;
    camasidHabitacion: TWideStringField;
    camashabitacion: TWideStringField;
    camaspiso: TWideStringField;
    camaspisoTexto: TWideStringField;
    camastipocama: TWideStringField;
    camasidEstado: TWideStringField;
    camasestado: TWideStringField;
    camascolor: TWideStringField;
    camasnombrePaciente: TWideStringField;
    camasapellidoPaciente: TWideStringField;
    camasnroDocumento: TWideStringField;
    camassexo: TWideStringField;
    camasfechaIngresoInstitucion: TWideStringField;
    camasfechaIngresoCama: TWideStringField;
    camascobertura: TWideStringField;
    camasfantasia: TWideStringField;
    camasplan: TWideStringField;
    camasnroAfiliado: TWideStringField;
    camasidInternacion: TWideStringField;
    camasfechaAltaMedica: TWideStringField;
    camasprofesionalAlta: TWideStringField;
    camascamaEnAislamiento: TWideStringField;
    camasobservaciones: TWideStringField;
    camasfotoPaciente: TWideStringField;
    camasprocedimientosNoCumplidos: TWideStringField;
    camasmedicacionNoProgramada: TWideStringField;
    camasmedicacionNoAplicada: TWideStringField;
    camastipoAltaMedica: TWideStringField;
    camasacompanante: TWideStringField;
    camasobservacionesAcompanante: TWideStringField;
    camascambioCamaPendiente: TWideStringField;
    camascambioCamaIdSolicitud: TWideStringField;
    camastareasPendientes: TWideStringField;
    camascantidadAlertas: TWideStringField;
    camascambioCamaAutorizacion: TWideStringField;
    camascambioCamaAutorizadoPorNombre: TWideStringField;
    camascambioCamaAutorizadoFecha: TWideStringField;
    camascambioCamaIdCamaDestino: TWideStringField;
    camascambioCamaCamaDestino: TWideStringField;
    camasaltaProbableFecha: TWideStringField;
    camasaltaProbable_idTipoAlta: TWideStringField;
    camasaltaProbable_tipoAltaProbable: TWideStringField;
    camasaltaProbable_dniUsuario: TWideStringField;
    permisos: TFDMemTable;
    permisosidPermiso: TIntegerField;
    permisosidServicio: TIntegerField;
    permisosnombreServicio: TStringField;
    permisosidModulo: TIntegerField;
    permisosnombreModulo: TStringField;
    permisosdescripcion: TMemoField;
    permisoscontrolTotal: TIntegerField;
    lyAlertasMedicas: TLayout;
    camassoloAltaMedica: TIntegerField;
    rec: TRectangle;
    Button1: TButton;
    edcolor: TEdit;
    pAislamiento: TLayout;
    lyAislamientoAC: TLayout;
    fechaAislamientoAC: TLabel;
    botonAislamientos: TSpeedButton;
    iconoAislamientoAC: TImage;
    camastdocCodigo: TIntegerField;
    camasaislamientos: TMemoField;
    camaspaciCodigo: TIntegerField;
    aislamientos: TFDMemTable;
    aislamientosidPacienteAislamiento: TIntegerField;
    aislamientosidAislamiento: TIntegerField;
    aislamientosnombre: TStringField;
    aislamientosbreve: TStringField;
    aislamientoscolor: TStringField;
    aislamientoscreadoPorDni: TStringField;
    aislamientoscreadoPorNombre: TStringField;
    lbAgregarAislamiento: TLabel;
    aislamientosfinalizadoPorDni: TStringField;
    aislamientosfinalizadoPorNombre: TStringField;
    aislamientosestado: TStringField;
    aislamientosfechaDesde: TStringField;
    aislamientosfechaHasta: TStringField;
    camastdocDescripcion: TStringField;
    aislamientoskpc: TIntegerField;
    camasidTipoAltaMedica: TIntegerField;
    camastareasBloqueanHabitacion: TIntegerField;
    camastareasBloqueanCama: TIntegerField;
    camaslimpia: TIntegerField;
    camasrequiereAutorizacionEnfermeria: TIntegerField;
    camasautEnfermeriaEstado: TIntegerField;
    camasautEnfermeriaPorDni: TStringField;
    camasautEnfermeriaPorNombre: TStringField;
    camasautEnfermeriaFecha: TStringField;
    procedure botonSalirClick(Sender: TObject);
    procedure botonActualizarClick(Sender: TObject);
    procedure Actualizar(idCama:integer);
    procedure btn_AltaDefinitivaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApagarAlertas(idCama: integer);
    procedure botonCambioCamaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure crearAlertas(id_cama, id_servicio:integer; dni:string);
    procedure crearAlerta(id_alerta: integer; texto:string);
    procedure obtenerPermisosModulosPaciente(idServicio: integer);
    function permisoModulo(idModulo: integer): integer;
    procedure Cerrar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure botonAislamientosClick(Sender: TObject);
    procedure CargarAislamientosDesdeJson(const JsonStr:string; Aislamientos: TFDMemTable);
    procedure MostrarAislamentos;
    procedure cambiosDeCamaActualizar;
  private
    { Private declarations }
  public
    idCama:integer;
    rAlertas:TRectangle;
    ancho, alto: integer;
  end;

var
  form_DetallesCama: Tform_DetallesCama;

implementation

{$R *.fmx}

uses form_Tablero, ModuloDatos, UFunciones, constantes, CambioDeCama_form, CambioDeCamaAdmision_form,
  FMX.Image.Base64, AltaDefinitiva_form, Aislamientos_form;

procedure Tform_DetallesCama.Actualizar(idCama:integer);
var
  mensaje:string;
  response: IResponse;
  apiRecurso:string;

  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  AislamientosArray: TJSONArray;
  I: Integer;
begin
  obtenerPermisosModulosPaciente(datos.servicio); // obtengo los permisos que tiene este servicio.

  // Obtengo los datos de la cama
  apiRecurso := '/tablerocamas/verUnaCama';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idCama', idCama.ToString)
              .AddParam('idServicio', datos.servicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(camas))
              .Get;

  if response.StatusCode = 200 then
    begin
      lb_cama.Text := camascama.AsString;
      lb_id_cama.Text := camasidCama.AsString;
      lb_estado.Text  := camasestado.AsString;
      etiquetaEstado.Fill.Color := TAlphaColor(StrToAlphaColor(camascolor.AsString));


      // SI LA CAMA ESTÁ OCUPADA
      if camasidEstado.AsInteger = 2 then
        begin
          // PANEL PACIENTE

          // Permisos: 0 = sin permiso, 1 = solo lectura, 2 = control total
          case permisoModulo(1) of
            0: begin
              panelPaciente.Visible := true;
              lb_paciCodigo.Text := 'ID: ' + camaspaciCodigo.AsString;
              if camassexo.AsString = 'F' then
                lb_apellido.Text := 'MUJER'
              else
                lb_apellido.Text := 'HOMBRE';
              lb_nombre.Text   := '';
              lb_nro_documento.Text := '';
              lb_cobertura.Text := '';
              lb_plan.Text := '';
              lb_nro_afiliado.Text := '';
              foto.Base64(sin_foto);
              lbTituloApellido.Text := '';
              lbTituloNombre.Text := '';
              lbTituloDocumento.Text := '';
              lb_TituloCobertura.Text := '';
              lb_TituloPlan.Text := '';
              lb_TituloNroAfiliado.Text := '';
              lb_paciCodigo.Text := '';

            end;
            1: begin
              panelPaciente.Visible := true;
              lb_paciCodigo.Text := 'ID: ' + camaspaciCodigo.AsString;
              lb_apellido.Text := camasapellidoPaciente.AsString;
              lb_nombre.Text   := camasnombrePaciente.AsString;
              // agregar tipo de documento
              lb_nro_documento.Text := camastdocDescripcion.AsString + ': '+  camasnroDocumento.AsString;
              lb_cobertura.Text := camasfantasia.AsString;
              lb_plan.Text := camasplan.AsString;
              lb_nro_afiliado.Text := camasnroAfiliado.AsString;
              if camasfotoPaciente.AsString <> '' then
                foto.Base64(camasfotoPaciente.AsString)
              else
                foto.Base64(sin_foto);
            end;
            2:begin
              panelPaciente.Visible := true;
              lb_paciCodigo.Text := 'ID: ' + camaspaciCodigo.AsString;
              lb_apellido.Text := camasapellidoPaciente.AsString;
              lb_nombre.Text   := camasnombrePaciente.AsString;
              // agregar tipo de documento
              lb_nro_documento.Text := camastdocDescripcion.AsString + ': '+  camasnroDocumento.AsString;
              lb_cobertura.Text := camasfantasia.AsString;
              lb_plan.Text := camasplan.AsString;
              lb_nro_afiliado.Text := camasnroAfiliado.AsString;
              if camasfotoPaciente.AsString <> '' then
                foto.Base64(camasfotoPaciente.AsString)
              else
                foto.Base64(sin_foto);
            end;
          end;



          // PANEL INTERNACIÓN
          case permisoModulo(2) of
            0: begin
              panelInternacion.Visible := false;
            end;

            1:begin
              lb_id_internacion.Text := 'ID: ' + camasidInternacion.AsString;
              panelInternacion.Visible := true;
              lb_ingreso_institucion.Text := camasfechaIngresoInstitucion.AsString;
              lb_ingreso_cama.Text := camasfechaIngresoCama.AsString;

              if camasfechaAltaMedica.AsString <> '' then
                begin
                  icono_alta_medica.Visible := true;
                  lb_fecha_alta_medica.Text := camasfechaAltaMedica.AsString;
                  lb_tipoAlta.Text := camastipoAltaMedica.AsString;
                  lb_altaProfesional.Text := camasprofesionalAlta.AsString;
                end
              else
                begin
                  icono_alta_medica.Visible := false;
                  lb_fecha_alta_medica.Text := '';
                  lb_tipoAlta.Text := '';
                  lb_altaProfesional.Text := '';
                end;
              botonAltaDefinitiva.Visible := false;
            end;

            2:begin
              lb_id_internacion.Text := 'ID: ' + camasidInternacion.AsString;
              panelInternacion.Visible := true;
              lb_ingreso_institucion.Text := camasfechaIngresoInstitucion.AsString;
              lb_ingreso_cama.Text := camasfechaIngresoCama.AsString;

              if camasfechaAltaMedica.AsString <> '' then
                begin
                  icono_alta_medica.Visible := true;
                  lb_fecha_alta_medica.Text := camasfechaAltaMedica.AsString;
                  lb_tipoAlta.Text := camastipoAltaMedica.AsString;
                  lb_altaProfesional.Text := camasprofesionalAlta.AsString;
                  //botonAltaDefinitiva.Visible := true;
                end
              else
                begin
                  icono_alta_medica.Visible := false;
                  lb_fecha_alta_medica.Text := '';
                  lb_tipoAlta.Text := '';
                  lb_altaProfesional.Text := '';
                  //botonAltaDefinitiva.Visible := false;
                end;
            end;
          end;


          // PANEL AISLAMIENTOS

          // cargo los aislamientos en la tabla aislamientos a partir del json del campo camasaislamientos

          JsonValue := TJSONObject.ParseJSONValue(response.Content);

          JsonArray := JsonValue as TJSONArray;
          JsonObj := JsonArray.Items[0] as TJSONObject;

          AislamientosArray := JsonObj.GetValue<TJSONArray>('aislamientos');

          CargarAislamientosDesdeJson(AislamientosArray.ToJSON, aislamientos);

          MostrarAislamentos;

          // ALERTAS MÉDICAS
          case permisoModulo(5) of
            0: begin
              lyAlertasMedicas.Visible := false;
            end;

            1: begin
              lyAlertasMedicas.Visible := true;
              // PROCEDIMIENTOS NO CUMPLIDOS
              recProcedimiento.Visible          := true;
              if camasprocedimientosNoCumplidos.AsInteger > 0 then
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Red
              else
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Grey;

              lb_cantidad_procedimientos.Text := camasprocedimientosNoCumplidos.AsString;

              // INDICACIONES NO PROGRAMADAS
              recMedicacionNoProgramada.Visible := true;
              if camasmedicacionNoProgramada.AsInteger > 0 then
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Red
              else
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Grey;

              lb_indicaciones_no_programadas.Text := camasmedicacionNoProgramada.AsString;

              // MEDICACION NO APLICADA
              recMedicacionNoAplicada.Visible   := true;
              if camasmedicacionNoAplicada.AsInteger > 0 then
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Red
              else
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Grey;

              lb_medicacion_no_aplicada.Text := camasmedicacionNoAplicada.AsString;
            end;

            2: begin
              lyAlertasMedicas.Visible := true;
              // PROCEDIMIENTOS NO CUMPLIDOS
              recProcedimiento.Visible          := true;
              if camasprocedimientosNoCumplidos.AsInteger > 0 then
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Red
              else
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Grey;

              lb_cantidad_procedimientos.Text := camasprocedimientosNoCumplidos.AsString;

              // INDICACIONES NO PROGRAMADAS
              recMedicacionNoProgramada.Visible := true;
              if camasmedicacionNoProgramada.AsInteger > 0 then
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Red
              else
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Grey;

              lb_indicaciones_no_programadas.Text := camasmedicacionNoProgramada.AsString;

              // MEDICACION NO APLICADA
              recMedicacionNoAplicada.Visible   := true;
              if camasmedicacionNoAplicada.AsInteger > 0 then
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Red
              else
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Grey;

              lb_medicacion_no_aplicada.Text := camasmedicacionNoAplicada.AsString;
            end;
          end;



          // PANEL RESERVA
          recReserva.Visible := false;

          // PANEL CAMBIO DE CAMA
          cambiosDeCamaActualizar;



          // ENVIAR A QUIRÓFANO
          if datos.servicio <> 7 then // si el servicio no es quirófano
            begin
              case permisoModulo(7) of
                0: begin
                  botonQuirofano.Visible := false;
                end;

                1: begin
                  botonQuirofano.Visible := true;
                end;

                2: begin
                  botonQuirofano.Visible := true;
                end;
              end;
            end
          else
            begin
              botonQuirofano.Visible := false;
            end;




        end
      else
        begin
          panelPaciente.Visible             := false;
          panelInternacion.Visible          := false;
          panelAislamientos.Visible         := false;
          lyAlertasMedicas.Visible          := false;
          botonQuirofano.Visible            := false;
          recCambioCama.Visible             := false;

          // TAREAS DE REPARACIÓN
          case permisoModulo(6) of
            0: begin
              rBotonReparacion.Visible := false;
            end;

            1: begin
              rBotonReparacion.Visible := true;
            end;

            2: begin
              rBotonReparacion.Visible := true;
            end;
          end;

          // RESERVADAS
          case permisoModulo(8) of
            0: begin
              recReserva.Visible := false;
            end;

            1: begin
              recReserva.Visible := true;
              lb_reserva_observaciones.Text := camasobservaciones.AsString;
              lb_botonReserva.Text := 'Eliminar Reserva';
              botonReserva.Visible := false;
            end;

            2: begin
              recReserva.Visible := true;
              lb_reserva_observaciones.Text := camasobservaciones.AsString;
              lb_botonReserva.Text := 'Eliminar Reserva';
            end;
          end;


        end;

      // Alertas
      if Assigned(contenedorAlertas) then
        contenedorAlertas.Destroy;

      contenedorAlertas := TLayout.Create(ly_panelCentral);
      contenedorAlertas.Parent := ly_panelCentral;
      contenedorAlertas.Name := 'contenedorAlertas';
      contenedorAlertas.Align := TAlignLayout.Client;

      if camascantidadAlertas.AsInteger > 0 then
        begin
          crearAlertas(idCama,datos.servicio,datos.dniLogin);
        end;
    end
  else
    begin
      mensaje := camas.FieldByName('mensaje').AsString + #13 + #13 + 'Recurso: ' + apiRecurso + #13 + 'ID cama: ' + idCama.ToString;
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString,mensaje,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_DetallesCama.ApagarAlertas(idCama: integer);
var
  response : IResponse;
begin
  // marca como leidas todas las alertas de esta cama.
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('tablerocamas/apagarAlertas')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idCama', idCama.ToString)
              .AddParam('leidaPorDni', datos.dniLogin)
              .AddParam('leidaPorNombre',datos.nombreLogin)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(apagaralertastb))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR' + response.StatusCode.ToString,'No fue posible apagar las alertas de esta cama','Aceptar','ERROR',0);
    end;
end;

procedure Tform_DetallesCama.botonActualizarClick(Sender: TObject);
begin
  Actualizar(idCama);
end;

procedure Tform_DetallesCama.botonAislamientosClick(Sender: TObject);
begin
  // antes de darle acceso al formulario de los aislamientos, verifico que tenga controlTotal (2) para usar ese módulo.
  case permisoModulo(3) of
    0: begin
        datos.VerMensaje('ACCESO DENEGADO','No tenés permisos para acceder al módulo Aislamientos del Paciente.','Aceptar','ERROR',0);
    end;
    1: begin
        if aislamientos.RecordCount = 0 then // si no hay aislamientos y tiene permiso de solo lectura, no puede agregar.
          begin
            datos.VerMensaje('ACCESO DENEGADO','No tenés permisos para agregar Aislamientos al Paciente.','Aceptar','ERROR',0);
          end
        else
          begin
            Application.CreateForm(TformAislamiento, formAislamiento);
            formAislamiento.Height := alto;
            formAislamiento.Width := ancho;
            // agregar tipo de documento
            formAislamiento.idInternacion := camasidInternacion.AsInteger;
            formAislamiento.ShowModal;
          end;
    end;
    2: begin
        Application.CreateForm(TformAislamiento, formAislamiento);
        formAislamiento.Height := alto;
        formAislamiento.Width := ancho;
        // agregar tipo de documento
        formAislamiento.idInternacion := camasidInternacion.AsInteger;
        formAislamiento.ShowModal;
      end;
  end;
end;

procedure Tform_DetallesCama.botonCambioCamaClick(Sender: TObject);
begin
  if datos.gestionaCamas = 1 then // Ejemplo: Admisión
    begin
      Application.CreateForm(Tform_CambioCamaAdmision, form_CambioCamaAdmision);
      form_CambioCamaAdmision.Height        := alto;
      form_CambioCamaAdmision.Width         := ancho;
      form_CambioCamaAdmision.idCamaOrigen  := idCama;
      form_CambioCamaAdmision.idInternacion := camasidInternacion.AsInteger;
      form_CambioCamaAdmision.ShowModal;
    end
  else
    begin
      Application.CreateForm(Tform_CambioDeCama, form_CambioDeCama);
      form_CambioDeCama.Height          := alto;
      form_CambioDeCama.Width           := ancho;
      form_CambioDeCama.idCamaOrigen    := idCama;
      form_CambioDeCama.idInternacion   := camasidInternacion.AsInteger;
      form_CambioDeCama.tdocCodigo      := camastdocCodigo.AsInteger;
      form_CambioDeCama.nroDocumento    := camasnroDocumento.AsString;
      form_CambioDeCama.paciCodigo      := camaspaciCodigo.AsInteger;
      form_CambioDeCama.ShowModal;
    end;

  Actualizar(idCama);
end;

procedure Tform_DetallesCama.botonSalirClick(Sender: TObject);
begin
  //formTablero.reloj.Enabled := true;
  Close;
end;

procedure Tform_DetallesCama.Button1Click(Sender: TObject);
begin
  rec.Fill.Color := StrToAlphaColor(edcolor.Text);
end;

procedure Tform_DetallesCama.Button2Click(Sender: TObject);
begin
  if Assigned(contenedorAlertas) then
      contenedorAlertas.Destroy;

  contenedorAlertas := TLayout.Create(ly_panelCentral);
  contenedorAlertas.Parent := ly_panelCentral;
  contenedorAlertas.Name := 'contenedorAlertas';
  contenedorAlertas.Align := TAlignLayout.Client;

  rAlertas := TRectangle.Create(contenedorAlertas);
  rAlertas.Parent := contenedorAlertas;
  rAlertas.Height := 54;
  rAlertas.Name := 'recAlertas1';
  rAlertas.Fill.Kind := TbrushKind.Solid;
  rAlertas.Fill.Color := TAlphaColorRec.Red;
  rAlertas.Stroke.Kind := TbrushKind.None;
  rAlertas.Align := TAlignLayout.Top;
  rAlertas.HitTest := false;
  rAlertas.CornerType := TCornerType.Round;
  rAlertas.Corners := [TCorner.TopLeft,TCorner.TopRight,TCorner.BottomLeft,TCorner.BottomRight];
  rAlertas.XRadius := 5;
  rAlertas.YRadius := 5;

  // sombra
  with TShadowEffect.Create(rAlertas) do
    begin
      Parent := rAlertas;
      Name := 'sombraAlerta1';
      Direction := 45;
      Distance := 2;
      Enabled := true;
      Opacity := 0.6;
      ShadowColor := TAlphaColorRec.Black;
      Softness := 0.3;
    end;

  // etiqueta de color
  with TLabel.Create(rAlertas) do
    begin
      Parent := rAlertas;
      Align := TAlignLayout.Client;
      Name := 'lb_textoAlerta1';
      Text := 'Ingreso de Paciente';
      StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
      TextSettings.Font.Size := 15;
      TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
      TextSettings.HorzAlign := TTextAlign.Leading;
      Margins.Left := 10;
    end;
end;

procedure Tform_DetallesCama.cambiosDeCamaActualizar;
begin
  case permisoModulo(4) of
    // no accede porque no tiene permisos
    0: begin
      recCambioCama.Visible := false;
    end;

    // acceso de solo lectura.
    1: begin
      recCambioCama.Visible := true;
      lb_cama_origen.Text := camascama.AsString;
      lb_cama_destino.Text := camascambioCamaCamaDestino.AsString;
      if datos.gestionaCamas = 1 then // si es un servicio con la función de Admisión y Egresos
        begin
          if camascambioCamaPendiente.AsInteger = 1 then
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.Darkorchid;
            end
          else
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.White;
            end;
        end
      else
        begin
          if camascambioCamaAutorizacion.AsInteger <> 0 then
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.Red;
              lb_cama_destino.Text := camascambioCamaCamaDestino.AsString;
            end
          else
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.White;
            end;
        end;

      rCambioCama.Visible := false;
    end;

    // acceso con control total.
    2: begin
      recCambioCama.Visible := true;
      lb_cama_origen.Text := camascama.AsString;
      lb_cama_destino.Text := camascambioCamaCamaDestino.AsString;

      if datos.gestionaCamas = 1 then // si es un servicio con la función de Admisión y Egresos
        begin
          if camascambioCamaPendiente.AsInteger = 1 then
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.Darkorchid;  // color violeta
            end
          else
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.White;
            end;
        end
      else
        begin
          if camascambioCamaAutorizacion.AsInteger <> 0 then
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.Red;
              lb_cama_destino.Text := camascambioCamaCamaDestino.AsString;
            end
          else
            begin
              rectAlertaCambioCama.Fill.Color := TAlphaColorRec.White;
            end;
        end;

      rCambioCama.Visible := true;
    end;
  end;
end;

procedure Tform_DetallesCama.CargarAislamientosDesdeJson(
  const JsonStr: string;
  Aislamientos: TFDMemTable);
var
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  I: Integer;
begin
  Aislamientos.DisableControls;
  try
    Aislamientos.Close;
    Aislamientos.Open;
    Aislamientos.EmptyDataSet;

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

        Aislamientos.Append;

        Aislamientos.FieldByName('idPacienteAislamiento').AsInteger :=
          JsonObj.GetValue<Integer>('idPacienteAislamiento');

        Aislamientos.FieldByName('idAislamiento').AsInteger :=
          JsonObj.GetValue<Integer>('idAislamiento');

        Aislamientos.FieldByName('nombre').AsString :=
          JsonObj.GetValue<string>('nombre');

        Aislamientos.FieldByName('breve').AsString :=
          JsonObj.GetValue<string>('breve');

        Aislamientos.FieldByName('color').AsString :=
          JsonObj.GetValue<string>('color');

        Aislamientos.FieldByName('fechaDesde').AsString :=
          JsonObj.GetValue<string>('fechaDesde');

        Aislamientos.FieldByName('creadoPorDni').AsString :=
          JsonObj.GetValue<string>('creadoPorDni');

        Aislamientos.FieldByName('creadoPorNombre').AsString :=
          JsonObj.GetValue<string>('creadoPorNombre');

        Aislamientos.FieldByName('fechaHasta').AsString :=
          JsonObj.GetValue<string>('fechaHasta');

        Aislamientos.FieldByName('finalizadoPorDni').AsString :=
          JsonObj.GetValue<string>('finalizadoPorDni');

        Aislamientos.FieldByName('finalizadoPorNombre').AsString :=
          JsonObj.GetValue<string>('finalizadoPorNombre');

        Aislamientos.FieldByName('estado').AsString :=
          JsonObj.GetValue<string>('estado');

        Aislamientos.FieldByName('kpc').AsString :=
          JsonObj.GetValue<string>('kpc');

        Aislamientos.Post;
      end;
    finally
      JsonArray.Free;
    end;

  finally
    Aislamientos.EnableControls;
  end;
end;

//procedure Tform_DetallesCama.CargarAislamientosDesdeJson(const JsonStr: string; Aislamientos: TFDMemTable);
//var
//  JsonArray: TJSONArray;
//  JsonObj: TJSONObject;
//  I: Integer;
//  FS: TFormatSettings;
//begin
//  FS := TFormatSettings.Create;
//  FS.DateSeparator := '-';
//  FS.TimeSeparator := ':';
//  FS.ShortDateFormat := 'yyyy-mm-dd';
//  FS.LongTimeFormat := 'hh:nn:ss';
//
//  Aislamientos.DisableControls;
//
//  try
//    Aislamientos.Close;
//    Aislamientos.Open;
//    Aislamientos.EmptyDataSet;
//
//    JsonArray := TJSONObject.ParseJSONValue(JsonStr) as TJSONArray;
//
//    try
//      for I := 0 to JsonArray.Count - 1 do
//        begin
//          JsonObj := JsonArray.Items[I] as TJSONObject;
//
//          Aislamientos.Append;
//          Aislamientos.FieldByName('idPacienteAislamiento').AsInteger :=
//            JsonObj.GetValue<Integer>('idPacienteAislamiento');
//
//          Aislamientos.FieldByName('idAislamiento').AsInteger :=
//            JsonObj.GetValue<Integer>('idAislamiento');
//
//          Aislamientos.FieldByName('nombre').AsString :=
//            JsonObj.GetValue<string>('nombre');
//
//          Aislamientos.FieldByName('breve').AsInteger :=
//            JsonObj.GetValue<Integer>('breve');
//
//          Aislamientos.FieldByName('color').AsString :=
//            JsonObj.GetValue<string>('color');
//
//          Aislamientos.FieldByName('fechaDesde').AsDateTime :=
//            StrToDateTime(JsonObj.GetValue<string>('fechaDesde'), FS);
//
//          Aislamientos.FieldByName('creadoPorDni').AsString :=
//            JsonObj.GetValue<string>('creadoPorDni');
//
//          Aislamientos.FieldByName('creadoPorNombre').AsString :=
//            JsonObj.GetValue<string>('creadoPorNombre');
//
//          Aislamientos.Post;
//        end;
//    finally
//      JsonArray.Free;
//    end;
//  finally
//    Aislamientos.EnableControls;
//  end;
//
//end;

procedure Tform_DetallesCama.Cerrar;
begin
  Close;
end;

procedure Tform_DetallesCama.crearAlerta(id_alerta: integer; texto:string);
begin
  rAlertas := TRectangle.Create(contenedorAlertas);
  rAlertas.Parent := contenedorAlertas;
  rAlertas.Height := 54;
  rAlertas.Name := 'recAlertas' + id_alerta.ToString;
  rAlertas.Fill.Kind := TbrushKind.Solid;
  rAlertas.Fill.Color := TAlphaColorRec.Red;
  rAlertas.Stroke.Kind := TbrushKind.None;
  rAlertas.Align := TAlignLayout.Top;
  rAlertas.HitTest := false;
  rAlertas.CornerType := TCornerType.Round;
  rAlertas.Corners := [TCorner.TopLeft,TCorner.TopRight,TCorner.BottomLeft,TCorner.BottomRight];
  rAlertas.XRadius := 5;
  rAlertas.YRadius := 5;

  // sombra
  with TShadowEffect.Create(rAlertas) do
    begin
      Parent := rAlertas;
      Name := 'sombraAlerta' + id_alerta.ToString;
      Direction := 45;
      Distance := 2;
      Enabled := true;
      Opacity := 0.6;
      ShadowColor := TAlphaColorRec.Black;
      Softness := 0.3;
    end;

  // etiqueta de color
  with TLabel.Create(rAlertas) do
    begin
      Parent := rAlertas;
      Align := TAlignLayout.Client;
      Name := 'lb_textoAlerta'  + id_alerta.ToString;
      Text := texto;
      StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
      TextSettings.Font.Size := 15;
      TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
      TextSettings.HorzAlign := TTextAlign.Leading;
      Margins.Left := 10;
    end;
end;

procedure Tform_DetallesCama.crearAlertas(id_cama, id_servicio: integer; dni: string);
var
  response: IResponse;
begin
  // crea las alertas que recibe esta cama.
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('alertas/ver')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_cama', id_cama.ToString)
              .AddParam('id_servicio', id_servicio.ToString)
              .AddParam('dni', dni)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(alertas))
              .Get;

  if response.StatusCode = 200 then
    begin
      if alertas.RecordCount > 0 then
        begin
          alertas.First;
          repeat
            crearAlerta(alertasid_alerta.AsInteger,alertastipo_alerta.AsString);
            alertas.Next;
          until alertas.Eof;
        end;
    end;
end;

procedure Tform_DetallesCama.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  // apago todas las alertas de esta cama
  ApagarAlertas(idCama);
end;

procedure Tform_DetallesCama.FormCreate(Sender: TObject);
begin
  alto := form_DetallesCama.Height;
  ancho := form_DetallesCama.Width;
end;

procedure Tform_DetallesCama.MostrarAislamentos;
var
  lyAisl: TLayout;
  fecAis: TLabel;
  iconAis: TImage;
begin
  while pAislamiento.ChildrenCount > 0 do
    pAislamiento.Children[0].Free;

  if permisoModulo(3) = 0 then
    begin
      panelAislamientos.Visible := false;
    end
  else
    begin
      panelAislamientos.Visible := true;

      if(aislamientos.RecordCount > 0) then
        begin
          aislamientos.First;
          repeat
            // creo los objetos para cada tipo de aislamiento que tiene el paciente.

            if aislamientosestado.AsString = 'Vigente' then
              begin
                // Layout aislamiento
            lyAisl := TLayout.Create(pAislamiento);
            lyAisl.Parent := pAislamiento;
            lyAisl.name := 'lyAislamiento'+ aislamientosidPacienteAislamiento.AsString;
            lyAisl.width := 82;
            lyAisl.Align := TAlignLayout.Left;


            // Ícono Aislamiento
            with TImage.Create(lyAisl) do
              begin
                Parent := lyAisl;
                Height := 50;
                Align := TAlignLayout.Top;
                Name := 'iconoAislamiento'+ aislamientosidPacienteAislamiento.AsString;
                WrapMode := TImageWrapMode.Fit;
                HitTest := false;
                case aislamientosidAislamiento.AsInteger of
                  1: begin
                    if aislamientoskpc.AsInteger = 1 then
                      Base64(aislamientoKPC)
                    else
                      Base64(aislamientoAC);
                  end;

                  2: begin
                    Base64(aislamientoAR);
                  end;

                  3: begin
                    Base64(aislamientoAG);
                  end;
                  4: begin
                    Base64(aislamientoAN);
                  end;
                  5: begin
                    Base64(aislamientoCD);
                  end;
                  6: begin
                    Base64(aislamientoSC);
                  end;
                end;
              end;

              // Fecha del aislamiento
              with TLabel.Create(lyAisl) do
                begin
                  Parent := lyAisl;
                  Height := 37;
                  Width := 82;
                  Align := TAlignLayout.Bottom;
                  HitTest := false;
                  Name := 'fechaAislamiento'+ aislamientosidPacienteAislamiento.AsString;
                  StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
                  // TextSettings.Font.Size := 13;
                  // TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
                  TextSettings.HorzAlign := TTextAlign.Center;
                  HitTest := false;
                  Text := aislamientosfechaDesde.AsString;
                end;
              end;



            aislamientos.Next;
          until aislamientos.Eof;
        end
      else
        begin
          // si no hay aislamientos, muestro el texto Agregar Aislamiento.

          with TLabel.Create(pAislamiento) do
            begin
              Parent := pAislamiento;
              Align := TAlignLayout.Client;
              HitTest := false;
              Name := 'lbAgregarAislamientos';
              StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
              TextSettings.Font.Size := 16;
              // TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
              TextSettings.HorzAlign := TTextAlign.Center;
              HitTest := false;
              Text := 'Agregar Aislamiento';
            end;
        end;
    end;
end;

procedure Tform_DetallesCama.obtenerPermisosModulosPaciente(idServicio: integer);
var
  response: IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/tablerocamas/permisosModulosTableroServicio')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio', idServicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(permisos))
              .Get;

  if response.StatusCode <> 200 then
    datos.VerMensaje('ERROR',response.Content,'Aceptar','ERROR',0);
end;

function Tform_DetallesCama.permisoModulo(idModulo: integer): integer;
var
  res:integer;
begin
  // Permisos: 0 = sin permiso, 1 = solo lectura, 2 = control total

  Result := 0; // valor por defecto, sin permiso

  if permisos.Locate('idModulo', idModulo, []) then
    Result := permisos.FieldByName('controlTotal').AsInteger;
end;

procedure Tform_DetallesCama.btn_AltaDefinitivaClick(Sender: TObject);
var
  mens:string;
  response: IResponse;
begin
  if permisoModulo(9) = 2 then // si tiene control total en el módulo Alta Definitiva
    begin
      if camasfechaAltaMedica.AsString = '' then
        datos.VerMensaje('NO HAY EPICRISIS','El paciente no tiene el alta médica.'+#13+'No puede realizar el alta definitiva hasta que el médico haya hecho la epicrisis','Aceptar','ERROR',0)
      else
        begin
          Application.CreateForm(Tform_AltaDefinitiva, form_AltaDefinitiva);
          form_AltaDefinitiva.Height            := alto;
          form_AltaDefinitiva.Width             := ancho;
          form_AltaDefinitiva.idCama            := camasidCama.AsInteger;
          form_AltaDefinitiva.apellido          := camasapellidoPaciente.AsString;
          form_AltaDefinitiva.nombre            := camasnombrePaciente.AsString;
          form_AltaDefinitiva.dni               := camasnroDocumento.AsString;
          form_AltaDefinitiva.fechaAlta         := camasfechaAltaMedica.AsString;
          form_AltaDefinitiva.fechaIngresoCama  := camasfechaIngresoCama.AsString;
          form_AltaDefinitiva.tipoAlta          := camastipoAltaMedica.AsString;
          form_AltaDefinitiva.profesional       := camasprofesionalAlta.AsString;
          form_AltaDefinitiva.soloAltaMedica    := camassoloAltaMedica.AsInteger;
          form_AltaDefinitiva.id_habitacion     := camasidHabitacion.AsInteger;
          form_AltaDefinitiva.idTipoAltaMedica  := camasidTipoAltaMedica.AsInteger;
          form_AltaDefinitiva.paciCodigo        := camaspaciCodigo.AsInteger;
          form_AltaDefinitiva.Actualizar;
          form_AltaDefinitiva.showModal;
        end;
    end
  else
    begin
      datos.VerMensaje('ACCESO DENEGADO','El servicio '+ formTablero.nombreServicio.Text +' no tiene permiso para realizar el alta del paciente.','Aceptar','ERROR',0)
    end;
end;

end.
