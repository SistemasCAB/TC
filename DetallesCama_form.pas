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
  FMX.Memo, FMX.Edit
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
    lb_id_paciente: TLabel;
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
    camasid_cama: TWideStringField;
    camascama: TWideStringField;
    camasid_habitacion: TWideStringField;
    camashabitacion: TWideStringField;
    camaspiso: TWideStringField;
    camaspiso_texto: TWideStringField;
    camastipocama: TWideStringField;
    camasid_estado: TWideStringField;
    camasestado: TWideStringField;
    camascolor: TWideStringField;
    camasid_paciente: TWideStringField;
    camasnombre_paciente: TWideStringField;
    camasapellido_paciente: TWideStringField;
    camasdni: TWideStringField;
    camassexo: TWideStringField;
    camasfecha_ingreso_institucion: TWideStringField;
    camasfecha_ingreso_cama: TWideStringField;
    camascobertura: TWideStringField;
    camasfantasia: TWideStringField;
    camasplan: TWideStringField;
    camasnro_afiliado: TWideStringField;
    camasid_internacion: TWideStringField;
    camasfecha_alta_medica: TWideStringField;
    camasprofesional_alta: TWideStringField;
    camascama_en_aislamiento: TWideStringField;
    camasobservaciones: TWideStringField;
    camasfoto_paciente: TWideStringField;
    camasprocedimientos_no_cumplidos: TWideStringField;
    camasmedicacion_no_programada: TWideStringField;
    camasmedicacion_no_aplicada: TWideStringField;
    camastipo_alta_medica: TWideStringField;
    camasacompanante: TWideStringField;
    camasobservaciones_acompanante: TWideStringField;
    camascambioCamaPendiente: TWideStringField;
    camascambioCamaIdSolicitud: TWideStringField;
    camastareasPendientes: TWideStringField;
    camascantidadAlertas: TWideStringField;
    camascambioCamaAutorizacion: TWideStringField;
    camascambioCamaAutorizadoPorNombre: TWideStringField;
    camascambioCamaAutorizadoFecha: TWideStringField;
    camascambioCamaIdCamaDestino: TWideStringField;
    camascambioCamaCamaDestino: TWideStringField;
    camasaltaProbable_fecha: TWideStringField;
    camasaltaProbable_idTipoAlta: TWideStringField;
    camasaltaProbable_tipoAltaProbable: TWideStringField;
    camasaltaProbable_dniUsuario: TWideStringField;
    permisos: TFDMemTable;
    permisosid_permiso: TIntegerField;
    permisosid_servicio: TIntegerField;
    permisosnombreServicio: TStringField;
    permisosid_modulo: TIntegerField;
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
    camasaislamientos: TArrayField;
    procedure botonSalirClick(Sender: TObject);
    procedure botonActualizarClick(Sender: TObject);
    procedure Actualizar(id_cama:integer);
    procedure btn_AltaDefinitivaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApagarAlertas(id_cama:integer);
    procedure botonCambioCamaClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure crearAlertas(id_cama, id_servicio:integer; dni:string);
    procedure crearAlerta(id_alerta: integer; texto:string);
    procedure obtenerPermisosModulosPaciente(id_servicio:integer);
    function permisoModulo(id_modulo: integer): integer;
    procedure Cerrar;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure botonAislamientosClick(Sender: TObject);
  private
    { Private declarations }
  public
    id_cama:integer;
    rAlertas:TRectangle;
    ancho, alto: integer;
  end;

var
  form_DetallesCama: Tform_DetallesCama;

implementation

{$R *.fmx}

uses form_Tablero, ModuloDatos, UFunciones, constantes, CambioDeCama_form, CambioDeCamaAdmision_form,
  FMX.Image.Base64, AltaDefinitiva_form, Aislamientos_form;

procedure Tform_DetallesCama.Actualizar(id_cama:integer);
var
  mensaje:string;
  response: IResponse;
  apiRecurso:string;
