unit TareaRepracionCrear_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Effects, FMX.StdCtrls, FMX.ListView, FMX.TabControl, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D, System.JSON,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  Tform_TareaRepracionCrear = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    recTitulo: TRectangle;
    lb_Titulo: TLabel;
    Image3: TImage;
    ly_Contenedor: TLayout;
    pagina: TTabControl;
    pagina1: TTabItem;
    Rectangle10: TRectangle;
    recBotonSalir: TRectangle;
    Label24: TLabel;
    SpeedButton3: TSpeedButton;
    Image4: TImage;
    pagina2: TTabItem;
    Rectangle13: TRectangle;
    recBotonSiguiente: TRectangle;
    Label25: TLabel;
    botonSiguiente: TSpeedButton;
    Image5: TImage;
    categorias: TFDMemTable;
    reparaciones: TFDMemTable;
    categoriasidCategoria: TIntegerField;
    categoriascategoria: TStringField;
    categoriasreparaciones: TMemoField;
    reparacionesidReparacion: TIntegerField;
    reparacionesreparacion: TStringField;
    reparacionesinhabilitaHab: TIntegerField;
    reparacionesbloqueaCama: TIntegerField;
    reparacionesidPrioridad: TIntegerField;
    reparacionesprioridad: TStringField;
    grupoCategorias: TGroupBox;
    catBano: TRadioButton;
    catHabitacion: TRadioButton;
    listaReparaciones: TListView;
    ly_pie: TLayout;
    reparacioneslimpiezaPosterior: TIntegerField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    reparacionesidCategoria: TIntegerField;
    Layout3: TLayout;
    recCancelar2: TRectangle;
    Label30: TLabel;
    Image6: TImage;
    botonCancelar2: TSpeedButton;
    recBotonEnviar: TRectangle;
    Label31: TLabel;
    botonEnviarTicket: TSpeedButton;
    Image7: TImage;
    recBotonAtras: TRectangle;
    Label32: TLabel;
    botonAtras: TSpeedButton;
    Image8: TImage;
    Layout4: TLayout;
    Label33: TLabel;
    Label34: TLabel;
    lb_categoria: TLabel;
    lb_reparacion: TLabel;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    lb_bloqueaHab: TLabel;
    lb_bloqueaCama: TLabel;
    Label40: TLabel;
    lb_Prioridad: TLabel;
    Label41: TLabel;
    detalle: TMemo;
    respuesta: TFDMemTable;
    respuestaestado: TIntegerField;
    respuestamensaje: TStringField;
    procedure SpeedButton3Click(Sender: TObject);
    procedure ObtenerCategorias;
    procedure FormCreate(Sender: TObject);
    procedure CargarReparacionesDesdeJson(const JsonStr: string; tablaReparaciones: TFDMemTable);
    procedure CargarReparacionesDesdeCategorias(idCategoria:integer);
    procedure catHabitacionChange(Sender: TObject);
    procedure catBanoClick(Sender: TObject);
    procedure botonSiguienteClick(Sender: TObject);
    procedure botonAtrasClick(Sender: TObject);
    procedure botonEnviarTicketClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idCama :integer;
  end;

var
  form_TareaRepracionCrear: Tform_TareaRepracionCrear;

implementation

{$R *.fmx}

uses ModuloDatos, form_Tablero;

procedure Tform_TareaRepracionCrear.FormCreate(Sender: TObject);
begin
  form_TareaRepracionCrear.Height := formTablero.Height;
  form_TareaRepracionCrear.Width := formTablero.Width;

  pagina.TabIndex := 0;

  ObtenerCategorias;
end;

procedure Tform_TareaRepracionCrear.botonAtrasClick(Sender: TObject);
begin
  pagina.TabIndex := 0;
end;

procedure Tform_TareaRepracionCrear.botonEnviarTicketClick(Sender: TObject);
var
  response : IResponse;
  recurso, body: String;
  json: TJSONObject;
