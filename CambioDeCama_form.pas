unit CambioDeCama_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.TabControl, FMX.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView,

  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.DBScope;

type
  Tform_CambioDeCama = class(TForm)
    Rectangle1: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    pagina: TTabControl;
    tabSolicitar: TTabItem;
    tabSolicitud: TTabItem;
    Layout1: TLayout;
    Rectangle3: TRectangle;
    iconoVentana: TImage;
    Label3: TLabel;
    Label5: TLabel;
    botonSolicitar: TRectangle;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    Rectangle2: TRectangle;
    Label4: TLabel;
    recBotonCambiarCama: TRectangle;
    Label7: TLabel;
    botonCambiarCama: TSpeedButton;
    botonCancelarCambio: TRectangle;
    btn_CancelarSolicitudCambio: TSpeedButton;
    Label9: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lb_fecha_solicitud: TLabel;
    Label1: TLabel;
    lb_solicitado_por: TLabel;
    Label14: TLabel;
    lb_idSolicitud: TLabel;
    Label15: TLabel;
    lb_motivo: TLabel;
    botonSalir: TSpeedButton;
    rectCambioCama: TRectangle;
    CalloutPanel1: TCalloutPanel;
    lb_cama_origen: TLabel;
    Label28: TLabel;
    Label16: TLabel;
    lb_estadoSolicitud: TLabel;
    Label18: TLabel;
    lb_autorizadoFecha: TLabel;
    Label20: TLabel;
    lb_autorizadoNombre: TLabel;
    Label23: TLabel;
    lb_cama_destino: TLabel;
    sombra: TShadowEffect;
    Rectangle4: TRectangle;
    Label2: TLabel;
    SpeedButton4: TSpeedButton;
    Label12: TLabel;
    Label13: TLabel;
    solicitud: TFDMemTable;
    solicitudidSolicitud: TWideStringField;
    solicitudidInternacion: TWideStringField;
    solicitudpaciCodigo: TWideStringField;
    solicitudnroDocumento: TWideStringField;
    solicitudfecha: TWideStringField;
    solicitudidCamaOrigen: TWideStringField;
    solicitudcamaOrigen: TWideStringField;
    solicitudidCamaDestino: TWideStringField;
    solicitudcamaDestino: TWideStringField;
    solicitudidMotivo: TWideStringField;
    solicitudmotivo: TWideStringField;
    solicitudidEstadoSolicitud: TWideStringField;
    solicitudestado: TWideStringField;
    solicitudsolicitadoPorDni: TWideStringField;
    solicitudsolicitadoPorNombre: TWideStringField;
    solicitudautorizadoFecha: TWideStringField;
    solicitudautorizadoPorDni: TWideStringField;
    solicitudautorizadoPorNombre: TWideStringField;
    solicitudrealizadoFecha: TWideStringField;
    solicitudrealizadoPorDni: TWideStringField;
    solicitudrealizadoPorNombre: TWideStringField;
    solicitudcanceladoFecha: TWideStringField;
    solicitudcanceladoPorDni: TWideStringField;
    solicitudcanceladoPorNombre: TWideStringField;
    FondoTransparente: TRectangle;
    lyCambioACamaVirtual: TLayout;
    Label17: TLabel;
    tabMotivosCambio: TTabItem;
    Rectangle5: TRectangle;
    Label19: TLabel;
    listaMotivos: TListView;
    botonFinalizarNuevaSolicitud: TRectangle;
    Label21: TLabel;
    Label22: TLabel;
    btn_NuevaSolicitud: TSpeedButton;
    Rectangle7: TRectangle;
    Label24: TLabel;
    Label25: TLabel;
    SpeedButton5: TSpeedButton;
    tabCambioVirtual: TTabItem;
    motivos: TFDMemTable;
    motivosidMotivoCambioCama: TIntegerField;
    motivosmotivo: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    eliminarSolicitud: TFDMemTable;
    eliminarSolicitudestado: TIntegerField;
    eliminarSolicitudmensaje: TStringField;
    nuevaSolicitud: TFDMemTable;
    nuevaSolicitudmensaje: TStringField;
    nuevaSolicitudid_solicitud: TIntegerField;
    motivosactivo: TIntegerField;
    procedure botonSalirClick(Sender: TObject);
    procedure Actualizar;
    procedure botonSalirMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure botonSalirMouseLeave(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActualizarMotivos;
    procedure FormCreate(Sender: TObject);
    procedure btn_CancelarSolicitudCambioClick(Sender: TObject);
    procedure botonCambiarCamaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure crearSolicitudCambio;
    procedure cancelarSolicitudCambio;
    procedure listaMotivosItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btn_NuevaSolicitudClick(Sender: TObject);
    procedure RegistrarCambioDeCama;
  private
    { Private declarations }
  public
    { Public declarations }
    idCamaOrigen, idInternacion, tdocCodigo, paciCodigo:integer;
    nroDocumento:string;
  end;

var
  form_CambioDeCama: Tform_CambioDeCama;

implementation

{$R *.fmx}

uses ModuloDatos, mensajeConfirmacion_form;

procedure Tform_CambioDeCama.Actualizar;
var
  response : IResponse;
  recurso: string;
begin
  recurso := '/tablerocamas/buscarSolicitudCambioCama';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idInternacion', idInternacion.ToString)
              .AddParam('idCamaOrigen',idCamaOrigen.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(solicitud))
              .Get;


  if response.StatusCode = 200 then
    begin
      if solicitud.RecordCount = 1 then
        begin
          // Hay una solicitud
          pagina.TabIndex := 2; // página para ver la solicitud actual.
          lb_idSolicitud.Text := solicitudidSolicitud.AsString;
          lb_fecha_solicitud.Text := solicitudfecha.AsString;
          lb_solicitado_por.Text := solicitudsolicitadoPorNombre.AsString;
          lb_cama_origen.Text := solicitudcamaOrigen.AsString;
          lb_estadoSolicitud.Text := solicitudestado.AsString;
          if (solicitudidEstadoSolicitud.AsInteger = 1) or (solicitudidEstadoSolicitud.AsInteger = 2) then
            begin
              lb_autorizadoNombre.Text := solicitudautorizadoPorNombre.AsString;
              lb_autorizadoFecha.Text := solicitudautorizadoFecha.AsString;
              lb_cama_destino.Text := solicitudcamaDestino.AsString;

              if solicitudidEstadoSolicitud.AsInteger = 2 then // solicitud autorizada
                begin
                  recBotonCambiarCama.Fill.Color := TAlphaColor(strtoint('$FF008795'));
                  botonCambiarCama.Enabled := true;
                end
              else
                begin
                  recBotonCambiarCama.Fill.Color := TAlphaColorRec.Slategray;
                  botonCambiarCama.Enabled := false;
                end;

            end
          else
            begin
              lb_autorizadoNombre.Text := '';
              lb_autorizadoFecha.Text := '';
              lb_cama_destino.Text := '';
              recBotonCambiarCama.Fill.Color := TAlphaColorRec.Slategray;
              botonCambiarCama.Enabled := false;
            end;

          lb_motivo.Text := solicitudmotivo.AsString;
        end
      else
        begin
          // No hay una solicitud
          pagina.TabIndex := 0;
        end;
    end
  else
    begin
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método ' + recurso,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_CambioDeCama.ActualizarMotivos;
var
  Response: IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/tablerocamas/motivosCambioCama')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(motivos))
              .Get;
end;

procedure Tform_CambioDeCama.botonCambiarCamaClick(Sender: TObject);
begin
  RegistrarCambioDeCama;
end;

procedure Tform_CambioDeCama.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_CambioDeCama.botonSalirMouseLeave(Sender: TObject);
begin
  botonSalir.FontColor := TAlphaColorRec.White;
end;

procedure Tform_CambioDeCama.botonSalirMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Single);
begin
  botonSalir.FontColor := TAlphaColorRec.Red;
