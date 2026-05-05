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
    procedure iniciarSesion_v2(cuenta, clave: string; tipoDocumento:integer);
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
  //iniciarSesion(cuenta.Text,clave.Text, 1); // por defecto tdocCodigo = 1 = DNI
  iniciarSesion_v2(cuenta.Text,clave.Text, 1); // por defecto tdocCodigo = 1 = DNI
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
      if JsonArray.Count = 0 then
        begin
          datos.VerMensaje('SERVICIO NO DEFINIDO', 'Este usuario no tiene definido ningún servicio. No podrá usar esta aplicación.', 'Aceptar', 'ERROR',0);
          Application.Terminate;
        end;

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

procedure TformLogin.iniciarSesion_v2(cuenta, clave: string; tipoDocumento: integer);
var
  mensaje: TForm_mensajes;
begin
  if (cuenta = '') or (clave = '') then
  begin
    datos.VerMensaje('ERROR', 'Primero debe ingresar el usuario y la contraseña', 'Aceptar', 'ERROR', 0);
    Exit;
  end;

  lyLogin.Visible := false;
  espere.Visible  := true;
  espere.Play;

  TThread.CreateAnonymousThread(
    procedure
    var
      response: IResponse;
      recurso, body: string;
      // Capturamos todo lo necesario en variables locales del hilo
      statusCode: Integer;
      content: string;
    begin
      try
        recurso := '/tablerocamas/login';
        body := '{'
          + '"tdocCodigo":'  + tipoDocumento.ToString + ','
          + '"nroDocumento":"' + cuenta + '",'
          + '"clave":"'        + clave  + '",'
          + '"idAplicacion":4'
          + '}';

        response := TRequest.New
          .BaseURL(datos.urlTC)
          .Resource(recurso)
          .AddHeader('TokenAcceso', datos.tokenAcceso)
          .AddBody(body)
          .Accept('application/json')
          .Adapters(TDataSetSerializeAdapter.New(LoginReg))
          .Post;

        // Guardamos lo que necesitamos ANTES de ir al hilo principal
        statusCode := response.StatusCode;
        content    := response.Content;

      except
        on E: Exception do
        begin
          // Capturamos el mensaje de error para mostrarlo en el hilo principal
          content    := E.Message;
          statusCode := -1;
        end;
      end;

      // Queue NO bloquea el hilo secundario (a diferencia de Synchronize)
      TThread.Queue(nil,
        procedure
        var
          JsonValue: TJSONValue;
          JsonArray: TJSONArray;
          JsonObj: TJSONObject;
          ServiciosArray: TJSONArray;
        begin
          try
            if statusCode = 200 then
            begin
              formTablero.lb_usuarioActivo.Text    := LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString;
              formTablero.lb_usuarioDocumento.Text := LoginRegtdocDescripcion.AsString + ': ' + LoginRegnroDocumento.AsString;
              datos.idUsuario                      := LoginRegidUsuario.AsInteger;
              datos.dniLogin                       := LoginRegnroDocumento.AsString;
              datos.nombreLogin                    := LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString;

              JsonValue := TJSONObject.ParseJSONValue(content);
              try
                if Assigned(JsonValue) and (JsonValue is TJSONArray) then
                begin
                  JsonArray := JsonValue as TJSONArray;
                  if JsonArray.Count > 0 then
                  begin
                    JsonObj := JsonArray.Items[0] as TJSONObject;
                    ServiciosArray := JsonObj.GetValue<TJSONArray>('servicios');
                    if Assigned(ServiciosArray) then
                      CargarServiciosDesdeJson(ServiciosArray.ToJSON, formTablero.serviciosUsuario);
                  end;
                end;
              finally
                JsonValue.Free; // evita memory leak
              end;

              datos.servicio := formTablero.serviciosUsuarioidServicio.AsInteger;
              formTablero.ActualizarServicio;
              //formTablero.ConsultarCambios;
              Close;
            end
            else
            begin
              lyLogin.Visible := true;
              espere.Visible  := false;
              espere.Stop;

              if statusCode = -1 then
                datos.VerMensaje('ERROR DE RED', content, 'Aceptar', 'ERROR', 0)
              else
                datos.VerMensaje('ACCESO DENEGADO', LoginRegmensaje.AsString, 'Aceptar', 'ERROR', 0);
            end;
          except
            on E: Exception do
            begin
              lyLogin.Visible := true;
              espere.Visible  := false;
              espere.Stop;
              datos.VerMensaje('ERROR', E.Message, 'Aceptar', 'ERROR', 0);
            end;
          end;
        end
      );
    end
  ).Start;
end;

end.
