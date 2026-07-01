unit Limpieza_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tform_Limpieza = class(TForm)
    FondoTransparente: TRectangle;
    Formulario: TRectangle;
    recTitulo: TRectangle;
    lbTitulo: TLabel;
    botonSalir: TSpeedButton;
    Image3: TImage;
    ShadowEffect1: TShadowEffect;
    botonGrabar: TRectangle;
    Label6: TLabel;
    btnGrabar: TSpeedButton;
    Image4: TImage;
    Label1: TLabel;
    detalle: TEdit;
    resultados: TFDMemTable;
    resultadosestado: TIntegerField;
    resultadosmensaje: TStringField;
    procedure botonSalirClick(Sender: TObject);
    procedure botonGrabarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idCama:integer;
  end;

var
  form_Limpieza: Tform_Limpieza;

implementation

{$R *.fmx}

uses ModuloDatos, DetallesCama_form, TareasLimpieza_form;

procedure Tform_Limpieza.botonGrabarClick(Sender: TObject);
var
  response: IResponse;
  recurso,body:string;
  json: TJSONObject;
begin
  if detalle.Text <> '' then
    begin
      json := TJSONObject.Create;
      try
        json.AddPair('idCama', TJSONNumber.Create(idCama));
        json.AddPair('idUsuario', TJSONNumber.Create(datos.idUsuario));
        json.AddPair('idServicio',TJSONNumber.Create(datos.idAplicacion));
        json.AddPair('detalle',TJSONNumber.Create(detalle.Text));
        body := json.ToJSON;
      finally
        json.Free;
      end;

      recurso := '/tablerocamas/tareaLimpiezaVariosCrear';
      response := TRequest.New.BaseURL(datos.urlTC)
                  .Resource(recurso)
                  .AddHeader('TokenAcceso', datos.tokenAcceso)
                  .Accept('application/json')
                  .Adapters(TDataSetSerializeAdapter.New(resultados))
                  .Get;

      if response.StatusCode <> 200 then
        begin
          datos.VerMensaje('Error','No fue posible crear la tarea de limpieza.','Aceptar','ERROR',0);
        end;

      form_TareasLimpieza.ObtenerTareas;
      form_DetallesCama.Actualizar(form_DetallesCama.camasidCama.asinteger);
      Close;
    end
  else
    begin
      datos.VerMensaje('Error','Debe indicar el motivo por el cual solicita limpieza.','Aceptar','ERROR',0);
    end;
end;

procedure Tform_Limpieza.botonSalirClick(Sender: TObject);
begin
  Close;
end;

end.
