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
  FMX.Effects;
type
  TformLogin = class(TForm)
    cuenta: TEdit;
    clave: TEdit;
    lb_version: TLabel;
    lb_clave: TLabel;
    botonCancelar: TButton;
    botonAceptar: TButton;
    Label2: TLabel;
    lyLogin: TLayout;
    espere: TGIFImage;
    LoginReg: TFDMemTable;
    LoginRegestado: TBooleanField;
    LoginRegId_Usuario: TIntegerField;
    LoginRegdni: TIntegerField;
    LoginRegnombre: TWideStringField;
    LoginRegapellido: TWideStringField;
    LoginRegacceso_tablero: TBooleanField;
    Image3: TImage;
    Image2: TImage;
    GIFImage1: TGIFImage;
    ShadowEffect1: TShadowEffect;
    procedure botonCancelarClick(Sender: TObject);
    procedure botonAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure botonCancelarApplyStyleLookup(Sender: TObject);
    procedure botonAceptarApplyStyleLookup(Sender: TObject);
    procedure claveKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure cuentaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure iniciarSesion(cuenta,clave:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  formLogin: TformLogin;
implementation
{$R *.fmx}
uses form_Tablero, ModuloDatos, mensajes_form,
  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D;
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
  iniciarSesion(cuenta.Text,clave.Text);
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
  formLogin.Width := 413;
  formLogin.Height := 270;
  lb_version.Text := 'Versión: ' + datos.GetAppVersion().ToString;
end;

procedure TformLogin.iniciarSesion(cuenta, clave: string);
var
  //response: IResponse;
  mensaje: TForm_mensajes;
begin
  if (cuenta <> '') and (clave <> '') then
    begin
      lyLogin.Visible := false;
      espere.Visible := true;
      espere.Play;
      TThread.CreateAnonymousThread(procedure
      begin
        var response := TRequest.New
                  .BaseURL(datos.url + '/api/login?APIKey='+ datos.APIKey +'&Usuario='+ cuenta +'&Password=' + clave)
                  .Accept('application/json')
                  .Adapters(TDataSetSerializeAdapter.New(LoginReg))
                  .Post;
        TThread.Synchronize(nil, procedure
          begin
            if response.StatusCode = 200 then
              begin
                if (LoginRegacceso_tablero.AsBoolean = True) then
                  begin
                    formTablero.lb_usuarioActivo.Text   := LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString;
                    formTablero.lb_usuarioActivo.Hint   := 'DNI: ' + LoginRegdni.AsString;
                    datos.Id_Usuario_Markey             := LoginRegId_Usuario.AsInteger;
                    datos.dniLogin                      := LoginRegdni.AsString;
                    datos.nombreLogin                   := LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString;
                    Close;
                  end
                else
                  begin
                    lyLogin.Visible := true;
                    espere.Visible := false;
                    espere.Stop;
                    datos.VerMensaje('ERROR', 'Hola ' + LoginRegapellido.AsString + ', ' + LoginRegnombre.AsString + #13+#13+ 'No estás habilitado para usar el Tablero de Camas.', 'Aceptar', 'ERROR',0);
                  end;
              end
            else
              begin
                lyLogin.Visible := true;
                espere.Visible := false;
                espere.Stop;
                datos.VerMensaje('ACCESO DENEGADO', 'Usuario y/o contraseña incorrectos', 'Aceptar', 'ERROR',0);
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
end.
