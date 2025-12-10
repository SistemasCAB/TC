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
  Data.Bind.ObjectScope;

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
    ListView1: TListView;
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
    solicitudCli: TRESTClient;
    solicitudReq: TRESTRequest;
    solicitudRes: TRESTResponse;
    solicitudDSA: TRESTResponseDataSetAdapter;
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
    lb_cama_destino: TLabel;
    FondoTransparente: TRectangle;
    procedure botonSalirClick(Sender: TObject);
    procedure botonSalirMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure botonSalirMouseLeave(Sender: TObject);
    procedure Actualizar;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id_internacion, id_cama_origen : Integer;
  end;

var
  form_CambioCamaAdmision: Tform_CambioCamaAdmision;

implementation

{$R *.fmx}

uses ModuloDatos;

procedure Tform_CambioCamaAdmision.Actualizar;
begin
  // Obtengo los datos de la cama
  solicitudCli.BaseURL                                        := datos.urlTC;
  solicitudReq.Resource                                       := 'cambioCama/buscarSolicitud';
  solicitudReq.Params.ParameterByName('TokenAcceso').Value    := datos.tokenAcceso;
  solicitudReq.Params.ParameterByName('id_internacion').Value := id_internacion.ToString;
  solicitudReq.Params.ParameterByName('id_cama_origen').Value := id_cama_origen.ToString;
  solicitudReq.Execute;

  if solicitudRes.StatusCode = 200 then
    begin
      if solicitud.RecordCount = 1 then
        begin
          // Hay una solicitud
          pagina.TabIndex := 1;
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
      Showmessage('Error ' + solicitudRes.StatusCode.ToString + #13 + #13 + 'Ha ocurrido un error en la ejecución del método ' + solicitudReq.Resource);
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

procedure Tform_CambioCamaAdmision.FormActivate(Sender: TObject);
begin
  Actualizar;
end;

end.
