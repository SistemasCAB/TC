unit CambioDeCamaAdmision_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.StdCtrls, FMX.TabControl, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope,
  RESTRequest4D,DataSet.Serialize.Adapter.RESTRequest4D, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.DBScope;

type
  Tform_CambioCamaAdmision = class(TForm)
    Rectangle1: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    Layout1: TLayout;
    pagina: TTabControl;
    tabSeleccionarCama: TTabItem;
    Rectangle3: TRectangle;
    tabSolicitud: TTabItem;
    Rectangle2: TRectangle;
    Label4: TLabel;
    botonCambiarCama: TRectangle;
    Label7: TLabel;
    Label11: TLabel;
    SpeedButton2: TSpeedButton;
    botonCancelarCambio: TRectangle;
    Label9: TLabel;
    Label10: TLabel;
    SpeedButton3: TSpeedButton;
    lb_fecha_solicitud: TLabel;
    Label1: TLabel;
    lb_solicitado_por: TLabel;
    Label14: TLabel;
    lb_idSolicitud: TLabel;
    Label15: TLabel;
    lb_motivo: TLabel;
    rectCambioCama: TRectangle;
    CalloutPanel1: TCalloutPanel;
    lb_cama_origen: TLabel;
    Label28: TLabel;
    sombra: TShadowEffect;
    Label16: TLabel;
    lb_estadoSolicitud: TLabel;
    Label18: TLabel;
    lb_autorizadoFecha: TLabel;
    Label20: TLabel;
    lb_autorizadoNombre: TLabel;
    Label23: TLabel;
    Label3: TLabel;
    listaCamasDisponibles: TListView;
    Rectangle4: TRectangle;
    Label2: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    Rectangle5: TRectangle;
    Label6: TLabel;
    Label8: TLabel;
    SpeedButton4: TSpeedButton;
    tabOrden: TTabItem;
    TabItem2: TTabItem;
    Rectangle6: TRectangle;
    Label12: TLabel;
    Label13: TLabel;
    SpeedButton5: TSpeedButton;
    Rectangle7: TRectangle;
    botonSolicitar: TRectangle;
    Label17: TLabel;
    SpeedButton6: TSpeedButton;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Rectangle8: TRectangle;
    Label26: TLabel;
    SpeedButton7: TSpeedButton;
    Label27: TLabel;
    Label29: TLabel;
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
    lb_cama_destino: TLabel;
    FondoTransparente: TRectangle;
    solicitudtdocCodigo: TIntegerField;
    eliminarSolicitud: TFDMemTable;
    eliminarSolicitudestado: TIntegerField;
    eliminarSolicitudmensaje: TStringField;
    camasDisponibles: TFDMemTable;
    camasDisponiblesidCama: TIntegerField;
    camasDisponiblescama: TStringField;
    camasDisponiblesidHabitacion: TIntegerField;
    camasDisponiblespiso: TStringField;
    camasDisponiblestipoCama: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    autorizarCambio: TFDMemTable;
    autorizarCambioestado: TIntegerField;
    autorizarCambiomensaje: TStringField;
    procedure botonSalirClick(Sender: TObject);
    procedure botonSalirMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure botonSalirMouseLeave(Sender: TObject);
    procedure Actualizar;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure cancelarSolicitudCambio;
    procedure actualizarCamasDisponibles;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure autorizarCambioDeCama;
  private
    { Private declarations }
  public
    { Public declarations }
    idInternacion, idCamaOrigen : Integer;
  end;

var
  form_CambioCamaAdmision: Tform_CambioCamaAdmision;

implementation

{$R *.fmx}

uses ModuloDatos;

procedure Tform_CambioCamaAdmision.Actualizar;
var
  response : IResponse;
  recurso: string;
begin
  // Obtengo los datos de la solicitud de cambio de cama

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
          pagina.TabIndex := 1;
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

//              if solicitudid_estado_solicitud.AsInteger = 2 then
//                begin
//                  recBotonCambiarCama.Fill.Color := TAlphaColor(strtoint('$FF008795'));
//                  botonCambiarCama.Enabled := true;
//                end
//              else
//                begin
//                  recBotonCambiarCama.Fill.Color := TAlphaColorRec.Slategray;
//                  botonCambiarCama.Enabled := false;
//                end;

            end
          else
            begin
              lb_autorizadoNombre.Text := '';
              lb_autorizadoFecha.Text := '';
              lb_cama_destino.Text := '';
//              recBotonCambiarCama.Fill.Color := TAlphaColorRec.Slategray;
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
      Showmessage('Error ' + response.StatusCode.ToString + #13 + #13 + 'Ha ocurrido un error en la ejecución del método ' + recurso);
    end;
end;

procedure Tform_CambioCamaAdmision.actualizarCamasDisponibles;
var
  response: IResponse;
  recurso: string;
begin
  recurso := '/tablerocamas/camasDisponibles';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(camasDisponibles))
              .Get;

  if response.StatusCode = 200 then
    begin
      if camasDisponibles.RecordCount > 0 then
        begin
          pagina.TabIndex := 2;
          listaCamasDisponibles.Enabled := true;        
        end
      else
        begin
          pagina.TabIndex := 1;
          listaCamasDisponibles.Enabled := false;
          datos.VerMensaje('No hay camas disponibles','En este momento no hay camas disponibles','Aceptar','ERROR',0);        
        end;
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,'Ocurrió un error al consultar el método ' + recurso,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_CambioCamaAdmision.autorizarCambioDeCama;
var
  response: IResponse;
  recurso:string;
  body:string;
begin
  recurso := '/tablerocamas/autorizarCambioCama';
  body:= '';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(autorizarCambio))
              .Get;
               
  if response.StatusCode = 200 then
    begin
      datos.VerMensaje('Cambio de cama Autorizado','Se autorizó el cambio del paciente de la cama x a la z','Aceptar','OK',0);
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,'El método ' + recurso + ' respondió: ' + autorizarCambiomensaje.AsString,'Aceptar','ERROR',0);
    end;  
end;

procedure Tform_CambioCamaAdmision.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_CambioCamaAdmision.botonSalirMouseLeave(Sender: TObject);
begin
  botonSalir.FontColor := TAlphaColorRec.White;
end;

procedure Tform_CambioCamaAdmision.botonSalirMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  botonSalir.FontColor := TAlphaColorRec.Red;
end;

procedure Tform_CambioCamaAdmision.cancelarSolicitudCambio;
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
              'PREGUNTA',
              form_CambioCamaAdmision.Width,
              form_CambioCamaAdmision.Height);

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

procedure Tform_CambioCamaAdmision.FormActivate(Sender: TObject);
begin
  Actualizar;
end;

procedure Tform_CambioCamaAdmision.SpeedButton1Click(Sender: TObject);
begin
  autorizarCambioDeCama;
end;

procedure Tform_CambioCamaAdmision.SpeedButton2Click(Sender: TObject);
begin
  actualizarCamasDisponibles;
end;

procedure Tform_CambioCamaAdmision.SpeedButton3Click(Sender: TObject);
begin
  cancelarSolicitudCambio;
end;

end.
