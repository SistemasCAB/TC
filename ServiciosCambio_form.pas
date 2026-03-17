unit ServiciosCambio_form;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  REST.Types,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  REST.Response.Adapter,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  System.Rtti,
  System.Bindings.Outputs,
  Fmx.Bind.Editors,
  Data.Bind.EngExt,
  Fmx.Bind.DBEngExt,
  Data.Bind.DBScope,
  Inifiles, FMX.Effects,
  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D;

type
  Tform_ServiciosCambio = class(TForm)
    Rectangle1: TRectangle;
    recTitulo: TRectangle;
    lbTitulo: TLabel;
    SpeedButton1: TSpeedButton;
    listaServicios: TListView;
    ShadowEffect1: TShadowEffect;
    FondoTransparente: TRectangle;
    servicios: TFDMemTable;
    serviciosidServicio: TIntegerField;
    serviciosnombreServicio: TStringField;
    serviciosidTipoInternacion: TIntegerField;
    servicioscambioCamaAreaCerrada: TIntegerField;
    serviciosgestionaCamas: TIntegerField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure listaServiciosItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ActualizarServicios;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_ServiciosCambio: Tform_ServiciosCambio;

implementation

{$R *.fmx}

uses ModuloDatos, form_Tablero;

procedure Tform_ServiciosCambio.ActualizarServicios;
var
  response: IResponse;
  apiRecurso:string;
  e:boolean;
begin
  // Obtengo los servicios
  apiRecurso := '/tablerocamas/servicios';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(servicios))
              .Get;

  if response.StatusCode = 200 then
    begin
      e:= servicios.Locate('idServicio',datos.servicio,[]);
      listaServicios.Enabled := true;
    end
  else
    begin
      listaServicios.Enabled := false;
      datos.VerMensaje('Error ' + response.StatusCode.ToString, 'El endpoint ' + datos.urlTC + apiRecurso + ' ha retornado el status code ' + response.StatusCode.ToString ,'Aceptar','error',0)
    end;
end;

procedure Tform_ServiciosCambio.FormActivate(Sender: TObject);
var
  e:boolean;
begin

  ActualizarServicios;
end;

procedure Tform_ServiciosCambio.listaServiciosItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  archivo :TInifile;
begin
  archivo := TIniFile.Create('c:\tc\config.ini');
  archivo.WriteInteger('TABLERO','servicio',serviciosidServicio.AsInteger);
  archivo.Free;
  datos.actualizarConfiguracion; // vuelvo a leer los datos del archivo de configuración
  formTablero.ActualizarServicio;
  formTablero.ActualizarCamas;
  Close;
end;

procedure Tform_ServiciosCambio.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

end.