begin
  obtenerPermisosModulosPaciente(datos.servicio); // obtengo los permisos que tiene este servicio.

  // Obtengo los datos de la cama
  apiRecurso := '/camas/verUna_v2';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_cama', id_cama.ToString)
              .AddParam('id_servicio', datos.servicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(camas))
              .Get;

  if response.StatusCode = 200 then
    begin
      lb_cama.Text := camascama.AsString;
      lb_id_cama.Text := camasid_cama.AsString;
      lb_estado.Text  := camasestado.AsString;
      etiquetaEstado.Fill.Color := TAlphaColor(StrToAlphaColor(camascolor.AsString));


      // SI LA CAMA ESTÁ OCUPADA
      if camasid_estado.AsInteger = 2 then
        begin
          // PANEL PACIENTE
          case permisoModulo(1) of
            0: begin
              panelPaciente.Visible := true;
              lb_id_paciente.Text := 'ID: ' + camasid_paciente.AsString;
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
              lb_id_paciente.Text := '';

            end;
            1: begin
              panelPaciente.Visible := true;
              lb_id_paciente.Text := 'ID: ' + camasid_paciente.AsString;
              lb_apellido.Text := camasapellido_paciente.AsString;
              lb_nombre.Text   := camasnombre_paciente.AsString;
              lb_nro_documento.Text := camasdni.AsString;
              lb_cobertura.Text := camasfantasia.AsString;
              lb_plan.Text := camasplan.AsString;
              lb_nro_afiliado.Text := camasnro_afiliado.AsString;
              if camasfoto_paciente.AsString <> '' then
                foto.Base64(camasfoto_paciente.AsString)
              else
                foto.Base64(sin_foto);
            end;
            2:begin
              panelPaciente.Visible := true;
              lb_id_paciente.Text := 'ID: ' + camasid_paciente.AsString;
              lb_apellido.Text := camasapellido_paciente.AsString;
              lb_nombre.Text   := camasnombre_paciente.AsString;
              lb_nro_documento.Text := camasdni.AsString;
              lb_cobertura.Text := camasfantasia.AsString;
              lb_plan.Text := camasplan.AsString;
              lb_nro_afiliado.Text := camasnro_afiliado.AsString;
              if camasfoto_paciente.AsString <> '' then
                foto.Base64(camasfoto_paciente.AsString)
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
              lb_id_internacion.Text := 'ID: ' + camasid_internacion.AsString;
              panelInternacion.Visible := true;
              lb_ingreso_institucion.Text := camasfecha_ingreso_institucion.AsString;
              lb_ingreso_cama.Text := camasfecha_ingreso_cama.AsString;

              if camasfecha_alta_medica.AsString <> '' then
                begin
                  icono_alta_medica.Visible := true;
                  lb_fecha_alta_medica.Text := camasfecha_alta_medica.AsString;
                  lb_tipoAlta.Text := camastipo_alta_medica.AsString;
                  lb_altaProfesional.Text := camasprofesional_alta.AsString;
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
              lb_id_internacion.Text := 'ID: ' + camasid_internacion.AsString;
              panelInternacion.Visible := true;
              lb_ingreso_institucion.Text := camasfecha_ingreso_institucion.AsString;
              lb_ingreso_cama.Text := camasfecha_ingreso_cama.AsString;

              if camasfecha_alta_medica.AsString <> '' then
                begin
                  icono_alta_medica.Visible := true;
                  lb_fecha_alta_medica.Text := camasfecha_alta_medica.AsString;
                  lb_tipoAlta.Text := camastipo_alta_medica.AsString;
                  lb_altaProfesional.Text := camasprofesional_alta.AsString;
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
//          case permisoModulo(3) of
//            0: begin
//              panelAislamientos.Visible := false;
//            end;
//
//            1:begin
//              panelAislamientos.Visible := true;
//
//              //Aislamiento Precaución de Contacto (C)
//              if camasaislamiento_contacto.AsString <> '' then
//                begin
//                  lyAislamientoC.Visible := true;
//                  lb_fechaAislamientoC.Text := camasaislamiento_contacto.AsString;
//                  imgAislamientoC.Hint := 'Aislamiento Precaución de Contacto desde el ' + camasaislamiento_contacto.AsString;
//                end
//              else
//                begin
//                  lyAislamientoC.Visible := false;
//                  lb_fechaAislamientoC.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Gotas (G)
//              if camasaislamiento_gota_contacto.AsString <> '' then
//                begin
//                  lyAislamientoG.Visible := true;
//                  lb_fechaAislamientoG.Text := camasaislamiento_gota_contacto.AsString;
//                  imgAislamientoG.Hint := 'Aislamiento Precaución de Gotas desde el ' + camasaislamiento_gota_contacto.AsString;
//                end
//              else
//                begin
//                  lyAislamientoG.Visible := false;
//                  lb_fechaAislamientoG.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Aires (A)
//              if camasaislamiento_aire_respiratorio.AsString <> '' then
//                begin
//                  lyAislamientoA.Visible := true;
//                  lb_fechaAislamientoA.Text := camasaislamiento_aire_respiratorio.AsString;
//                  imgAislamientoA.Hint := 'Aislamiento Precaución de Aire desde el ' + camasaislamiento_aire_respiratorio.AsString;
//                end
//              else
//                begin
//                  lyAislamientoA.Visible := false;
//                  lb_fechaAislamientoA.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Proteccion (N)
//              if camasaislamiento_proteccion.AsString <> '' then
//                begin
//                  lyAislamientoN.Visible := true;
//                  lb_fechaAislamientoN.Text := camasaislamiento_proteccion.AsString;
//                  imgAislamientoN.Hint := 'Aislamiento Precauciones de Proteccion (Neutropénico) desde el ' + camasaislamiento_proteccion.AsString;
//                end
//              else
//                begin
//                  lyAislamientoN.Visible := false;
//                  lb_fechaAislamientoN.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Gotas y de Contacto (GC)
//              if camasaislamiento_gotas_contacto.AsString <> '' then
//                begin
//                  lyAislamientoGC.Visible := true;
//                  lb_fechaAislamientoGC.Text := camasaislamiento_gotas_contacto.AsString;
//                  imgAislamientoGC.Hint := 'Aislamiento Precaución de Gotas y de Contacto desde el ' + camasaislamiento_gotas_contacto.AsString;
//                end
//              else
//                begin
//                  lyAislamientoGC.Visible := false;
//                  lb_fechaAislamientoGC.Text := '';
//                end;
//
//              //Aislamiento Preventivo (P)
//              if camasaislamiento_preventivo.AsString <> '' then
//                begin
//                  lyAislamientoP.Visible := true;
//                  lb_fechaAislamientoP.Text := camasaislamiento_preventivo.AsString;
//                  imgAislamientoP.Hint := 'Aislamiento Preventivo desde el ' + camasaislamiento_preventivo.AsString;
//                end
//              else
//                begin
//                  lyAislamientoP.Visible := false;
//                  lb_fechaAislamientoP.Text := '';
//                end;
//            end;
//
//            2:begin
//              panelAislamientos.Visible := true;
//
//              //Aislamiento Precaución de Contacto (C)
//              if camasaislamiento_contacto.AsString <> '' then
//                begin
//                  lyAislamientoC.Visible := true;
//                  lb_fechaAislamientoC.Text := camasaislamiento_contacto.AsString;
//                  imgAislamientoC.Hint := 'Aislamiento Precaución de Contacto desde el ' + camasaislamiento_contacto.AsString;
//                end
//              else
//                begin
//                  lyAislamientoC.Visible := false;
//                  lb_fechaAislamientoC.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Gotas (G)
//              if camasaislamiento_gota_contacto.AsString <> '' then
//                begin
//                  lyAislamientoG.Visible := true;
//                  lb_fechaAislamientoG.Text := camasaislamiento_gota_contacto.AsString;
//                  imgAislamientoG.Hint := 'Aislamiento Precaución de Gotas desde el ' + camasaislamiento_gota_contacto.AsString;
//                end
//              else
//                begin
//                  lyAislamientoG.Visible := false;
//                  lb_fechaAislamientoG.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Aires (A)
//              if camasaislamiento_aire_respiratorio.AsString <> '' then
//                begin
//                  lyAislamientoA.Visible := true;
//                  lb_fechaAislamientoA.Text := camasaislamiento_aire_respiratorio.AsString;
//                  imgAislamientoA.Hint := 'Aislamiento Precaución de Aire desde el ' + camasaislamiento_aire_respiratorio.AsString;
//                end
//              else
//                begin
//                  lyAislamientoA.Visible := false;
//                  lb_fechaAislamientoA.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Proteccion (N)
//              if camasaislamiento_proteccion.AsString <> '' then
//                begin
//                  lyAislamientoN.Visible := true;
//                  lb_fechaAislamientoN.Text := camasaislamiento_proteccion.AsString;
//                  imgAislamientoN.Hint := 'Aislamiento Precauciones de Proteccion (Neutropénico) desde el ' + camasaislamiento_proteccion.AsString;
//                end
//              else
//                begin
//                  lyAislamientoN.Visible := false;
//                  lb_fechaAislamientoN.Text := '';
//                end;
//
//              //Aislamiento Precauciones de Gotas y de Contacto (GC)
//              if camasaislamiento_gotas_contacto.AsString <> '' then
//                begin
//                  lyAislamientoGC.Visible := true;
//                  lb_fechaAislamientoGC.Text := camasaislamiento_gotas_contacto.AsString;
//                  imgAislamientoGC.Hint := 'Aislamiento Precaución de Gotas y de Contacto desde el ' + camasaislamiento_gotas_contacto.AsString;
//                end
//              else
//                begin
//                  lyAislamientoGC.Visible := false;
//                  lb_fechaAislamientoGC.Text := '';
//                end;
//
//              //Aislamiento Preventivo (P)
//              if camasaislamiento_preventivo.AsString <> '' then
//                begin
//                  lyAislamientoP.Visible := true;
//                  lb_fechaAislamientoP.Text := camasaislamiento_preventivo.AsString;
//                  imgAislamientoP.Hint := 'Aislamiento Preventivo desde el ' + camasaislamiento_preventivo.AsString;
//                end
//              else
//                begin
//                  lyAislamientoP.Visible := false;
//                  lb_fechaAislamientoP.Text := '';
//                end;
//            end;
//          end;



          // ALERTAS MÉDICAS
          case permisoModulo(5) of
            0: begin
              lyAlertasMedicas.Visible := false;
            end;

            1: begin
              lyAlertasMedicas.Visible := true;
              // PROCEDIMIENTOS NO CUMPLIDOS
              recProcedimiento.Visible          := true;
              if camasprocedimientos_no_cumplidos.AsInteger > 0 then
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Red
              else
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Grey;

              lb_cantidad_procedimientos.Text := camasprocedimientos_no_cumplidos.AsString;

              // INDICACIONES NO PROGRAMADAS
              recMedicacionNoProgramada.Visible := true;
              if camasmedicacion_no_programada.AsInteger > 0 then
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Red
              else
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Grey;

              lb_indicaciones_no_programadas.Text := camasmedicacion_no_programada.AsString;

              // MEDICACION NO APLICADA
              recMedicacionNoAplicada.Visible   := true;
              if camasmedicacion_no_programada.AsInteger > 0 then
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Red
              else
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Grey;

              lb_medicacion_no_aplicada.Text := camasmedicacion_no_aplicada.AsString;
            end;

            2: begin
              lyAlertasMedicas.Visible := true;
              // PROCEDIMIENTOS NO CUMPLIDOS
              recProcedimiento.Visible          := true;
              if camasprocedimientos_no_cumplidos.AsInteger > 0 then
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Red
              else
                lb_cantidad_procedimientos.FontColor := TAlphaColorRec.Grey;

              lb_cantidad_procedimientos.Text := camasprocedimientos_no_cumplidos.AsString;

              // INDICACIONES NO PROGRAMADAS
              recMedicacionNoProgramada.Visible := true;
              if camasmedicacion_no_programada.AsInteger > 0 then
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Red
              else
                lb_indicaciones_no_programadas.FontColor := TAlphaColorRec.Grey;

              lb_indicaciones_no_programadas.Text := camasmedicacion_no_programada.AsString;

              // MEDICACION NO APLICADA
              recMedicacionNoAplicada.Visible   := true;
              if camasmedicacion_no_programada.AsInteger > 0 then
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Red
              else
                lb_medicacion_no_aplicada.FontColor := TAlphaColorRec.Grey;

              lb_medicacion_no_aplicada.Text := camasmedicacion_no_aplicada.AsString;
            end;
          end;



          // PANEL RESERVA
          recReserva.Visible := false;

          // PANEL CAMBIO DE CAMA
          case permisoModulo(4) of
            0: begin
              recCambioCama.Visible := false;
            end;

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

            2: begin
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

              rCambioCama.Visible := true;
            end;
          end;


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
          crearAlertas(id_cama,datos.servicio,datos.dniLogin);
        end;
    end
  else
    begin
      mensaje := camas.FieldByName('mensaje').AsString + #13 + #13 + 'Recurso: ' + apiRecurso + #13 + 'ID cama: ' + id_cama.ToString;
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString,mensaje,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_DetallesCama.ApagarAlertas(id_cama: integer);
var
  response : IResponse;
