unit form_login;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Objects, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.GIFImage,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, System.ImageList, FMX.ImgList,
  FMX.Effects,
  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D, FMX.ListBox, System.JSON;

type
  // Primero declarás la clase auxiliar
  TComboItem = class
  public
    ID: Integer;
    Descripcion: string;
  end;



type
  TformLogin = class(TForm)
    cuenta: TEdit;
    clave: TEdit;
    lb_version: TLabel;
    lb_clave: TLabel;
    Label2: TLabel;
    lyLogin: TLayout;
    espere: TGIFImage;
    LoginReg: TFDMemTable;
    GIFImage1: TGIFImage;
    ShadowEffect1: TShadowEffect;
    documentos: TFDMemTable;
    documentostdocCodigo: TIntegerField;
    documentostdocDescripcion: TStringField;
    Rectangle1: TRectangle;
    Image1: TImage;
    lbTitulo: TLabel;
    Rectangle2: TRectangle;
    Image14: TImage;
    Label33: TLabel;
    botonCancelar: TSpeedButton;
    recBotonAceptar: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    botonAceptar: TSpeedButton;
    Label3: TLabel;
    LoginRegestado: TIntegerField;
    LoginRegapellido: TStringField;
    LoginRegnombre: TStringField;
    LoginRegtdocCodigo: TIntegerField;
    LoginRegtdocDescripcion: TStringField;
    LoginRegnroDocumento: TStringField;
    LoginRegidUsuario: TIntegerField;
    LoginRegidAplicacion: TIntegerField;
    LoginRegaplicacion: TStringField;
    LoginRegservicios: TMemoField;
    LoginRegmensaje: TStringField;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure botonCancelarApplyStyleLookup(Sender: TObject);
    procedure botonAceptarApplyStyleLookup(Sender: TObject);
    procedure claveKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure cuentaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure iniciarSesion(cuenta, clave: string; tipoDocumento:integer);
    procedure ActualizarTiposDocumentos;
    procedure CargarComboBox;
    procedure tipoDocumentoChange(Sender: TObject);
    procedure LiberarItemsCombo;
    procedure FormDestroy(Sender: TObject);
    procedure botonCancelarClick(Sender: TObject);
    procedure botonAceptarClick(Sender: TObject);
    procedure CargarServiciosDesdeJson(const JsonStr:string; tablaServicios: TFDMemTable);
  private
    { Private declarations }
  public
    { Public declarations }
    tdocCodigo: integer;
  end;
var
  formLogin: TformLogin;
implementation
{$R *.fmx}
uses form_Tablero, ModuloDatos, mensajes_form;

procedure TformLogin.ActualizarTiposDocumentos;
//var
//  response : IResponse;
//  recurso : String;
begin
//  recurso := '/tablerocamas/tiposDocumentos';
//  response := TRequest.New.BaseURL(datos.urlTC)
//                          .Resource(recurso)
//                          .AddHeader('TokenAcceso', datos.tokenAcceso)
//                          .Accept('application/json')
//                          .Adapters(TDataSetSerializeAdapter.New(documentos))
//                          .Get;
//
//  if response.StatusCode <> 200 then
//    begin
//      datos.VerMensaje('ERROR' + response.StatusCode.ToString ,'Ocurrió un error al intentar obtener los tipos de documentos','Ok','ERROR',0);
//    end
//  else
//    begin
//      CargarComboBox;
//    end;
end;

procedure TformLogin.botonAceptarApplyStyleLookup(Sender: TObject);
  var
  Button: TCustomButton;
  Control: TControl;
  TextObj: TFmxObject;
begin
  Button := (Sender as TCustomButton);
  for Control in Button.Controls do
  begin
    TextObj := Button.FindStyleResource('text');
    (TextObj as TText).Margins.Left := 32;
  end;
end;
procedure TformLogin.botonAceptarClick(Sender: TObject);
begin
  //iniciarSesion(cuenta.Text,clave.Text, tdocCodigo);
  iniciarSesion(cuenta.Text,clave.Text, 1); // por defecto tdocCodigo = 1 = DNI
end;

procedure TformLogin.botonCancelarApplyStyleLookup(Sender: TObject);
var
  Button: TCustomButton;
  Control: TControl;
  TextObj: TFmxObject;
begin
  Button := (Sender as TCustomButton);
  for Control in Button.Controls do
  begin
    TextObj := Button.FindStyleResource('text');
    (TextObj as TText).Margins.Left := 32;
  end;
end;
procedure TformLogin.botonCancelarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TformLogin.CargarComboBox;
//var
//  Item: TComboItem;
begin
//  tipoDocumento.Items.Clear;
//  documentos.First;
//  while not documentos.Eof do
//  begin
//    // Crear un objeto nuevo para este registro
//    Item := TComboItem.Create;
//    // Copiar los datos del registro al objeto
//    Item.ID          := documentostdocCodigo.AsInteger;
//    Item.Descripcion := documentostdocDescripcion.AsString;
//    // Agregar al ComboBox: el texto visible + el objeto adjunto
//    tipoDocumento.Items.AddObject(Item.Descripcion, Item);
//    documentos.Next;
//  end;
end;

procedure TformLogin.CargarServiciosDesdeJson(const JsonStr: string; tablaServicios: TFDMemTable);
var
  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  I: Integer;
