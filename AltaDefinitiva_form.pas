unit AltaDefinitiva_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Effects, FMX.StdCtrls, FMX.ListView, FMX.TabControl, FMX.Layouts,
  FMX.Controls.Presentation, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListBox,
  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.Win.ADODB, FMX.Edit,
  DateTimeMaskEdit_unit;

type
  Tform_AltaDefinitiva = class(TForm)
    FondoTransparente: TRectangle;
    formulario: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    lyDatosAlta: TLayout;
    panelPaciente: TRectangle;
    ShadowEffect2: TShadowEffect;
    lbTituloApellido: TLabel;
    lb_apellido: TLabel;
    lbTituloNombre: TLabel;
    lbTituloDocumento: TLabel;
    lb_nroDocumento: TLabel;
    Rectangle2: TRectangle;
    lb_tituloPaciente: TLabel;
    lb_nombre: TLabel;
    panelIndicacion: TRectangle;
    ShadowEffect4: TShadowEffect;
    lb_fechaAltaMedica: TLabel;
    Rectangle3: TRectangle;
    lb_tituloInternacion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lb_tipoAlta: TLabel;
    botonAlta: TRectangle;
    Label4: TLabel;
    btnAltaDefinitiva: TSpeedButton;
    alta: TFDMemTable;
    altaestado: TStringField;
    altamensaje: TStringField;
    Label3: TLabel;
    lb_profesionalAlta: TLabel;
    resultadoActualizacion: TFDMemTable;
    resultadoActualizacionestado: TIntegerField;
    resultadoActualizacionmensaje: TStringField;
    botonCancelar: TRectangle;
    Image14: TImage;
    Label33: TLabel;
    btn_AltaDefinitiva: TSpeedButton;
    Image1: TImage;
    Label5: TLabel;
    lbFormato: TLabel;
    procedure btnAltaDefinitivaClick(Sender: TObject);
    procedure ActualizarCamasMarkey;
    procedure Actualizar;
    procedure FormCreate(Sender: TObject);
    procedure btn_AltaDefinitivaClick(Sender: TObject);
  private
    { Private declarations }
    EditFechaHora: TDateTimeMaskEdit;
  public
    { Public declarations }
    idCama,soloAltaMedica,id_habitacion, idTipoAltaMedica, idInternacion,paciCodigo:integer;
    apellido,nombre,dni,fechaAlta,fechaIngresoCama,tipoAlta, profesional, fechaAltaEfectiva:string;
    ancho, alto:integer;
  end;

var
  form_AltaDefinitiva: Tform_AltaDefinitiva;


implementation

{$R *.fmx}

uses ModuloDatos, DetallesCama_form;

{ Tform_AltaDefinitiva }

procedure Tform_AltaDefinitiva.Actualizar;
begin
  lb_apellido.Text        := apellido;
  lb_nombre.Text          := nombre;
  lb_nroDocumento.Text    := dni;
  lb_fechaAltaMedica.Text := fechaAlta;
  lb_tipoAlta.Text        := tipoAlta;
  lb_profesionalAlta.Text := profesional;
end;

procedure Tform_AltaDefinitiva.ActualizarCamasMarkey;
var
  response: IResponse;
  distintos: integer;
  recurso: string;
begin
  // Llamo a la api de Markey para obtener todas las camas y actualizar la tabla CAB.dbo.camasMarkey

  recurso := '/tablerocamas/actualizarCamasMarkey';
  response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource(recurso)
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .Accept('application/json')
                          .Get;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Ocurrió un error al intentar actualizar las camas desde Markey al servidor de la CAB','Ok','ERROR',0);
    end;
end;

procedure Tform_AltaDefinitiva.btnAltaDefinitivaClick(Sender: TObject);
var
  response:IResponse;
  apiRecurso,body:string;
  url,mensaje:string;
  dt:TDateTime;
begin
  // ejecuto el alta en Markey, luego de la confirmación del usuario.


  {
    Consideraciones respecto a la fecha y hora de alta:
   Si la cama en la que está el paciente es una cama soloAltaMedica (virtuales para alta médica), entonces la fecha de egreso
   debe ser la fecha en la que el paciente ingresó a la cama actual.
   Si es otra cama, la fecha de egreso será la fecha y hora será la que ingresó el enfermero.
  }

  mensaje := '¿Está seguro que desea dar el alta a esta paciente?' + #13 + 'Al hacerlo esta internación se cerrará y no podrá registrar nada más en la historia clínica.';

  if datos.MensajeConfirmacion('Confirme su decisión', mensaje,'Si, dar el alta','No','PREGUNTA', ancho, alto) = 6 then
    begin
      // 1) Obtengo la fecha y hora del alta.
      dt := EditFechaHora.GetDateTime;
      fechaAltaEfectiva := FormatDateTime('yyyy-mm-dd hh:nn:ss', dt);

      if soloAltaMedica = 1 then // es una cama soloAltaMedica
        begin
          if strtodatetime(fechaIngresoCama) < dt then
            fechaAltaEfectiva := fechaIngresoCama
          else
            fechaAltaEfectiva := FormatDateTime('yyyy-mm-dd hh:nn:ss', dt);
        end;


      // 2) Doy el alta en Markey y en las tablas locales del tablero (todo lo hace este método AltaDefinitiva de la api)

      apiRecurso := '/tablerocamas/altaDefinitiva';
      body := '{'+
              '"idCama":'+idCama.ToString+','+
              '"idHabitacion":'+id_habitacion.ToString+','+
              '"idInternacion":'+form_DetallesCama.camasidInternacion.AsString+','+
              '"paciCodigo":'+paciCodigo.ToString+','+
              '"fechaAltaDefinitiva":"'+fechaAltaEfectiva+'",'+
              '"dni":"'+datos.dniLogin+'",'+
              '"nombreUsuario":"'+datos.nombreLogin+'",'+
              '"idServicio":'+datos.servicio.ToString+''+
              '}';
      response := TRequest.New.BaseURL(datos.urlTC)
                           .Resource(apiRecurso)
                           .AddHeader('TokenAcceso', datos.tokenAcceso)
                           .AddBody(body)
                           .Accept('application/json')
                           .Adapters(TDataSetSerializeAdapter.New(alta))
                           .Post;

      if response.StatusCode = 200 then
        begin
          datos.VerMensaje('ALTA EXITOSA',altamensaje.AsString,'Aceptar','OK',0);

          form_DetallesCama.Cerrar;
          Close;
        end
      else
        begin
          datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,altamensaje.AsString,'Aceptar','ERROR',0);
        end;
    end;
end;

procedure Tform_AltaDefinitiva.btn_AltaDefinitivaClick(Sender: TObject);
begin
   Close;
end;

procedure Tform_AltaDefinitiva.FormCreate(Sender: TObject);
begin
  alto := form_DetallesCama.Height;
  ancho := form_DetallesCama.Width;

  EditFechaHora := TDateTimeMaskEdit.Create(Self);
  EditFechaHora.Parent := LyDatosAlta;
  EditFechaHora.Position.X := 377;
  EditFechaHora.Position.Y := 216;
  EditFechaHora.Width := 130;
  EditFechaHora.StyledSettings := [];
  EditFechaHora.TextSettings.Font.Size := 14;
  EditFechaHora.TextSettings.Font.Style := [TFontStyle.fsBold];
end;

end.