end;

procedure Tform_CambioDeCama.btn_CancelarSolicitudCambioClick(Sender: TObject);
begin
  cancelarSolicitudCambio;
end;

procedure Tform_CambioDeCama.btn_NuevaSolicitudClick(Sender: TObject);
begin
  crearSolicitudCambio;
end;

procedure Tform_CambioDeCama.cancelarSolicitudCambio;
var
  Response: IResponse;
  mens:string;
  resMod:integer;
begin

  resMod := datos.MensajeConfirmacion(
              'Eliminar Solicitud de Cambio de Cama',
              '¿Está seguro que desea eliminar esta solicitud de cambio de cama?',
              'Si. Eliminar',
              'No eliminar',
              'WARNING',
              form_CambioDeCama.Width,
              form_CambioDeCama.Height);

  if(resMod = 6)  then // 6 = mrYes
    begin
        response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/tablerocamas/cambioCamaEliminarSolicitud')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idSolicitudCambio', solicitudidSolicitud.AsString)
              .AddParam('dni',datos.dniLogin)
              .AddParam('nombreUsuario',datos.nombreLogin)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(eliminarSolicitud))
              .Delete;

        mens := eliminarSolicitudmensaje.AsString;

        if response.StatusCode = 200 then
          datos.VerMensaje('Solicitud de Cambio de Cama',mens,'Aceptar','OK',0)
        else
          datos.VerMensaje('Error ' + response.StatusCode.ToString ,mens,'Aceptar','ERROR',0);

        Actualizar;
    end;

