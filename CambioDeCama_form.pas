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
    solicitudid_solicitud: TWideStringField;
    solicitudid_internacion: TWideStringField;
    solicitudid_paciente: TWideStringField;
    solicituddni_pacientes: TWideStringField;
    solicitudfecha: TWideStringField;
    solicitudid_cama_origen: TWideStringField;
    solicitudcama_origen: TWideStringField;
    solicitudid_cama_destino: TWideStringField;
    solicitudcama_destino: TWideStringField;
    solicitudid_motivo: TWideStringField;
    solicitudmotivo: TWideStringField;
    solicitudid_estado_solicitud: TWideStringField;
    solicitudestado: TWideStringField;
    solicitudsolicitado_por_dni: TWideStringField;
    solicitudsolicitado_por_nombre: TWideStringField;
    solicitudautorizado_fecha: TWideStringField;
    solicitudautorizado_por_dni: TWideStringField;
    solicitudautorizado_por_nombre: TWideStringField;
    solicitudrealizado_fecha: TWideStringField;
    solicitudrealizado_por_dni: TWideStringField;
    solicitudrealizado_por_nombre: TWideStringField;
    solicitudcancelado_fecha: TWideStringField;
    solicitudcancelado_por_dni: TWideStringField;
    solicitudcancelado_por_nombre: TWideStringField;
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
    motivosid_motivo: TIntegerField;
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
    id_cama_origen, id_internacion, id_paciente:integer;
    dni_paciente:string;
  end;

var
  form_CambioDeCama: Tform_CambioDeCama;

implementation

{$R *.fmx}

uses ModuloDatos, mensajeConfirmacion_form;

procedure Tform_CambioDeCama.Actualizar;
var
  response : IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/cambioCama/buscarSolicitud')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_internacion', id_internacion.ToString)
              .AddParam('id_cama_origen',id_cama_origen.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(solicitud))
              .Get;


  if response.StatusCode = 200 then
    begin
      if solicitud.RecordCount = 1 then
        begin
          // Hay una solicitud
          pagina.TabIndex := 2; // página para ver la solicitud actual.
          lb_idSolicitud.Text := solicitudid_solicitud.AsString;
          lb_fecha_solicitud.Text := solicitudfecha.AsString;
          lb_solicitado_por.Text := solicitudsolicitado_por_nombre.AsString;
          lb_cama_origen.Text := solicitudcama_origen.AsString;
          lb_estadoSolicitud.Text := solicitudestado.AsString;
          if (solicitudid_estado_solicitud.AsInteger = 1) or (solicitudid_estado_solicitud.AsInteger = 2) then
            begin
              lb_autorizadoNombre.Text := solicitudautorizado_por_nombre.AsString;
              lb_autorizadoFecha.Text := solicitudautorizado_fecha.AsString;
              lb_cama_destino.Text := solicitudcama_destino.AsString;

              if solicitudid_estado_solicitud.AsInteger = 2 then // solicitud autorizada
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
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método cambioCama/buscarSolicitud','Aceptar','ERROR',0);
    end;
end;

procedure Tform_CambioDeCama.ActualizarMotivos;
var
  Response: IResponse;
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/cambioCama/motivos')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              //.AddParam('ParameterName', 'ParameterValue')
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
              .Resource('/cambioCama/eliminarSolicitud')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_solicitudCambio', solicitudid_solicitud.AsString)
              .AddParam('dni',datos.dniLogin)
              .AddParam('nombreUsuario',datos.nombreLogin)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(eliminarSolicitud))
              .Post;

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
begin
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource('/cambioCama/nuevaSolicitud')
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('id_internacion', id_internacion.ToString)
              .AddParam('id_paciente', id_paciente.ToString)
              .AddParam('dni_paciente', dni_paciente)
              .AddParam('id_cama_origen', id_cama_origen.ToString)
              .AddParam('id_motivo', motivosid_motivo.AsString)
              .AddParam('solicitado_por_dni', datos.dniLogin)
              .AddParam('solicitado_por_nombre', datos.nombreLogin)
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
              .AddParam('id_solicitudCambio', solicitudid_solicitud.AsString)
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
