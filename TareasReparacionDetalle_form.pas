unit TareasReparacionDetalle_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON,
  WinAPI.ShellAPI, WinAPI.Windows;

type
  Tform_TareasReparacionDetalle = class(TForm)
    FondoTransparente: TRectangle;
    Rectangle1: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    lyBotones: TLayout;
    recBotonCancelarTarea: TRectangle;
    lb_botonCancelarTarea: TLabel;
    botonCancelarTarea: TSpeedButton;
    Image1: TImage;
    separador1: TLayout;
    ly_Tareas: TLayout;
    lyCabeceraTarea: TLayout;
    lbTicket: TLabel;
    Label1: TLabel;
    tarea: TFDMemTable;
    tareaidTarea: TIntegerField;
    tareafecha: TStringField;
    tareaidCama: TIntegerField;
    tareacama: TStringField;
    tareahabitacion: TStringField;
    tareapiso: TStringField;
    tareacamaEnAislamiento: TIntegerField;
    tareaestadoCama: TStringField;
    tareasexoPaciente: TStringField;
    tareasolicitadaPorDni: TStringField;
    tareasolicitadaPorNombre: TStringField;
    tareaidServicioSolicita: TIntegerField;
    tareanombreServicio: TStringField;
    tareainiciada: TStringField;
    tareainiciadaPorDni: TStringField;
    tareainiciadaPorNombre: TStringField;
    tareacancelada: TStringField;
    tareacanceladaPorDni: TStringField;
    tareacanceladaPorNombre: TStringField;
    tareaidEstadoTareas: TIntegerField;
    tareaestado: TStringField;
    tareaidReparacion: TIntegerField;
    tareareparacion: TStringField;
    tareaidCategoria: TIntegerField;
    tareacategoria: TStringField;
    tareainhabilitaHab: TIntegerField;
    tarealimpiezaPosterior: TIntegerField;
    tareabloqueaCama: TIntegerField;
    tareaidPrioridad: TIntegerField;
    tareaprioridad: TStringField;
    tareaticket: TIntegerField;
    tareadetalleTicket: TMemoField;
    lb_reparacion: TLabel;
    Label2: TLabel;
    lb_ServicioOrigen: TLabel;
    Label3: TLabel;
    lb_prioridad: TLabel;
    Label4: TLabel;
    lb_estado: TLabel;
    Label6: TLabel;
    lb_creada: TLabel;
    lb_creadaPorNombre: TLabel;
    Label8: TLabel;
    detalles: TFDMemTable;
    recBotonTicket: TRectangle;
    lb_BotonTicket: TLabel;
    botonTicket: TSpeedButton;
    Image2: TImage;
    detallesdetalle: TMemoField;
    detallesusuario: TStringField;
    detallesid_detalle: TIntegerField;
    detallesfecha: TDateTimeField;
    recDetalle: TRectangle;
    contenedor: TScrollBox;
    lb_tituloDetalle: TLabel;
    lb_textoDetalle: TLabel;
    Label5: TLabel;
    Layout1: TLayout;
    Label7: TLabel;
    tareaurlRecibido: TStringField;
    tareaurlEnviado: TStringField;
    cancelar: TFDMemTable;
    cancelarestado: TIntegerField;
    cancelarmensaje: TStringField;
    botonSalir: TSpeedButton;
    Image3: TImage;
    procedure FormActivate(Sender: TObject);
    procedure ActualizarTarea(idTarea:integer);
    procedure CargarDetallesDesdeJson(const JsonStr: string; detalles: TFDMemTable);
    procedure MostrarDetalles;
    procedure FormCreate(Sender: TObject);
    procedure botonCancelarTareaClick(Sender: TObject);
    procedure botonTicketClick(Sender: TObject);
    procedure botonSalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idTarea :integer;
    ancho, alto:integer;
  end;

var
  form_TareasReparacionDetalle: Tform_TareasReparacionDetalle;

implementation

{$R *.fmx}

uses ModuloDatos, TareasReparacion_form;

procedure Tform_TareasReparacionDetalle.ActualizarTarea(idTarea: integer);
var
  response: IResponse;
  recurso: String;
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  detalleArray: TJSONArray;
begin
  recurso := '/tablerocamas/tareasCama/' + idTarea.ToString;
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso )
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              //.AddParam('idTarea',idTarea.ToString) // reemplaza {idTarea} en la URL
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(tarea))
              .Get;

  if response.StatusCode = 200 then
    begin
      lbTicket.Text := 'Ticket Nº ' + tareaticket.AsString + ' - Cama: ' + tareacama.AsString + ' - Categoría: ' + tareacategoria.AsString;
      lb_reparacion.Text := tareareparacion.AsString;
      lb_prioridad.Text := tareaprioridad.AsString;
      lb_estado.Text := uppercase(tareaestado.AsString);
      lb_servicioOrigen.Text := tareanombreServicio.AsString;
      lb_creada.Text := tareafecha.AsString;
      lb_creadaPorNombre.Text := 'DNI: '+ tareasolicitadaPorDni.AsString +' - ' + tareasolicitadaPorNombre.AsString;

      // detalles del ticket
      JsonValue := TJSONObject.ParseJSONValue(response.Content);

      JsonArray := JsonValue as TJSONArray;
      JsonObj := JsonArray.Items[0] as TJSONObject;

      detalleArray := JsonObj.GetValue<TJSONArray>('detalleTicket');

      CargarDetallesDesdeJson(detalleArray.ToJSON, detalles);
      MostrarDetalles;
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,'No fue posible obtener esta tarea.' + #13 + 'Endpoint: ' + recurso,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_TareasReparacionDetalle.botonCancelarTareaClick(Sender: TObject);
var
  mensaje : string;
  response : IResponse;
  body, recurso: string;
