unit Configuracion_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.StdCtrls, FMX.Effects, FMX.Controls.Presentation,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.DBScope,
  FMX.ListBox, FMX.Edit,
  RESTRequest4D,DataSet.Serialize.Adapter.RESTRequest4D, System.JSON,
  System.ImageList, FMX.ImgList;

type
  TComboItem = class
  public
    ID: Integer;
    Descripcion: string;
  end;

type
  Tform_Configuracion = class(TForm)
    FORMULARIO: TRectangle;
    contenedorPrincipal: TLayout;
    recTitulo: TRectangle;
    lbTitulo: TLabel;
    pagina: TTabControl;
    tabServicios: TTabItem;
    tabAlertas: TTabItem;
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
    botonSalir: TSpeedButton;
    Image3: TImage;
    FondoTransparente: TRectangle;
    servicios: TFDMemTable;
    serviciosidServicio: TIntegerField;
    serviciosnombreServicio: TStringField;
    serviciosidTipoInternacion: TIntegerField;
    servicioscambioCamaAreaCerrada: TIntegerField;
    serviciosgestionaCama: TIntegerField;
    serviciostareasPendientes: TIntegerField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    camasServicio: TFDMemTable;
    camasServicioidCama: TIntegerField;
    camasServiciocama: TStringField;
    camasServicioidHabitacion: TIntegerField;
    camasServiciohabitacion: TStringField;
    camasServiciotipoCama: TStringField;
    camasServiciopiso: TStringField;
    camasServiciosoloAltaMedica: TIntegerField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    camasDisponiblesServicio: TFDMemTable;
    camasDisponiblesServicioidCama: TIntegerField;
    camasDisponiblesServiciocama: TStringField;
    camasDisponiblesServicioidHabitacion: TIntegerField;
    camasDisponiblesServiciohabitacion: TStringField;
    camasDisponiblesServiciopiso: TStringField;
    camasDisponiblesServiciotipoCama: TStringField;
    camasDisponiblesServiciosoloAltaMedica: TIntegerField;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    resultados: TFDMemTable;
    resultadosestado: TIntegerField;
    resultadosmensaje: TStringField;
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
    alertasServicio: TFDMemTable;
    alertasDisponibles: TFDMemTable;
    alertasDisponiblesidTipoAlerta: TIntegerField;
    alertasDisponiblestipoAlerta: TStringField;
    alertasDisponiblesdescripcion: TStringField;
    alertasServicioidServicio: TIntegerField;
    alertasServicioidTipoAlerta: TIntegerField;
    alertasServiciotipoAlerta: TStringField;
    alertasServiciodescripcion: TStringField;
    BindSourceDB4: TBindSourceDB;
    LinkListControlToField4: TLinkListControlToField;
    BindSourceDB5: TBindSourceDB;
    LinkListControlToField5: TLinkListControlToField;
    tabPermisos: TTabItem;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout10: TLayout;
    Layout17: TLayout;
    Label4: TLabel;
    permisosServicio: TFDMemTable;
    permisosServicioidPermiso: TIntegerField;
    permisosServicioidServicio: TIntegerField;
    permisosServicionombreServicio: TStringField;
    permisosServicioidModulo: TIntegerField;
    permisosServicionombreModulo: TStringField;
    permisosServiciodescripcionModulo: TStringField;
    permisosServiciocontrolTotal: TIntegerField;
    Layout12: TLayout;
    Label12: TLabel;
    comboServicios: TComboBox;
    modulosTablero: TFDMemTable;
    modulosTableroidModulo: TIntegerField;
    modulosTableronombreModulo: TStringField;
    modulosTablerodescripcion: TStringField;
    modulosTablerocontrolTotal: TIntegerField;
    modulosTableropermiso: TStringField;
    modulosTableronombreServicio: TStringField;
    listaModulos: TListView;
    ImageList1: TImageList;
    lyEditarPermisos: TLayout;
    Label1: TLabel;
    lbModulo: TLabel;
    lbDescripcion: TLabel;
    grupoPermisos: TGroupBox;
    rdSinAcceso: TRadioButton;
    rdLectura: TRadioButton;
    rdEditar: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    Image4: TImage;
    recBotonAplicar: TRectangle;
    Label3: TLabel;
    BotonAplicar: TSpeedButton;
    Label2: TLabel;
    Label5: TLabel;
    procedure botonSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActualizarServicios;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure camasServicioVer(idServicio:integer);
    procedure camasDisponiblesVer(idServicio:integer);
    procedure botonAgregarCamaClick(Sender: TObject);
    procedure botonQuitarCamaClick(Sender: TObject);
    procedure cargarComboServicios;
    procedure obtenerAlertasServicio;
    procedure comboServiciosChange(Sender: TObject);
    procedure BotonAgregarAlertaClick(Sender: TObject);
    procedure BotonQuitarAlertaClick(Sender: TObject);
    procedure obtenerCamasServicio(idServicio:integer);
    procedure obtenerPermisosServicio;
    procedure actualizarListaPermisos;
    procedure listaModulosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure BotonAplicarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idServicioSeleccionado: integer;
  end;

