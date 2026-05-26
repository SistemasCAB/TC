unit AltaProbable_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.DateTimeCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.TabControl, JSON;

type
  TformAltaProbable = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    altas: TFDMemTable;
    altasidTipoAltaMedica: TIntegerField;
    altastipoAltaMedica: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    resultado: TFDMemTable;
    resultadoestado: TIntegerField;
    resultadomensaje: TStringField;
    botonSalir: TSpeedButton;
    Image3: TImage;
    pagina: TTabControl;
    tabVer: TTabItem;
    tabEditar: TTabItem;
    Label14: TLabel;
    lb_cama: TLabel;
    Label4: TLabel;
    lb_paciente: TLabel;
    Label1: TLabel;
    lb_documento: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    fecha: TDateEdit;
    hora: TTimeEdit;
    Label5: TLabel;
    listaAltas: TListView;
    botonAceptar: TRectangle;
    Label7: TLabel;
    btnAceptar: TSpeedButton;
    Image1: TImage;
    Label6: TLabel;
    lb_editarCama: TLabel;
    Label9: TLabel;
    lb_editarPaciente: TLabel;
    Label11: TLabel;
    lb_editarDocumento: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    lb_editarFechaAlta: TLabel;
    lb_editarTipoAlta: TLabel;
    Rectangle1: TRectangle;
    Label20: TLabel;
    botonEditar: TSpeedButton;
    Image2: TImage;
    Label8: TLabel;
    lb_editarCreadoPor: TLabel;
    lb_editarCreadoFecha: TLabel;
    Label12: TLabel;
    recBotonEliminar: TRectangle;
    Label10: TLabel;
    botonEliminar: TSpeedButton;
    Image4: TImage;
    altaProbable: TFDMemTable;
    altaProbableidInternacion: TIntegerField;
    altaProbableidTipoAltaProbable: TIntegerField;
    altaProbabletipoAltaProbable: TStringField;
    altaProbablecreadoPorDni: TStringField;
    altaProbablecreadoPorNombre: TStringField;
    altaProbablefechaAltaProbable: TStringField;
    altaProbablecreadoFecha: TStringField;
    LinkListControlToField1: TLinkListControlToField;
    procedure ActualizarAltasMedicas;
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure botonSalirClick(Sender: TObject);
    procedure botonEliminarClick(Sender: TObject);
    procedure EliminarAltaProbable;
    procedure botonEditarClick(Sender: TObject);
    procedure actualizarAltaProbable;
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    idInternacion :Integer;
    idCama:integer;
    cama:string;
  end;

var
  formAltaProbable: TformAltaProbable;

implementation

{$R *.fmx}

uses ModuloDatos, form_Tablero, DetallesCama_form;

{ TformAltaProbable }

procedure TformAltaProbable.actualizarAltaProbable;
var
  response: IResponse;
  recurso: string;
begin
  recurso := 'tablerocamas/altaProbable';

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idInternacion',idInternacion.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(altaProbable))
              .Get;

  if altaProbable.RecordCount = 1 then
    begin
      pagina.TabIndex           := 0;
      lb_editarCama.Text        := cama;
      lb_editarPaciente.Text    := lb_paciente.Text;
      lb_editarDocumento.Text   := lb_documento.Text;
      lb_editarFechaAlta.Text   := altaProbablefechaAltaProbable.AsString;
      lb_editartipoAlta.Text    := altaProbabletipoAltaProbable.AsString;
      lb_editarCreadoPor.Text   := altaProbablecreadoPorDni.AsString + ' - ' + altaProbablecreadoPorNombre.AsString;
      lb_editarCreadoFecha.Text := altaProbablecreadoFecha.AsString;
    end
  else
    begin
      pagina.TabIndex := 1;
    end;
end;

procedure TformAltaProbable.ActualizarAltasMedicas;
var
  response: IResponse;
  recurso: String;
begin
  recurso := '/tablerocamas/tiposAltasMedicas';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(altas))
              .Get;

  if response.StatusCode <> 200 then
    begin
       datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método ' + recurso,'Aceptar','ERROR',0);
    end;
end;

procedure TformAltaProbable.botonEditarClick(Sender: TObject);
begin
  pagina.TabIndex := 1;
end;

procedure TformAltaProbable.botonEliminarClick(Sender: TObject);
begin
  if datos.MensajeConfirmacion('Confirme su decisión','¿Estás seguro que queres eliminar el alta probable del paciente?','Si. Estoy seguro','No eliminar','WARNING',formTablero.Width,formTablero.Height) = 6 then
    begin
      EliminarAltaProbable;
    end;
end;

procedure TformAltaProbable.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TformAltaProbable.btnAceptarClick(Sender: TObject);
var
  response: IResponse;
  recurso, body: String;
  fec:string;
  dt:TDateTime;
begin
  recurso := '/tablerocamas/altaProbable';

  dt := fecha.Date + hora.Time;
  fec := FormatDateTime('yyyy-mm-dd hh:nn:ss', dt);

  body := '{'+
            '"idInternacion":'+ idInternacion.ToString +','+
            '"fechaAltaProbable":"'+ fec +'",'+
            '"idTipoAltaMedica":'+ altasidTipoAltaMedica.AsString +','+
            '"creadoPorDni":"'+ datos.dniLogin +'",'+
            '"creadoPorNombre":"'+ datos.nombreLogin +'"'+
          '}';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Post;

  case response.StatusCode of
    200: begin
      datos.VerMensaje('ALTA PROBABLE GRABADA' ,resultadomensaje.AsString,'Aceptar','OK',0);
       form_DetallesCama.Actualizar(idCama);
       Close;
    end;
    422: begin
        datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,resultadomensaje.AsString,'Aceptar','ERROR',0);
    end;
    else
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método ' + recurso + #13 + resultadomensaje.AsString,'Aceptar','ERROR',0);
  end;
end;

procedure TformAltaProbable.EliminarAltaProbable;
var
  response : IResponse;
  recurso, body: String;
  json : TJSONObject;
begin
  recurso := '/tablerocamas/altaProbable';

  json := TJSONObject.Create;
  try
    json.AddPair('idInternacion', TJSONNumber.Create(idInternacion));
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    json.AddPair('idAplicacion', TJSONNumber.Create(datos.idAplicacion));
    json.AddPair('idServicio', TJSONNumber.Create(datos.servicio));
    body := json.ToJSON;
  finally
    json.Free;
  end;


  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Delete;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método DELETE: ' + recurso + #13 + resultadomensaje.AsString,'Aceptar','ERROR',0);
    end
  else
    begin
      datos.VerMensaje('ALTA PROBABLE',resultadomensaje.AsString,'Aceptar','OK',0);
      form_DetallesCama.Actualizar(idCama);
      Close;
    end;
end;

procedure TformAltaProbable.FormActivate(Sender: TObject);
begin
  actualizarAltaProbable;
end;

procedure TformAltaProbable.FormCreate(Sender: TObject);
begin
  formAltaProbable.Height := formTablero.Height;
  formAltaProbable.Width := formTablero.Width;

  ActualizarAltasMedicas;
end;

end.
