unit Reservas_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ListBox, FMX.Edit,
  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON;

type
  // Primero declarás la clase auxiliar
  TComboItem = class
  public
    ID: Integer;
    Descripcion: string;
  end;

type
  Tform_Reservas = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    pagina: TTabControl;
    TabVerReserva: TTabItem;
    TabReservar: TTabItem;
    recBotonEliminar: TRectangle;
    Label1: TLabel;
    botonEliminar: TSpeedButton;
    Image2: TImage;
    recBotonReservar: TRectangle;
    Label7: TLabel;
    botonReservar: TSpeedButton;
    Image1: TImage;
    botonSalir: TSpeedButton;
    Image3: TImage;
    Label2: TLabel;
    lb_paciente: TLabel;
    lb_documento: TLabel;
    recBotonBusarPaciente: TRectangle;
    botonBuscarPaciente: TSpeedButton;
    Image4: TImage;
    pacientes: TFDMemTable;
    pacientespaciCodigo: TIntegerField;
    pacientesapellido: TStringField;
    pacientesnombre: TStringField;
    pacientesfechaNacimiento: TStringField;
    pacientespersSexo: TStringField;
    pacientessexo: TStringField;
    pacientestdocCodigo: TIntegerField;
    pacientestdocDescripcion: TStringField;
    pacientesnroDocumento: TStringField;
    panelBuscarPaciente: TRectangle;
    numeroDocumento: TEdit;
    listaTiposDocumentos: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    recBuscar: TRectangle;
    btnBuscarPaciente: TSpeedButton;
    Image5: TImage;
    Label5: TLabel;
    lb_pacienteDatos: TLabel;
    documentos: TFDMemTable;
    documentostdocCodigo: TIntegerField;
    documentostdocDescripcion: TStringField;
    Label6: TLabel;
    Label8: TLabel;
    edt_motivo: TEdit;
    resultadoReserva: TFDMemTable;
    resultadoReservaestado: TIntegerField;
    resultadoReservamensaje: TStringField;
    Label9: TLabel;
    lb_reservaPaciente: TLabel;
    lb_reservaDocumento: TLabel;
    lb_usuario: TLabel;
    Label11: TLabel;
    lb_usuarioDocumento: TLabel;
    lb_fechaReserva: TLabel;
    etiquetaEstado: TRectangle;
    reserva: TFDMemTable;
    reservaidReserva: TIntegerField;
    reservaidCama: TIntegerField;
    reservafechaReserva: TStringField;
    reservatdocCodigo: TIntegerField;
    reservanroDocumento: TStringField;
    reservanombrePaciente: TStringField;
    reservareservadaPorDni: TStringField;
    reservareservadaPorNombre: TStringField;
    reservafechaCancelada: TStringField;
    reservacanceladaPorDni: TStringField;
    reservacanceladaPorNombre: TStringField;
    reservaidMotivoFinReserva: TIntegerField;
    reservaidSolicitudCambio: TIntegerField;
    resultadoCancelar: TFDMemTable;
    resultadoCancelarestado: TIntegerField;
    resultadoCancelarmensaje: TStringField;
    reservamotivo: TStringField;
    reservatdocDescripcion: TStringField;
    lb_motivo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure botonSalirClick(Sender: TObject);
    procedure ActualizaTiposDocumentos;
    procedure CargarComboBox;
    procedure LiberarItemsCombo;
    procedure listaTiposDocumentosChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBuscarPacienteClick(Sender: TObject);
    procedure botonBuscarPacienteClick(Sender: TObject);
    procedure crearReserva;
    procedure botonReservarClick(Sender: TObject);
    procedure Actualizar;
    procedure FormActivate(Sender: TObject);
    procedure botonEliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idCama: Integer;
    tdocCodigo: integer;
    nroDocumento: string;
    nombrePaciente: string;

  end;

var
  form_Reservas: Tform_Reservas;

implementation

{$R *.fmx}

uses form_Tablero, ModuloDatos, DetallesCama_form, UFunciones;

procedure Tform_Reservas.Actualizar;
var
  response: IResponse;
  recurso: string;
begin
  recurso := '/tablerocamas/reservas';
  response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource(recurso)
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .Accept('application/json')
                          .AddParam('idCama', idCama.ToString)
                          .Adapters(TDataSetSerializeAdapter.New(reserva))
                          .Get;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Ocurrió un error al intentar obtener los datos de la reserva','Aceptar','ERROR',0);
    end
  else
    begin
      if(reserva.RecordCount = 0) then // no hay reservas para esta cama
        begin
          pagina.TabIndex := 0;
        end
      else // hay una reserva para esta cama
        begin
          pagina.TabIndex := 1;

          lb_reservaPaciente.Text     := reservanombrePaciente.AsString;
          lb_reservaDocumento.Text    := reservatdocDescripcion.AsString + ': ' + reservanroDocumento.AsString;
          lb_fechaReserva.Text        := 'Fecha: ' + Copy(reservafechaReserva.AsString,1,16);
          lb_motivo.Text              := 'Motivo: '+reservamotivo.AsString;

          lb_usuario.Text             := reservareservadaPorNombre.AsString;
          lb_usuarioDocumento.Text    := 'DNI: ' + reservareservadaPorDni.AsString;


          etiquetaEstado.Fill.Color := TAlphaColor(StrToAlphaColor('#00ffff'));
        end;
    end;



