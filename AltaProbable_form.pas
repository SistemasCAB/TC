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
  Data.Bind.DBScope;

type
  TformAltaProbable = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Label4: TLabel;
    botonAceptar: TRectangle;
    Label7: TLabel;
    btnAceptar: TSpeedButton;
    lb_paciente: TLabel;
    Label1: TLabel;
    lb_documento: TLabel;
    Label14: TLabel;
    lb_cama: TLabel;
    Image1: TImage;
    fecha: TDateEdit;
    hora: TTimeEdit;
    Label2: TLabel;
    Label3: TLabel;
    listaAltas: TListView;
    Label5: TLabel;
    altas: TFDMemTable;
    altasidTipoAltaMedica: TIntegerField;
    altastipoAltaMedica: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    resultado: TFDMemTable;
    resultadoestado: TIntegerField;
    resultadomensaje: TStringField;
    botonSalir: TSpeedButton;
    Image3: TImage;
    procedure ActualizarAltasMedicas;
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure botonSalirClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    idInternacion :Integer;
  end;

var
  formAltaProbable: TformAltaProbable;

implementation

{$R *.fmx}

uses ModuloDatos;

{ TformAltaProbable }

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

  if response.StatusCode = 200 then
    begin
       datos.VerMensaje('ALTA PROBABLE GRABADA' ,resultadomensaje.AsString,'Aceptar','OK',0);
       Close;
    end
  else
    begin
      datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,'Ha ocurrido un error en la ejecución del método ' + recurso + #13 + resultadomensaje.AsString,'Aceptar','ERROR',0);
    end;
end;

procedure TformAltaProbable.FormCreate(Sender: TObject);
begin
  ActualizarAltasMedicas;
end;

end.