begin
  if detalle.Text = '' then
    begin
      datos.VerMensaje('Faltan datos','Tenés que describir el problema. Esta información es muy útil al equipo de Mantenimiento.','Aceptar','ERROR',0);
      Exit;
    end;

  recurso := '/tablerocamas/tareaReparacionCrear';

  json := TJSONObject.Create;
  try
    json.AddPair('idCama', TJSONNumber.Create(idCama));
    json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
    json.AddPair('idServicio', TJSONNumber.Create(datos.servicio));
    json.AddPair('idReparacion', TJSONNumber.Create(reparacionesidReparacion.AsInteger));
    json.AddPair('detalle', detalle.Text);
    body := json.ToJSON;
  finally
    json.Free;
  end;

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddBody(body)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(respuesta))
              .Post;

  if response.StatusCode = 200 then
    begin
      datos.VerMensaje('Tarea creada',respuestamensaje.AsString,'Aceptar','OK',0);
      Close;
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,'El método ' + recurso + ' retornó el siguiente mensaje: ' + respuestamensaje.AsString,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_TareaRepracionCrear.botonSiguienteClick(Sender: TObject);
begin
  lb_categoria.Text := categoriascategoria.AsString;
  lb_reparacion.Text := reparacionesreparacion.AsString;
  lb_bloqueaHab.StyledSettings := [TStyledSetting.Family];
  lb_bloqueaHab.TextSettings.Font.Style := [TFontStyle.fsBold];
  if reparacionesinhabilitaHab.AsInteger = 1 then
    begin
      lb_bloqueaHab.Text := 'Si';
      lb_bloqueaHab.TextSettings.FontColor := TAlphaColorRec.Red;
    end
  else
    begin
      lb_bloqueaHab.Text := 'No';
      lb_bloqueaHab.TextSettings.FontColor := TAlphaColorRec.Black;
    end;


  lb_bloqueaCama.StyledSettings := [TStyledSetting.Family];
  lb_bloqueaCama.TextSettings.Font.Style := [TFontStyle.fsBold];
  if reparacionesbloqueaCama.AsInteger = 1 then
    begin
      lb_bloqueaCama.Text := 'Si';
      lb_bloqueaCama.TextSettings.FontColor := TAlphaColorRec.Red;
    end
  else
    begin
      lb_bloqueaCama.Text := 'No';
      lb_bloqueaCama.TextSettings.FontColor := TAlphaColorRec.Black;
    end;

  lb_prioridad.Text := reparacionesprioridad.AsString;

  pagina.TabIndex := 1;
end;

procedure Tform_TareaRepracionCrear.CargarReparacionesDesdeCategorias(idCategoria: integer);
var
  jsonStr: string;
  jsonArray: TJSONArray;
  jsonObj: TJSONObject;
  i: Integer;
begin
  if not reparaciones.Active then
    reparaciones.Open;

  // 1. Filtrar la tabla categorías
  categorias.Filtered := False;
  categorias.Filter := 'idCategoria = ' + IntToStr(idCategoria);
  categorias.Filtered := True;

  categorias.First;

  if Categorias.IsEmpty then
  begin
    ShowMessage('Categoría no encontrada');
    Exit;
  end;

  // 2. Leer el campo memo con el JSON
  jsonStr := categoriasreparaciones.AsString;


  if jsonStr.IsEmpty then Exit;

  // 3. Limpiar la tabla reparaciones antes de cargar
  reparaciones.EmptyDataSet;

  // 4. Parsear el JSON y cargar en la memtable
  jsonArray := TJSONObject.ParseJSONValue(jsonStr) as TJSONArray;


  if not Assigned(jsonArray) then
  begin
    ShowMessage('Error al parsear el JSON');
    Exit;
  end;

  try
    for i := 0 to jsonArray.Count - 1 do
    begin
      jsonObj := jsonArray.Items[i] as TJSONObject;

      reparaciones.Append;
      reparaciones.FieldByName('idCategoria').AsInteger   := jsonObj.GetValue<Integer>('idCategoria');
      reparaciones.FieldByName('idReparacion').AsInteger  := jsonObj.GetValue<Integer>('idReparacion');
      reparaciones.FieldByName('reparacion').AsString     := jsonObj.GetValue<string>('reparacion');
      reparaciones.FieldByName('inhabilitaHab').AsInteger := jsonObj.GetValue<Integer>('inhabilitaHab');
      reparaciones.FieldByName('limpiezaPosterior').AsInteger := jsonObj.GetValue<Integer>('limpiezaPosterior');
      reparaciones.FieldByName('bloqueaCama').AsInteger   := jsonObj.GetValue<Integer>('bloqueaCama');
      reparaciones.FieldByName('idPrioridad').AsInteger   := jsonObj.GetValue<Integer>('idPrioridad');
      reparaciones.FieldByName('prioridad').AsString      := jsonObj.GetValue<string>('prioridad');
      reparaciones.Post;
    end;
  finally
    jsonArray.Free;
  end;