end;

procedure Tform_CambioDeCama.crearSolicitudCambio;
var
  response: IResponse;
  body: String;
begin
  body := '{ '+
              '"idInternacion":'+idInternacion.ToString +','+
              '"paciCodigo":'+paciCodigo.ToString +','+
              '"tdocCodigo":'+tdocCodigo.ToString +','+
              '"nroDocumento":"'+ nroDocumento +'",'+
              '"idCamaOrigen":'+ idCamaOrigen.ToString +','+
              '"idMotivo":'+ motivosidMotivoCambioCama.AsString +','+
              '"solicitadoPorDni":"'+ datos.dniLogin +'",'+
              '"solicitadoPorNombre":"'+ datos.nombreLogin +'"'+
          '}';

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/tablerocamas/cambioCamaCrearSolicitud')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(nuevaSolicitud))
              .Post;

  if response.StatusCode = 200 then
    begin
      datos.VerMensaje('Solicitud enviada',nuevaSolicitudmensaje.AsString,'Aceptar','OK',0);
      Close;
    end
  else
    begin
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString,nuevaSolicitudmensaje.AsString,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_CambioDeCama.FormActivate(Sender: TObject);
begin
  Actualizar;
end;

procedure Tform_CambioDeCama.FormCreate(Sender: TObject);
begin
  ActualizarMotivos;
end;

procedure Tform_CambioDeCama.listaMotivosItemClick(const Sender: TObject;  const AItem: TListViewItem);
begin
  botonFinalizarNuevaSolicitud.Enabled := true;
end;

procedure Tform_CambioDeCama.RegistrarCambioDeCama;
var
  response: IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/cambioCama/eliminarSolicitud')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_solicitudCambio', solicitudidSolicitud.AsString)
              .AddParam('dni',datos.dniLogin)
              .AddParam('nombreUsuario',datos.nombreLogin)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(eliminarSolicitud))
              .Post;
end;

procedure Tform_CambioDeCama.SpeedButton1Click(Sender: TObject);
begin
  pagina.TabIndex := 1;
end;

procedure Tform_CambioDeCama.SpeedButton5Click(Sender: TObject);
begin
    pagina.TabIndex := 0;
end;

end.