begin
  mensaje:= '¿Está seguro que desea cancelar esta tarea de reparación?';
  if datos.MensajeConfirmacion('Confirme su decisión',mensaje,'Si. Estoy seguro','No. Salir','WARNING',ancho,alto) = 6 then
    begin
      recurso := '/tablerocamas/tareaIniciarFinalizarCancelar';
      body := '{'+
                  '"idTarea":'+ tareaidTarea.AsString +','+
                  '"idUsuario":1,'+
                  '"idServicio":'+datos.servicio.ToString +','+
                  '"accion":"cancelar"'+
              '}';

      response := TRequest.New.BaseURL(datos.urlTC)
                  .Resource(recurso )
                  .AddHeader('TokenAcceso', datos.tokenAcceso)
                  .AddBody(body)
                  .Accept('application/json')
                  .Adapters(TDataSetSerializeAdapter.New(cancelar))
                  .Post;

      if response.StatusCode = 200 then
        begin
          formTareasReparacion.ObtenerTareas;
          Close;
        end
      else
        begin
          datos.VerMensaje('Error ' + response.StatusCode.ToString ,'No fue posible cancelar esta tarea.' + #13 + 'Endpoint: ' + recurso+ 'Error: ' + cancelarmensaje.AsString,'Aceptar','ERROR',0);
        end;
    end;

end;

procedure Tform_TareasReparacionDetalle.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_TareasReparacionDetalle.botonTicketClick(Sender: TObject);
var
  url : PWideChar;
begin
  if datos.servicio = 2 then // si es el servicio mantenimiento
    url := PWideChar(tareaurlRecibido.AsString)
  else
    url := PWideChar(tareaurlEnviado.AsString);

  ShellExecute(0, 'open', url, nil, nil, SW_SHOWNORMAL);
  Close;
end;

procedure Tform_TareasReparacionDetalle.CargarDetallesDesdeJson(const JsonStr: string; detalles: TFDMemTable);
var
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  I: Integer;
  dtFecha: TDateTime;
  fs: TFormatSettings;

begin
  detalles.DisableControls;
  try
    detalles.Close;
    detalles.Open;
    detalles.EmptyDataSet;

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

        detalles.Append;

        fs := TFormatSettings.Create;
        fs.DateSeparator    := '-';
        fs.TimeSeparator    := ':';
        fs.ShortDateFormat  := 'yyyy-mm-dd';
        fs.ShortTimeFormat  := 'hh:nn:ss';
        dtFecha := StrToDateTime(JsonObj.GetValue<string>('fecha'), fs);
        detalles.FieldByName('fecha').AsDateTime := dtFecha;


        detalles.FieldByName('detalle').AsString := JsonObj.GetValue<string>('detalle');
        detalles.FieldByName('usuario').AsString := JsonObj.GetValue<string>('usuario');
        detalles.FieldByName('id_detalle').AsInteger := JsonObj.GetValue<Integer>('id_detalle');

        detalles.Post;
      end;
    finally
      JsonArray.Free;
    end;

  finally
    detalles.EnableControls;
  end;
end;

procedure Tform_TareasReparacionDetalle.FormActivate(Sender: TObject);
begin
  tituloVentana.Text := 'DETALLE DE TAREA Nº ' + idTarea.ToString;
  ActualizarTarea(idTarea);
end;

procedure Tform_TareasReparacionDetalle.FormCreate(Sender: TObject);
begin
  alto := formTareasReparacion.Height;
  ancho := formTareasReparacion.Width;
end;

procedure Tform_TareasReparacionDetalle.MostrarDetalles;
var
  separador: TLayout;
  lbTitulo, lbDetalleTicket: TLabel;
begin
  if Assigned(contenedor) then
      FreeAndNil(contenedor);

  contenedor := TScrollBox.Create(Self);
  contenedor.Parent := recDetalle;
  contenedor.Name := 'contenedor';
  contenedor.Align := TAlignLayout.Client;

  detalles.First;
  repeat
    // titulo del detalle
    lbTitulo := TLabel.Create(Self);
    with lbTitulo do
      begin
        Parent := contenedor;
        Height := 17;
        Align := TAlignLayout.Top;
        Name := 'lbTituloDetalle'+ detallesid_detalle.AsString;
        StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
        Text := 'El ' + Copy(detallesfecha.AsString,1,10) + ' a las ' + Copy(detallesfecha.AsString,12,5) +' '+ detallesusuario.AsString + ' dijo:';
      end;

    // texto del detalle
    lbDetalleTicket := TLabel.Create(Self);
    with lbDetalleTicket do
      begin
        Parent := contenedor;
        Height := 17;
        Align := TAlignLayout.Top;
        Name := 'lbTextoDetalle'+ detallesid_detalle.AsString;
        StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        //TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
        TextSettings.WordWrap := true;
        AutoSize := true;
        Text := detallesdetalle.AsString;
      end;

    // separador
    separador := TLayout.Create(Self);
    separador.Parent := contenedor;
    separador.Name := 'separador' + detallesid_detalle.AsString;
    separador.Align := TAlignLayout.Top;
    separador.Height := 17;

    detalles.Next;
  until detalles.Eof;

end;

end.
