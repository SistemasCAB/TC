unit TareasReparacion_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,

  RESTRequest4D, DataSet.Serialize.Adapter.RESTRequest4D, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FMX.Grid.Style, FMX.Grid, FMX.ScrollBox;

type
  TformTareasReparacion = class(TForm)
    FondoTransparente: TRectangle;
    Rectangle1: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    lyBotones: TLayout;
    recBotonActualizar: TRectangle;
    lb_botonActualizar: TLabel;
    botonActuazliar: TSpeedButton;
    separador1: TLayout;
    recBotonNuevaTarea: TRectangle;
    lb_botonNuevaTarea: TLabel;
    botonNuevaTarea: TSpeedButton;
    Image1: TImage;
    Image2: TImage;
    ly_Tareas: TLayout;
    tareas: TFDMemTable;
    tareasidTarea: TIntegerField;
    tareasfecha: TStringField;
    tareasidCama: TIntegerField;
    tareascama: TStringField;
    tareashabitacion: TStringField;
    tareaspiso: TStringField;
    tareascamaEnAislamiento: TIntegerField;
    tareasestadoCama: TStringField;
    tareassexoPaciente: TStringField;
    tareassolicitadaPorDni: TStringField;
    tareassolicitadaPorNombre: TStringField;
    tareasidServicioSolicita: TIntegerField;
    tareasnombreServicio: TStringField;
    tareasiniciada: TStringField;
    tareasiniciadaPorDni: TStringField;
    tareasiniciadaPorNombre: TStringField;
    tareascancelada: TStringField;
    tareascanceladaPorDni: TStringField;
    tareascanceladaPorNombre: TStringField;
    tareasidEstadoTareas: TIntegerField;
    tareasestado: TStringField;
    tareasidReparacion: TIntegerField;
    tareasreparacion: TStringField;
    tareasidCategoria: TIntegerField;
    tareascategoria: TStringField;
    tareasinhabilitaHab: TIntegerField;
    tareaslimpiezaPosterior: TIntegerField;
    tareasbloqueaCama: TIntegerField;
    tareasidPrioridad: TIntegerField;
    tareasprioridad: TStringField;
    tareasticket: TIntegerField;
    tareasdetalleTicket: TMemoField;
    procedure botonSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ObtenerTareas;
    procedure botonActuazliarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure botonNuevaTareaClick(Sender: TObject);
  private
    { Private declarations }
    FGrilla    : TStringGrid;
    FMemTable  : TFDMemTable;
    procedure GrillaCellDblClick(const Column: TColumn; const Row: Integer);  // Doble Click sobre la fila de la grilla.
  public
    { Public declarations }
    idCama:integer;
    procedure ActualizarTareas(MemTable: TFDMemTable);
  end;

var
  formTareasReparacion: TformTareasReparacion;

implementation

{$R *.fmx}

uses TareasReparacionDetalle_form, ModuloDatos, form_Tablero,
  TareaRepracionCrear_form;

// --------------------------------
//  Constantes de la grilla
// --------------------------------
const
  COL_HEADERS: array[0..8] of string = (
    'ID Tarea', 'Reparación', 'Estado', 'Prioridad', 'Solicitada el', 'Solicitada por',
    'Iniciada el', 'Iniciada por',
    'Ticket'
  );
  COL_WIDTHS: array[0..8] of Integer = (
    70, 200, 110, 90,
    110, 140, 110, 140,
    90
  );
  // Nombres de los campos en el FDMemTable "tareas"
  FIELD_NAMES: array[0..8] of string = (
    'idTarea', 'reparacion', 'estado','prioridad','fecha', 'solicitadaPorNombre',
    'iniciada', 'iniciadaPorNombre',
    'ticket'
  );



// -------------------------------------------------------------
//  ActualizarTareas – carga o recarga los datos en la grilla
//  Parámetro: el FDMemTable "tareas" ya poblado con datos
// -------------------------------------------------------------
procedure TformTareasReparacion.ActualizarTareas(MemTable: TFDMemTable);
var
  Row : Integer;
  I   : Integer;