end;

procedure Tform_Reservas.ActualizaTiposDocumentos;
var
  response : IResponse;
  recurso : String;
begin
  recurso := '/tablerocamas/tiposDocumentos';
  response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource(recurso)
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .Accept('application/json')
                          .Adapters(TDataSetSerializeAdapter.New(documentos))
                          .Get;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Ocurrió un error al intentar obtener los tipos de documentos','Aceptar','ERROR',0);
    end
  else
    begin
      CargarComboBox;
    end;
end;

procedure Tform_Reservas.botonBuscarPacienteClick(Sender: TObject);
begin
  recBotonReservar.Enabled := false;
  panelBuscarPaciente.Height := 200;
  panelBuscarPaciente.Visible := true;
  panelBuscarPaciente.BringToFront;
end;

procedure Tform_Reservas.botonReservarClick(Sender: TObject);
begin
  crearReserva;
end;

procedure Tform_Reservas.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_Reservas.CargarComboBox;
var
  Item: TComboItem;
begin
  listaTiposDocumentos.Items.Clear;
  documentos.First;
  while not documentos.Eof do
  begin
    // Crear un objeto nuevo para este registro
    Item := TComboItem.Create;
    // Copiar los datos del registro al objeto
    Item.ID          := documentostdocCodigo.AsInteger;
    Item.Descripcion := documentostdocDescripcion.AsString;
    // Agregar al ComboBox: el texto visible + el objeto adjunto
    listaTiposDocumentos.Items.AddObject(Item.Descripcion, Item);
    documentos.Next;
  end;
end;

procedure Tform_Reservas.crearReserva;
var
  response: IResponse;
  recurso,body:string;
  json: TJSONObject;
  mensajeError:string;
begin
  if(tdocCodigo = 0) or (nroDocumento = '') or (nombrePaciente = '') or (edt_motivo.Text = '') then
    begin
      mensajeError := 'Datos obligatorios:' +#13+ '- Tipo de documento'+#13+'- Número de documento'+#13+'- Nombre y apellido del paciente'+#13+'- Motivo de la reserva';
      datos.VerMensaje('Faltan datos obligatorios.' ,mensajeError,'Aceptar','ERROR',0);
      Exit;
    end;

  json := TJSONObject.Create;
  try
    json.AddPair('idCama', TJSONNumber.Create(idCama));
    json.AddPair('tdocCodigo', TJSONNumber.Create(tdocCodigo));
    json.AddPair('nroDocumento', nroDocumento);
    json.AddPair('nombrePaciente', nombrePaciente);
    json.AddPair('motivo', edt_motivo.Text);
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    json.AddPair('idAplicacion',TJSONNumber.Create(datos.idAplicacion));
    body := json.ToJSON;
  finally
    json.Free;
  end;

  recurso := '/tablerocamas/reservas';
  response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource(recurso)
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .AddBody(body)
                          .Accept('application/json')
                          .Adapters(TDataSetSerializeAdapter.New(resultadoReserva))
                          .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Error: ' + resultadoReservamensaje.AsString,'Aceptar','ERROR',0);
    end
  else
    begin
      form_DetallesCama.Actualizar(idCama);
      datos.VerMensaje('CAMA RESEVADA' ,resultadoReservamensaje.AsString,'Aceptar','OK',0);
      Actualizar;
      pagina.TabIndex:= 1;
    end;
end;

procedure Tform_Reservas.FormActivate(Sender: TObject);
begin
  Actualizar;
end;

procedure Tform_Reservas.FormCreate(Sender: TObject);
begin
  form_Reservas.Height := formTablero.Height;
  form_Reservas.Width := formTablero.Width;

  ActualizaTiposDocumentos;

  tdocCodigo := 0;
end;

procedure Tform_Reservas.FormDestroy(Sender: TObject);
begin
  LiberarItemsCombo;
end;

procedure Tform_Reservas.LiberarItemsCombo;
var
  i: Integer;
begin
  for i := 0 to listaTiposDocumentos.Items.Count - 1 do
  begin
    // Liberar cada objeto adjunto
    listaTiposDocumentos.Items.Objects[i].Free;
  end;
  listaTiposDocumentos.Items.Clear;
end;

