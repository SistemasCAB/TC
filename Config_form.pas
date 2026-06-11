unit Config_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.TabControl,RESTRequest4D,DataSet.Serialize.Adapter.RESTRequest4D, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TComboItem = class
  public
    ID: Integer;
    Descripcion: string;
  end;

type
  Tform_Config = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    contenedorPrincipal: TLayout;
    pagina: TTabControl;
    tabServicios: TTabItem;
    contenedorTabServicios: TLayout;
    Layout5: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    recQuitarCama: TRectangle;
    Label8: TLabel;
    botonQuitarCama: TSpeedButton;
    recAgregarCama: TRectangle;
    Label11: TLabel;
    botonAgregarCama: TSpeedButton;
    listaCamasServicio: TListBox;
    listaCamasDisponibles: TListBox;
    Layout9: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    tabAlertas: TTabItem;
    Layout2: TLayout;
    Layout11: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    recBotonQuitarAlerta: TRectangle;
    Label15: TLabel;
    BotonQuitarAlerta: TSpeedButton;
    recBotonAgregarAlerta: TRectangle;
    Label16: TLabel;
    BotonAgregarAlerta: TSpeedButton;
    listaAlertasServicio: TListBox;
    Layout15: TLayout;
    Label17: TLabel;
    Label18: TLabel;
    listaAlertasDisponibles: TListBox;
    tabPermisos: TTabItem;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout10: TLayout;
    Layout16: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Rectangle3: TRectangle;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Layout17: TLayout;
    Label4: TLabel;
    ListBox1: TListBox;
    recTitulo: TRectangle;
    lbTitulo: TLabel;
    botonSalir: TSpeedButton;
    Image3: TImage;
    Layout12: TLayout;
    Label12: TLabel;
    comboServicios: TComboBox;
    servicios: TFDMemTable;
    serviciosidServicio: TIntegerField;
    serviciosnombreServicio: TStringField;
    serviciosidTipoInternacion: TIntegerField;
    servicioscambioCamaAreaCerrada: TIntegerField;
    serviciosgestionaCama: TIntegerField;
    serviciostareasPendientes: TIntegerField;
    camasServicio: TFDMemTable;
    camasServicioidCama: TIntegerField;
    camasServiciocama: TStringField;
    camasServicioidHabitacion: TIntegerField;
    camasServiciohabitacion: TStringField;
    camasServiciotipoCama: TStringField;
    camasServiciopiso: TStringField;
    camasServiciosoloAltaMedica: TIntegerField;
    camasDisponiblesServicio: TFDMemTable;
    camasDisponiblesServicioidCama: TIntegerField;
    camasDisponiblesServiciocama: TStringField;
    camasDisponiblesServicioidHabitacion: TIntegerField;
    camasDisponiblesServiciohabitacion: TStringField;
    camasDisponiblesServiciopiso: TStringField;
    camasDisponiblesServiciotipoCama: TStringField;
    camasDisponiblesServiciosoloAltaMedica: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure ActualizarServicios;
    procedure cargarComboServicios;
    procedure botonSalirClick(Sender: TObject);
    procedure comboServiciosChange(Sender: TObject);
    procedure actualizarDatos(idServicio: integer);
    procedure obtenerCamasServicio(idservicio: integer);
  private
    { Private declarations }
  public
    { Public declarations }
    idServicioSeleccionado: integer;
  end;

var
  form_Config: Tform_Config;

implementation

{$R *.fmx}

uses ModuloDatos;

procedure Tform_Config.actualizarDatos(idServicio: integer);
begin
// obtengo los datos relacionados a este servicio: camas, alertas, permisos


  obtenerCamasServicio(idServicio);

end;

procedure Tform_Config.ActualizarServicios;
var
  response :IResponse;
  recurso :string;
begin
  recurso := '/tablerocamas/servicios';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(servicios))
              .Get;

  if response.StatusCode = 200 then
    begin
      cargarComboServicios;
    end
  else
    begin
      datos.VerMensaje('Error',servicios.Fields[1].AsString  ,'Aceptar','error',0)
    end;
end;

procedure Tform_Config.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_Config.cargarComboServicios;
var
  Item: TComboItem;
begin
  comboServicios.Items.Clear;
  servicios.First;
  while not servicios.Eof do
  begin
    // Crear un objeto nuevo para este registro
    Item := TComboItem.Create;
    // Copiar los datos del registro al objeto
    Item.ID          := serviciosidServicio.asInteger;
    Item.Descripcion := serviciosnombreServicio.AsString;
    // Agregar al ComboBox: el texto visible + el objeto adjunto
    comboServicios.Items.AddObject(Item.Descripcion, Item);
    servicios.Next;
  end;
end;

procedure Tform_Config.comboServiciosChange(Sender: TObject);
var
  ItemSeleccionado: TComboItem;
begin
  // Verificar que haya algo seleccionado
  if comboServicios.ItemIndex < 0 then
    Exit; // No hay nada seleccionado, salir
  // Recuperar el objeto adjunto al ítem seleccionado
  // El cast (TComboItem) es necesario porque Items.Objects devuelve TObject
  ItemSeleccionado := TComboItem(comboServicios.Items.Objects[comboServicios.ItemIndex]);
  idServicioSeleccionado := ItemSeleccionado.ID;

  actualizarDatos(idServicioSeleccionado);
end;

procedure Tform_Config.FormCreate(Sender: TObject);
begin
  lbTitulo.Text := 'CONFIGURACIÓN -> ' + pagina.Tabs[0].Text;
  ActualizarServicios;
end;

procedure Tform_Config.obtenerCamasServicio(idservicio: integer);
var
  response : IResponse;
  recurso : string;
begin
  // CAMAS ATENDIDAS
  recurso := '/tablerocamas/camas';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio',idServicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(camasServicio))
              .Get;

  if camasServicio.RecordCount > 0 then
    begin
      recQuitarCama.Enabled := true;
    end
  else
    begin
      recQuitarCama.Enabled := false;
    end;


  // CAMAS DISPONIBLES
  recurso := '/tablerocamas/camasNoAtendidasServicio';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio',idServicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(camasDisponiblesServicio))
              .Get;

  if camasDisponiblesServicio.RecordCount > 0 then
    begin
      recAgregarCama.Enabled := true;
    end
  else
    begin
      recAgregarCama.Enabled := false;
    end;
end;

end.