begin
  // marca como leidas todas las alertas de esta cama.
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('alertas/apagar')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_cama', id_cama.ToString)
              .AddParam('dni', datos.dniLogin)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(apagaralertastb))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR','No fue posible apagar las alertas de esta cama','Aceptar','ERROR',0);
    end;
end;

procedure Tform_DetallesCama.botonActualizarClick(Sender: TObject);
begin
  Actualizar(id_cama);
end;

procedure Tform_DetallesCama.botonAislamientosClick(Sender: TObject);
begin
  Application.CreateForm(TformAislamiento, formAislamiento);
  formAislamiento.Height := alto;
  formAislamiento.Width := ancho;
  formAislamiento.dniPaciente := camasdni.AsString;
  formAislamiento.ShowModal;
end;

procedure Tform_DetallesCama.botonCambioCamaClick(Sender: TObject);
begin
  if datos.gestionaCamas = 1 then // Ejemplo: Admisión
    begin
      Application.CreateForm(Tform_CambioCamaAdmision, form_CambioCamaAdmision);
      form_CambioCamaAdmision.Height := alto;
      form_CambioCamaAdmision.Width := ancho;
      form_CambioCamaAdmision.id_cama_origen := id_cama;
      form_CambioCamaAdmision.id_internacion := camasid_internacion.AsInteger;
      form_CambioCamaAdmision.ShowModal;
    end
  else
    begin
      Application.CreateForm(Tform_CambioDeCama, form_CambioDeCama);
      form_CambioDeCama.Height          := alto;
      form_CambioDeCama.Width           := ancho;
      form_CambioDeCama.id_cama_origen  := id_cama;
      form_CambioDeCama.id_internacion  := camasid_internacion.AsInteger;
      form_CambioDeCama.dni_paciente    := camasdni.AsString;
      form_CambioDeCama.id_paciente     := camasid_paciente.AsInteger;
      form_CambioDeCama.ShowModal;
    end;

  Actualizar(id_cama);
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
  ApagarAlertas(id_cama);