var
  form_Configuracion: Tform_Configuracion;

implementation

{$R *.fmx}

uses form_Tablero, mensajes_form, ModuloDatos, UFunciones;

procedure Tform_Configuracion.ActualizarServicios;
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

procedure Tform_Configuracion.BotonAgregarAlertaClick(Sender: TObject);
var
  response : IResponse;
  recurso, body : String;
  json: TJSONObject;
begin
  recurso := '/tablerocamas/servicioAgregarAlerta';
  json := TJSONObject.Create;
  try
    json.AddPair('idServicio', TJSONNumber.Create(idServicioSeleccionado.ToString));
    json.AddPair('idAlerta', TJSONNumber.Create(alertasDisponiblesidTipoAlerta.AsString));
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    body := json.ToJSON;
  finally
    json.Free;
  end;

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultados))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadosmensaje.AsString  ,'Aceptar','ERROR',0);
      exit;
    end;

  obtenerAlertasServicio;
end;

procedure Tform_Configuracion.botonAgregarCamaClick(Sender: TObject);
var
  response : IResponse;
  recurso, body : String;
  json: TJSONObject;
begin
  recurso := '/tablerocamas/servicioAgregarCama';
  json := TJSONObject.Create;
  try
    json.AddPair('idServicio', TJSONNumber.Create(idServicioSeleccionado));
    json.AddPair('idCama', TJSONNumber.Create(camasDisponiblesServicioidCama.AsString));
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    body := json.ToJSON;
  finally
    json.Free;
  end;

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultados))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadosmensaje.AsString  ,'Aceptar','ERROR',0);
      exit;
    end;

  camasServicioVer(idServicioSeleccionado);
  camasDisponiblesVer(idServicioSeleccionado);
end;

procedure Tform_Configuracion.BotonQuitarAlertaClick(Sender: TObject);
var
  response : IResponse;
  recurso, body : String;
  json: TJSONObject;
begin
  recurso := '/tablerocamas/servicioQuitarAlerta';
  json := TJSONObject.Create;
  try
    json.AddPair('idServicio', TJSONNumber.Create(idServicioSeleccionado.ToString));
    json.AddPair('idAlerta', TJSONNumber.Create(alertasServicioidTipoAlerta.AsString));
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    body := json.ToJSON;
  finally
    json.Free;
  end;

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultados))
              .Delete;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadosmensaje.AsString  ,'Aceptar','ERROR',0);
      exit;
    end;

  obtenerAlertasServicio;
end;

procedure Tform_Configuracion.botonQuitarCamaClick(Sender: TObject);
var
  response : IResponse;
  recurso, body : String;
  json: TJSONObject;
begin
  recurso := '/tablerocamas/servicioQuitarCama';
  json := TJSONObject.Create;
  try
    json.AddPair('idCama', TJSONNumber.Create(camasServicioidCama.AsString));
    json.AddPair('idServicio', TJSONNumber.Create(idServicioSeleccionado));
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    body := json.ToJSON;
  finally
    json.Free;
  end;

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultados))
              .Delete;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadosmensaje.AsString  ,'Aceptar','ERROR',0);
      exit;
    end;

  camasServicioVer(idServicioSeleccionado);
  camasDisponiblesVer(idServicioSeleccionado);
end;

procedure Tform_Configuracion.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_Configuracion.camasDisponiblesVer(idServicio: integer);
var
  response : IResponse;
  recurso : string;
begin
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

procedure Tform_Configuracion.camasServicioVer(idServicio: integer);
var
  response : IResponse;
  recurso : string;
begin
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
end;

procedure Tform_Configuracion.cargarComboServicios;
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

procedure Tform_Configuracion.comboServiciosChange(Sender: TObject);
var
  ItemSeleccionado: TComboItem;
begin
  // Verificar que haya algo seleccionado
  if comboServicios.ItemIndex < 0 then
    Exit; // No hay nada seleccionado, salir


  // obtengo el servicio seleccionado en el comboServicios
  ItemSeleccionado := TComboItem(comboServicios.Items.Objects[comboServicios.ItemIndex]);
  idServicioSeleccionado := ItemSeleccionado.ID;

  // obtengo las camas atendidas y las disponibles
  obtenerCamasServicio(ItemSeleccionado.ID);

  // obtengo las alertas atendidas y las disponibles
  obtenerAlertasServicio;

  // obtengo los permisos del servicio
  obtenerPermisosServicio;

  // muestro la página de configuración
  pagina.Visible := true;
