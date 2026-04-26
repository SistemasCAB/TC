unit ModuloDatos;

interface

uses
  System.SysUtils, System.Classes, IniFiles, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Winapi.Windows, Data.Win.ADODB;

type
  Tdatos = class(TDataModule)
    ticketsCli: TRESTClient;
    ticketsReq: TRESTRequest;
    ticketsRes: TRESTResponse;
    ticketsDSA: TRESTResponseDataSetAdapter;
    tickets: TFDMemTable;
    ticketsdni: TWideStringField;
    ticketsid_usuario_ticket: TFloatField;
    permisosServicio: TFDMemTable;
    permisosServicioidPermiso: TIntegerField;
    permisosServicioidModulo: TIntegerField;
    permisosServicionombreModulo: TStringField;
    permisosServiciodescripcionModulo: TStringField;
    permisosServiciocontrolTotal: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure VerMensaje(textoTitulo,textoMensaje,textoBoton,icono:string; tiempo:integer);
    function  GetAppVersion: integer;
    procedure actualizarConfiguracion;
    function MensajeConfirmacion(textoTitulo, textoMensaje, textoBotonSi, textoBotonNo,icono: string; ancho,alto:integer): integer;
  private
    { Private declarations }
  public
    // Tablero
    versionActual:integer;
    autologin, servicio:integer;
    archivo : TIniFile;
    fullscreen :integer;
    segundos:integer;
    cambiarServicio:integer;
    col, alto,pad:integer;
    cambioCamaAreaCerrada:integer; //indica si en el servicio se puede hacer cambios de cama sin autorización de Admisión por ser un área cerrada.
    gestionaCamas:integer; // indica que este servicio tiene capacidad para autorizar los cambios de cama (como Admisión y Egresos)
    pendientes:integer;
    idUsuario:integer;
    dniLogin:string;
    nombreLogin:string;

    urlTC:string;
    tokenAcceso:string;

    servidorSQL, baseDatos, usuarioBD, passwordBD:string;

    //Tickets
    id_usuario_ticket : integer;

    //Markey
    url, APIKey:string;
  end;

var
  datos: Tdatos;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses mensajes_form, System.UITypes, mensajeConfirmacion_form, FMX.Forms,
  CambioDeCama_form, UFunciones;

{$R *.dfm}

procedure Tdatos.DataModuleCreate(Sender: TObject);
begin
  actualizarConfiguracion;
end;

function Tdatos.GetAppVersion: integer;
var
  Size, Size2: DWord;
  Pt, Pt2: Pointer;
begin
  Size := GetFileVersionInfoSize(PChar (ParamStr (0)), Size2);
  if Size > 0 then
    begin
      GetMem (Pt, Size);
        try
          GetFileVersionInfo (PChar (ParamStr (0)), 0, Size, Pt);
          VerQueryValue (Pt, '\', Pt2, Size2);
          with TVSFixedFileInfo (Pt2^) do
            begin
              Result:= HiWord (dwFileVersionMS);
            end;
        finally
          FreeMem (Pt);
        end;
    end;
end;



procedure Tdatos.actualizarConfiguracion;
begin
  archivo         := TIniFile.Create('c:\tc\config.ini');
  url             := archivo.ReadString('API','url','https://clinicaadventista.markey.com.ar/APIMarkeyCAB');
  APIKey          := archivo.ReadString('API','APIKey','');

  urlTC           := archivo.ReadString('API','urlTC','http://10.99.8.106/cab/public/v2');
  tokenAcceso     := archivo.ReadString('API','tokenAcceso','');

  autologin       := archivo.ReadInteger('TABLERO','autologin',0);
  fullscreen      := archivo.ReadInteger('TABLERO','fullscreen',0);
  segundos        := archivo.ReadInteger('TABLERO','actualizar',30);
  cambiarServicio := archivo.ReadInteger('TABLERO','cambiarServicios',0);

  col             := archivo.ReadInteger('TABLERO','columnas',4);
  alto            := archivo.ReadInteger('TABLERO','altura',100);
  pad             := archivo.ReadInteger('TABLERO','padding',5);
  pendientes      := archivo.ReadInteger('TABLERO','versolotareaspendientes',0);

  servidorSQL     := archivo.ReadString('SQL','servidor','10.99.8.8');
  baseDatos       := archivo.ReadString('SQL','base','CAB');
  usuarioBD       := archivo.ReadString('SQL','usuario','superusr_cab');
  passwordBD      := '8125.5b2a1c8';
end;


procedure Tdatos.VerMensaje(textoTitulo, textoMensaje, textoBoton, icono: string; tiempo:integer);
var
  mensaje : Tform_mensajes;
begin
  mensaje := Tform_mensajes.Create(nil,textoTitulo,textoMensaje , textoBoton, icono, tiempo);
  mensaje.ShowModal;
end;

function Tdatos.MensajeConfirmacion(textoTitulo, textoMensaje, textoBotonSi, textoBotonNo,icono: string; ancho,alto:integer): integer;
begin
  Application.CreateForm(Tform_mensajeConfirmacion, form_mensajeConfirmacion);

  with form_mensajeConfirmacion do
    begin

      Height              := alto;
      Width               := ancho;

      lbTitulo.Text       := textoTitulo;
      lbTexto.Text        := textoMensaje;
      lbTextoBotonSi.Text := textoBotonSi;
      lbTextoBotonNo.Text := textoBotonNo;

      if UpperCase(icono) = 'PREGUNTA' then
        begin
          iconoPregunta.Visible := true;
          iconoWarning.Visible  := false;
          botonSi.Fill.Color := TAlphaColorRec.Darkcyan;
        end;

      if UpperCase(Icono) = 'WARNING' then
        begin
          iconoPregunta.Visible := false;
          iconoWarning.Visible  := true;

          botonSi.Fill.Color := TAlphaColorRec.Red;
        end;
    end;


  MensajeConfirmacion := form_mensajeConfirmacion.ShowModal;
end;


end.