begin
  if not Assigned(MemTable) then Exit;
  // Guardar referencia para usarla en el evento CellClick
  FMemTable := MemTable;
  FGrilla.BeginUpdate;
  try
    FGrilla.RowCount := MemTable.RecordCount;
    MemTable.DisableControls;
    try
      MemTable.First;
      Row := 0;
      while not MemTable.Eof do
      begin
        for I := 0 to High(FIELD_NAMES) do
          FGrilla.Cells[I, Row] := MemTable.FieldByName(FIELD_NAMES[I]).AsString;
        MemTable.Next;
        Inc(Row);
      end;
    finally
      MemTable.EnableControls;
    end;
  finally
    FGrilla.EndUpdate;
  end;
  // Seleccionar el primer registro si la tabla tiene datos
  if MemTable.RecordCount > 0 then
  begin
    FGrilla.Selected   := 0;   // selecciona la fila 0 (primer registro)
    FGrilla.SetFocus;          // le da el foco a la grilla para que la selección sea visible
  end;
end;


procedure TformTareasReparacion.botonActuazliarClick(Sender: TObject);
begin
  ObtenerTareas;
end;

procedure TformTareasReparacion.botonNuevaTareaClick(Sender: TObject);
begin
  Application.CreateForm(Tform_TareaRepracionCrear, form_TareaRepracionCrear);
  form_TareaRepracionCrear.idCama := idCama;
  form_TareaRepracionCrear.ShowModal;
end;

procedure TformTareasReparacion.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TformTareasReparacion.GrillaCellDblClick(const Column: TColumn; const Row: Integer);
begin
  if not Assigned(FMemTable) then Exit;
  if FMemTable.RecordCount = 0 then Exit;
  if Row < 0 then Exit;
  FMemTable.RecNo := Row + 1;
  Application.CreateForm(Tform_TareasReparacionDetalle, form_TareasReparacionDetalle);
  form_TareasReparacionDetalle.idTarea := tareasidTarea.AsInteger;
  form_TareasReparacionDetalle.Height := formTablero.Height;
  form_TareasReparacionDetalle.width := formTablero.width;
  form_TareasReparacionDetalle.ShowModal;
end;

procedure TformTareasReparacion.FormActivate(Sender: TObject);
begin
    ObtenerTareas;
end;

procedure TformTareasReparacion.FormCreate(Sender: TObject);
var
  Col : TStringColumn;
  I   : Integer;
begin
  // Texto de los botones
  lb_botonActualizar.Text := 'Actualizar' +#13+'Tareas';
  lb_botonNuevaTarea.Text := 'Nueva' +#13+'Tarea';

  // Crear TStringGrid dinámicamente dentro de ly_Tareas
  FGrilla             := TStringGrid.Create(Self);
  FGrilla.Parent      := ly_Tareas;
  FGrilla.Align       := TAlignLayout.Client;
  FGrilla.ReadOnly    := True;
  FGrilla.RowHeight   := 26;
  FGrilla.Options     := FGrilla.Options
                           + [TGridOption.Header]      // muestra encabezados
                           + [TGridOption.RowSelect]   // selección de fila completa
                           - [TGridOption.Editing];    // sin edición inline
  //FGrilla.OnCellClick := GrillaCellClick;
  FGrilla.OnCellClick    := nil;              // un clic solo selecciona, sin acción extra
  FGrilla.OnCellDblClick := GrillaCellDblClick;
  // Crear columnas
  for I := 0 to High(COL_HEADERS) do
  begin
    Col          := TStringColumn.Create(FGrilla);
    Col.Header   := COL_HEADERS[I];
    Col.Width    := COL_WIDTHS[I];
    Col.ReadOnly := True;
    FGrilla.AddObject(Col);
  end;
end;

procedure TformTareasReparacion.ObtenerTareas;
var
  response: IResponse;
  recurso: string;
begin
  recurso := '/tablerocamas/tareasCama';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idTipoTarea','2') // solo tareas de reparacion
              .AddParam('idCama',idCama.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(tareas))
              .Get;

  if response.StatusCode = 200 then
    begin
      ActualizarTareas(tareas);
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,'No fue posible obtener las tareas de reparación de esta cama' + #13 + 'Endpoint: ' + recurso,'Aceptar','ERROR',0);
    end;
end;

end.