end;

procedure Tform_Configuracion.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  formTablero.ActualizarCamas;
end;

procedure Tform_Configuracion.FormCreate(Sender: TObject);
begin
  lbTitulo.Text := 'CONFIGURACIÓN -> ' + pagina.Tabs[0].Text;
  ActualizarServicios;

  pagina.Visible := false;
  lyEditarPermisos.Visible := false;
end;

procedure Tform_Configuracion.listaModulosItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if modulosTablero.Locate('idModulo', AItem.Tag, []) then
    begin
      lbModulo.Text := modulosTableronombreModulo.AsString;
      lbDescripcion.Text := modulosTablerodescripcion.AsString;
      rdSinAcceso.IsChecked := false;
      rdLectura.IsChecked := false;
      rdEditar.IsChecked := false;
      case modulosTablerocontrolTotal.AsInteger of
        0: begin
            rdSinAcceso.IsChecked := true;
        end;
        1: begin
            rdLectura.IsChecked := true;
        end;
        2: begin
            rdEditar.IsChecked := true;
        end;
      end;

      lyEditarPermisos.Visible := true;
    end;
end;

procedure Tform_Configuracion.obtenerAlertasServicio;
var
  response, response2: IResponse;
  recurso:string;
begin
  // ALERTAS ATENDIDAS

  recurso := '/tablerocamas/alertasAtendidasServicio';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio',idServicioSeleccionado.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(alertasServicio))
              .Get;

  if alertasServicio.RecordCount > 0 then
    begin
      recBotonQuitarAlerta.Enabled := true;
    end
  else
    begin
      recBotonQuitarAlerta.Enabled := false;
    end;

  // ALERTAS NO ATENDIDAS

  recurso := '/tablerocamas/alertasNoAtendidasServicio';
  response2 := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio',idServicioSeleccionado.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(alertasDisponibles))
              .Get;

  if alertasDisponibles.RecordCount > 0 then
    begin
      recBotonAgregarAlerta.Enabled := true;
    end
  else
    begin
      recBotonAgregarAlerta.Enabled := false;
    end;
end;

procedure Tform_Configuracion.obtenerCamasServicio(idServicio:integer);
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

procedure Tform_Configuracion.obtenerPermisosServicio;
var
  response, response2: IResponse;
  recurso:string;
begin
  recurso := '/tablerocamas/servicioModulosTablero';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio',idServicioSeleccionado.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(modulosTablero))
              .Get;

  actualizarListaPermisos;
end;

procedure Tform_Configuracion.BotonAplicarClick(Sender: TObject);
var
  response : IResponse;
  recurso, body : string;
  permiso : integer;
  json: TJSONObject;
begin
  recurso := '/tablerocamas/permisoEditar';

  // obtengo el permiso seleccionado.
  if rdSinAcceso.IsChecked then
    permiso := 0
  else if rdLectura.IsChecked then
        permiso := 1
  else if rdEditar.IsChecked then
        permiso := 2;

  //body := '{"idServicio":'+ idServicioSeleccionado.ToString +', "idModulo":'+ modulosTableroidModulo.AsString +', "permiso":'+ permiso.ToString +'}';

  json := TJSONObject.Create;
  try
    json.AddPair('idServicio', TJSONNumber.Create(idServicioSeleccionado));
    json.AddPair('idModulo', TJSONNumber.Create(modulosTableroidModulo.AsInteger));
    json.AddPair('permiso', TJSONNumber.Create(permiso));
    body := json.ToJSON;
  finally
    json.Free;
  end;

  // showmessage(body);

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(resultados))
              .Post;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadosmensaje.AsString  ,'Aceptar','ERROR',0);
    end;

  obtenerPermisosServicio;
  //actualizarListaPermisos;
  lyEditarPermisos.Visible := false;
end;

procedure Tform_Configuracion.actualizarListaPermisos;
var
  Item: TListViewItem;
  Estado: Integer;
begin
  listaModulos.BeginUpdate;
  try
    listaModulos.Items.Clear;

    while not modulosTablero.Eof do
    begin
      Item := listaModulos.Items.Add;
      Item.Text := modulosTableronombreModulo.AsString;
      Item.Tag := modulosTableroidModulo.AsInteger;
      Item.ImageIndex := modulosTablerocontrolTotal.AsInteger;
      modulosTablero.Next;
    end;
  finally
    listaModulos.EndUpdate;
  end;
end;

end.