procedure Tform_Reservas.listaTiposDocumentosChange(Sender: TObject);
var
  ItemSeleccionado: TComboItem;
begin
  // Verificar que haya algo seleccionado
  if listaTiposDocumentos.ItemIndex < 0 then
    Exit; // No hay nada seleccionado, salir
  // Recuperar el objeto adjunto al ítem seleccionado
  // El cast (TComboItem) es necesario porque Items.Objects devuelve TObject
  ItemSeleccionado := TComboItem(listaTiposDocumentos.Items.Objects[listaTiposDocumentos.ItemIndex]);
//  ShowMessage('ID seleccionado: ' + ItemSeleccionado.ID.ToString);
//  ShowMessage('Descripción: '     + ItemSeleccionado.Descripcion);
  tdocCodigo := ItemSeleccionado.ID;
  recBuscar.Enabled := true;
end;

procedure Tform_Reservas.botonEliminarClick(Sender: TObject);
var
  response : IResponse;
  recurso, body, mensaje:String;
  json: TJSONObject;
begin
  if reservaidSolicitudCambio.AsInteger > 0 then
    begin
      mensaje:= '¿Está seguro que desea eliminar esta reserva de cama?' + #13 + #13 + 'Al hacerlo se cancelará la solicitud de cambio de cama correspondiente';
    end
  else
    begin
      mensaje:= '¿Está seguro que desea eliminar esta reserva de cama?';
    end;


  if datos.MensajeConfirmacion('Confirme su decisión',mensaje,'Si. Estoy seguro','No eliminar','WARNING',form_Reservas.Width,form_Reservas.Height) = 6 then
    begin
      json := TJSONObject.Create;
      try
        json.AddPair('idReserva', TJSONNumber.Create(reservaidReserva.AsInteger));
        json.AddPair('idMotivo', TJSONNumber.Create(1)); // Cancelada por el usuario
        json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
        json.AddPair('idAplicacion',TJSONNumber.Create(datos.idAplicacion));
        json.AddPair('idServicio',TJSONNumber.Create(datos.servicio));
        body := json.ToJSON;
      finally
        json.Free;
      end;

      recurso := '/tablerocamas/reservas';
      response := TRequest.New.BaseURL(datos.urlTC)
                              .Resource(recurso)
                              .AddHeader('TokenAcceso', datos.tokenAcceso)
                              .AddBody(body)
                              .Accept('application/json')
                              .Adapters(TDataSetSerializeAdapter.New(resultadoCancelar))
                              .Patch;

      if response.StatusCode = 200 then
        begin
          //showmessage(resultadoCancelarmensaje.AsString);

          form_DetallesCama.Actualizar(idCama);
          datos.VerMensaje('RESERVA CANCELADA' ,resultadoCancelarmensaje.AsString,'Aceptar','OK',0);
          Close;
        end
      else
        begin
          datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Error: ' + resultadoCancelarmensaje.AsString,'Aceptar','ERROR',0);
        end;

    end;
end;

procedure Tform_Reservas.btnBuscarPacienteClick(Sender: TObject);
var
  response : IResponse;
  recurso  : String;
begin
  if(tdocCodigo = 0) and (numeroDocumento.Text = '') then
    begin
      datos.VerMensaje('ERROR','Debe seleccionar un tipo de documento e ingresar un número de documento antes de iniciar la búsqueda','ACEPTAR','ERROR',0);
      Exit;
    end;

  recurso := '/tablerocamas/paciente';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('tdocCodigo', tdocCodigo.ToString)
              .AddParam('nroDocumento',numeroDocumento.Text)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(pacientes))
              .Get;

  if response.StatusCode <> 200 then
    begin
       datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método ' + recurso,'Aceptar','ERROR',0);
       Exit;
    end;

  if pacientes.RecordCount <> 1 then
    begin
      datos.VerMensaje('Paciente no encontrado ','No se encontró en Markey un paciente con los datos ingresados','Aceptar','ERROR',0);
      Exit;
    end;

  lb_paciente.Text := pacientesapellido.AsString + ', ' + pacientesnombre.AsString;
  lb_documento.Text := pacientestdocDescripcion.AsString + ': ' + pacientesnroDocumento.AsString;
  lb_pacienteDatos.Text := 'Fecha de nacimiento: '+ pacientesfechaNacimiento.AsString +'    Sexo: ' + pacientessexo.AsString;

  tdocCodigo := pacientestdocCodigo.AsInteger;
  nroDocumento := pacientesnroDocumento.AsString;
  nombrePaciente := pacientesapellido.AsString + ', ' + pacientesnombre.AsString;

  recBotonReservar.Enabled := true;

  panelBuscarPaciente.Visible := false;
  panelBuscarPaciente.Height := 5;
  panelBuscarPaciente.SendToBack;
end;

end.