end;

procedure Tform_DetallesCama.FormCreate(Sender: TObject);
begin
  alto := form_DetallesCama.Height;
  ancho := form_DetallesCama.Width;
end;

procedure Tform_DetallesCama.obtenerPermisosModulosPaciente(id_servicio: integer);
var
  response: IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/aplicacion/permisosModulosPaciente')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_servicio', id_servicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(permisos))
              .Get;

  if response.StatusCode <> 200 then
    datos.VerMensaje('ERROR',response.Content,'Aceptar','ERROR',0);
end;

function Tform_DetallesCama.permisoModulo(id_modulo: integer): integer;
var
  res:integer;
begin
  permisos.Filtered := false;
  // filtro los permisos por el módulo que recibe como parámetro.
  if permisos.RecordCount > 0 then
    begin
      permisos.Filtered := false;
      permisos.Filter   := 'id_modulo = ' + id_modulo.ToString;
      permisos.Filtered := true;

      if permisos.RecordCount = 1 then
        begin
          if permisoscontrolTotal.AsInteger = 1 then
            res := 2 // control total
          else
          begin
            res := 1 // solo lectura
          end;
        end
      else
        res := 0;
    end
  else
    res := 0;

  permisoModulo := res;
end;

procedure Tform_DetallesCama.btn_AltaDefinitivaClick(Sender: TObject);
var
  mens:string;
  response: IResponse;
