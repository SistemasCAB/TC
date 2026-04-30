unit EnviarQuirofano_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.TabControl, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  Tform_EnviarQuirofano = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    Image3: TImage;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Label1: TLabel;
    lb_pacienteDatos: TLabel;
    lb_documento: TLabel;
    lb_paciente: TLabel;
    Label2: TLabel;
    Layout3: TLayout;
    recBotonEnviar: TRectangle;
    Label7: TLabel;
    botonReservar: TSpeedButton;
    Image1: TImage;
    swReservarCama: TSwitch;
    lb_reservaCama: TLabel;
    Label3: TLabel;
    listaCamas: TListView;
    camas: TFDMemTable;
    camasidCama: TIntegerField;
    camascama: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure botonSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActualizarCamas;
    procedure recBotonEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_EnviarQuirofano: Tform_EnviarQuirofano;

implementation

{$R *.fmx}

uses form_Tablero, ModuloDatos;

procedure Tform_EnviarQuirofano.ActualizarCamas;
var
  response: IResponse;
  recurso:string;
begin
  recurso := '/tablerocamas/camas';
  response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource(recurso)
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .AddParam('idServicio','7') // quirofano
                          .AddParam('tareasPendientes','0')
                          .AddParam('idEstado','1') // disponibles
                          .Accept('application/json')
                          .Adapters(TDataSetSerializeAdapter.New(camas))
                          .Get;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Ocurrió un error al intentar obtener las camas disponibles de Quirófano','Aceptar','ERROR',0);
    end;
end;

procedure Tform_EnviarQuirofano.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_EnviarQuirofano.FormCreate(Sender: TObject);
begin
  form_EnviarQuirofano.Height := formTablero.Height;
  form_EnviarQuirofano.Width  := formTablero.Width;

  ActualizarCamas;
end;

procedure Tform_EnviarQuirofano.recBotonEnviarClick(Sender: TObject);
var
  response : IResponse;
  recurso,body:String;
  json: TJSONObject;
begin
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

end.