begin
  tablaServicios.DisableControls;
  try
    tablaServicios.Close;
    tablaServicios.Open;
    tablaServicios.EmptyDataSet;

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

        tablaServicios.Append;

        tablaServicios.FieldByName('idServicio').AsInteger :=
          JsonObj.GetValue<Integer>('idServicio');

        tablaServicios.FieldByName('nombreServicio').AsString :=
          JsonObj.GetValue<string>('nombreServicio');

        tablaServicios.FieldByName('idTipoInternacion').AsInteger :=
          JsonObj.GetValue<Integer>('idTipoInternacion');

        tablaServicios.FieldByName('cambioCamaAreaCerrada').AsInteger :=
          JsonObj.GetValue<Integer>('cambioCamaAreaCerrada');

        tablaServicios.FieldByName('gestionaCamas').AsInteger :=
          JsonObj.GetValue<Integer>('gestionaCamas');

        tablaServicios.Post;
      end;
    finally
      JsonArray.Free;
    end;

  finally
    tablaServicios.EnableControls;
  end;
end;

procedure TformLogin.claveKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key = vkreturn then
    botonAceptar.OnClick(botonAceptar);
end;
procedure TformLogin.cuentaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key = vkreturn then
    clave.SetFocus;
end;
procedure TformLogin.FormActivate(Sender: TObject);
begin
  cuenta.SetFocus;
end;
procedure TformLogin.FormCreate(Sender: TObject);
begin
  lb_version.Text := 'Versión: ' + datos.GetAppVersion().ToString;

  // ActualizarTiposDocumentos
end;

procedure TformLogin.FormDestroy(Sender: TObject);
begin
//  LiberarItemsCombo;
end;

procedure TformLogin.iniciarSesion(cuenta, clave: string; tipoDocumento:integer);
var
  response: IResponse;
  recurso, body : string;
  mensaje: TForm_mensajes;

  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObj: TJSONObject;
  ServiciosArray: TJSONArray;
begin
  if (cuenta <> '') and (clave <> '') then
    begin
      lyLogin.Visible := false;
      espere.Visible := true;
      espere.Play;
      TThread.CreateAnonymousThread(procedure
      begin
        recurso := '/tablerocamas/login';
        body := '{'+
                    '"tdocCodigo":'+ tipoDocumento.ToString +','+
                    '"nroDocumento":"'+ cuenta +'",'+
                    '"clave":"'+ clave +'",'+
                    '"idAplicacion":4'+
                '}';

        response := TRequest.New.BaseURL(datos.urlTC)
                           .Resource(recurso)
                           .AddHeader('TokenAcceso', datos.tokenAcceso)
                           .AddBody(body)
                           .Accept('application/json')
                           .Adapters(TDataSetSerializeAdapter.New(LoginReg))
                           .Post;

        TThread.Synchronize(nil, procedure
          begin
            if response.StatusCode = 200 then
              begin
                formTablero.lb_usuarioActivo.Text    := LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString;
                formTablero.lb_usuarioDocumento.text := LoginRegtdocDescripcion.AsString + ': ' + LoginRegnroDocumento.AsString;
                datos.idUsuario                      := LoginRegidUsuario.AsInteger;
                datos.dniLogin                       := LoginRegnroDocumento.AsString;
                datos.nombreLogin                    := LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString;

                // cargo los servicio de este usuario en la tabla formTablero.serviciosUsuario
                JsonValue := TJSONObject.ParseJSONValue(response.Content);

                JsonArray := JsonValue as TJSONArray;
                JsonObj := JsonArray.Items[0] as TJSONObject;

                ServiciosArray := JsonObj.GetValue<TJSONArray>('servicios');

                CargarServiciosDesdeJson(ServiciosArray.ToJSON, formTablero.serviciosUsuario);
                datos.servicio := formTablero.serviciosUsuarioidServicio.AsInteger;
                Close;
              end
            else
              begin
                lyLogin.Visible := true;
                espere.Visible := false;
                espere.Stop;
                datos.VerMensaje('ACCESO DENEGADO', loginRegmensaje.AsString, 'Aceptar', 'ERROR',0);
              end;
          end
        );
      end
      ).Start;
    end
  else
    begin
      datos.VerMensaje('ERROR','Primero debe ingresar el usuario y la contraseña','Aceptar','ERROR',0);
    end;
end;
procedure TformLogin.LiberarItemsCombo;
//var
//  i: Integer;
begin
//  for i := 0 to tipoDocumento.Items.Count - 1 do
//  begin
//    // Liberar cada objeto adjunto
//    tipoDocumento.Items.Objects[i].Free;
//  end;
//  tipoDocumento.Items.Clear;
end;

procedure TformLogin.tipoDocumentoChange(Sender: TObject);
//var
//  ItemSeleccionado: TComboItem;
begin
//  // Verificar que haya algo seleccionado
//  if tipoDocumento.ItemIndex < 0 then
//    Exit; // No hay nada seleccionado, salir
//  // Recuperar el objeto adjunto al ítem seleccionado
//  // El cast (TComboItem) es necesario porque Items.Objects devuelve TObject
//  ItemSeleccionado := TComboItem(tipoDocumento.Items.Objects[tipoDocumento.ItemIndex]);
////  ShowMessage('ID seleccionado: ' + ItemSeleccionado.ID.ToString);
////  ShowMessage('Descripción: '     + ItemSeleccionado.Descripcion);
//  tdocCodigo := ItemSeleccionado.ID;
//  recBotonAceptar.Enabled := true;
end;

end.