begin
  if camasfecha_alta_medica.AsString = '' then
    datos.VerMensaje('ACCIÓN NO PERMITIDA','El paciente no tiene el alta médica. No puede realizar el alta definitiva hasta que el médico haya hecho la epicrisis','Aceptar','ERROR',0)
  else
    begin
      response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('aplicacion/compararFechaHora')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('fecha', camasfecha_alta_medica.AsString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(fecha))
              .Get;

      if response.StatusCode = 200 then
        begin
          if fecharesultado.AsString = 'Posterior' then
            begin
              mens := 'No puede dar el alta al paciente antes de la fecha y hora indicada por el médico.' + #13 + #13 + 'Alta médica: ' + camasfecha_alta_medica.AsString + #13 + 'Fecha actual: ' + fechafecha_servidor.AsString;
              datos.VerMensaje('ACCIÓN NO PERMITIDA',mens,'Aceptar','ERROR',0);
            end
          else
            begin
                Application.CreateForm(Tform_AltaDefinitiva, form_AltaDefinitiva);
//                form_AltaDefinitiva.Height            := formTablero.Height;
//                form_AltaDefinitiva.Width             := formTablero.Width;
                form_AltaDefinitiva.Height            := alto;
                form_AltaDefinitiva.Width             := ancho;
                form_AltaDefinitiva.id_cama           := camasid_cama.AsInteger;
                form_AltaDefinitiva.apellido          := camasapellido_paciente.AsString;
                form_AltaDefinitiva.nombre            := camasnombre_paciente.AsString;
                form_AltaDefinitiva.dni               := camasdni.AsString;
                form_AltaDefinitiva.fechaAlta         := camasfecha_alta_medica.AsString;
                form_AltaDefinitiva.fechaIngresoCama  := camasfecha_ingreso_cama.AsString;
                form_AltaDefinitiva.tipoAlta          := camastipo_alta_medica.AsString;
                form_AltaDefinitiva.profesional       := camasprofesional_alta.AsString;
                form_AltaDefinitiva.soloAltaMedica    := camassoloAltaMedica.AsInteger;
                form_AltaDefinitiva.id_habitacion     := camasid_habitacion.AsInteger;
                form_AltaDefinitiva.Actualizar;
                form_AltaDefinitiva.showModal;
            end;
        end
      else
        begin
          datos.VerMensaje('ERROR ' + response.StatusCode.ToString,'No puede dar el alta al paciente antes de la fecha y hora indicada por el médico.','Aceptar','ERROR',0)
        end;

    end;
end;

end.