end;

procedure Tform_TareaRepracionCrear.CargarReparacionesDesdeJson(const JsonStr: string; tablaReparaciones: TFDMemTable);
var
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  I: Integer;
begin
  tablaReparaciones.DisableControls;
  try
    tablaReparaciones.Close;
    tablaReparaciones.Open;
    tablaReparaciones.EmptyDataSet;

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

        tablaReparaciones.Append;

        tablaReparaciones.FieldByName('idCategoria').AsInteger :=
          JsonObj.GetValue<Integer>('idCategoria');

        tablaReparaciones.FieldByName('idReparacion').AsInteger :=
          JsonObj.GetValue<Integer>('idReparacion');

        tablaReparaciones.FieldByName('reparacion').AsString :=
          JsonObj.GetValue<String>('reparacion');

        tablaReparaciones.FieldByName('inhabilitaHab').AsInteger :=
          JsonObj.GetValue<Integer>('inhabilitaHab');

        tablaReparaciones.FieldByName('bloqueaCama').AsInteger :=
          JsonObj.GetValue<Integer>('bloqueaCama');

        tablaReparaciones.FieldByName('idPrioridad').AsInteger :=
          JsonObj.GetValue<Integer>('idPrioridad');

        tablaReparaciones.FieldByName('prioridad').AsString :=
          JsonObj.GetValue<String>('prioridad');

        tablaReparaciones.Post;
      end;
    finally
      JsonArray.Free;
    end;

  finally
    tablaReparaciones.EnableControls;
  end;
end;

procedure Tform_TareaRepracionCrear.catBanoClick(Sender: TObject);
begin
  CargarReparacionesDesdeCategorias(1);
end;

procedure Tform_TareaRepracionCrear.catHabitacionChange(Sender: TObject);
begin
  if catHabitacion.IsChecked then
    CargarReparacionesDesdeCategorias(2);
end;

procedure Tform_TareaRepracionCrear.ObtenerCategorias;
var
  response : IResponse;
  recurso: String;
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  ReparacionesArray: TJSONArray;
begin
  recurso := '/tablerocamas/categoriasReparaciones';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              //.Adapters(TDataSetSerializeAdapter.New(categorias))
              .Get;

  if response.StatusCode <> 200 then
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,'No fue posible obtener las tareas de reparación' + #13 + 'Endpoint: ' + recurso,'Aceptar','ERROR',0);
      Exit;
    end;


  // Abrir la tabla si está cerrada
  if not categorias.Active then
    categorias.Open;

  // Parsear el JSON manualmente
  JsonValue := TJSONObject.ParseJSONValue(response.Content);
  if not Assigned(JsonValue) then Exit;
  try
    JsonArray := JsonValue as TJSONArray;
    categorias.EmptyDataSet;
    for var i := 0 to JsonArray.Count - 1 do
    begin
      JsonObj := JsonArray.Items[i] as TJSONObject;
      categorias.Append;
      categorias.FieldByName('idCategoria').AsInteger := JsonObj.GetValue<Integer>('idCategoria');
      categorias.FieldByName('categoria').AsString    := JsonObj.GetValue<string>('categoria');
      // El campo reparaciones es un array, lo guardamos como string JSON
      reparacionesArray := JsonObj.GetValue('reparaciones') as TJSONArray;
      if Assigned(reparacionesArray) then
        categorias.FieldByName('reparaciones').AsString := reparacionesArray.ToString
      else
        categorias.FieldByName('reparaciones').AsString := '[]';
      categorias.Post;
    end;
  finally
    JsonValue.Free;
  end;
end;

procedure Tform_TareaRepracionCrear.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

end.
