unit Aislamientos_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Data.DB,
  Data.Win.ADODB,
  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Layouts, FMX.StdCtrls, FMX.Objects,
  FMX.Controls.Presentation, FMX.TabControl, FMX.ListBox, FMX.DateTimeCtrls,
  FMX.Edit, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TformAislamiento = class(TForm)
    FondoTransparente: TRectangle;
    formulario: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    pagina: TTabControl;
    tabAislamientos: TTabItem;
    Layout3: TLayout;
    botonNuevoAislamiento: TRectangle;
    lbBtnNuevoAislamiento: TLabel;
    btnNuevoAislamiento: TSpeedButton;
    tabNuevoAislamiento: TTabItem;
    Layout2: TLayout;
    botonCancelar: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    btnCancelar: TSpeedButton;
    botonGrabar: TRectangle;
    Label6: TLabel;
    Label7: TLabel;
    btnGrabar: TSpeedButton;
    Label8: TLabel;
    disponibles: TFDMemTable;
    disponiblesbreve: TStringField;
    disponiblescolor: TStringField;
    resultado: TFDMemTable;
    resultadoestado: TIntegerField;
    resultadomensaje: TStringField;
    contenedor: TScrollBox;
    Layout1: TLayout;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    lyAislamiento: TLayout;
    lbTitulo: TLabel;
    lbFechas: TLabel;
    lyBoton: TLayout;
    recBoton: TRectangle;
    iconoBoton: TImage;
    botonEliminar: TSpeedButton;
    lbEstado: TLabel;
    separador1: TRectangle;
    icono: TImage;
    disponiblesidAislamiento: TIntegerField;
    disponiblesnombreAislamiento: TStringField;
    BindingsList1: TBindingsList;
    Layout4: TLayout;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    LinkListControlToField1: TLinkListControlToField;
    Image2: TImage;
    botonSalir: TSpeedButton;
    Image3: TImage;
    procedure ActualizarAislamientos();
    procedure crearAislamiento(id, idAislamiento, kpc: integer; FechaDesde: string);
    procedure FormActivate(Sender: TObject);
    procedure noHayAislamientos;
    procedure FormCreate(Sender: TObject);
    procedure btnNuevoAislamientoClick(Sender: TObject);
    procedure ActualizarDisponibles(idInternacion: integer);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure botonSalirClick(Sender: TObject);
  private
    { Private declarations }
    procedure clicBotonEliminar(sender:TObject);
  public
    { Public declarations }
    lyAislamientos,lyBtn: TLayout;
    recBtn:TRectangle;
    idInternacion: integer;
    alto, ancho: integer;
  end;

var
  formAislamiento: TformAislamiento;

implementation

{$R *.fmx}

uses ModuloDatos, FMX.Image.Base64,constantes, UFunciones, DetallesCama_form;

{ TformAislamiento }

procedure TformAislamiento.ActualizarAislamientos();
begin
    contenedor.Destroy;
    contenedor := TScrollBox.Create(tabAislamientos);
    contenedor.Parent := tabAislamientos;
    contenedor.Name := 'contenedor';
    contenedor.Align := TAlignLayout.Client;
    contenedor.ShowScrollBars := true;

    if form_DetallesCama.aislamientos.RecordCount >= 1 then
      begin
        form_DetallesCama.aislamientos.First;
        repeat
          crearAislamiento(
                form_DetallesCama.aislamientosidPacienteAislamiento.AsInteger,
                form_DetallesCama.aislamientosidAislamiento.AsInteger,
                form_DetallesCama.aislamientoskpc.AsInteger,
                form_DetallesCama.aislamientosfechaDesde.AsString
          );
          form_DetallesCama.aislamientos.Next;
        until form_DetallesCama.aislamientos.eof;
      end
    else
      begin
        noHayAislamientos;
      end;
end;

procedure TformAislamiento.ActualizarDisponibles(idInternacion: integer);
var
  response: IResponse;
  apiRecurso : string;
begin
  apiRecurso := '/tablerocamas/aislamientosDisponibles/' + idInternacion.ToString;
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(disponibles))
              .Get;

  if response.StatusCode = 200 then
    begin
      if disponibles.recordcount = 0 then
        begin
          // el paciente ya tiene todos los aislamientos posibles.
          botonGrabar.Enabled := false;
          pagina.TabIndex := 0;
          datos.VerMensaje('Error','El paciente ya tiene asignados todos los tipos de aislamientos posibles.','Aceptar','ERROR',0);
        end
      else
        begin
          botonGrabar.Enabled := true;
        end;
    end;
end;

procedure TformAislamiento.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TformAislamiento.btnCancelarClick(Sender: TObject);
begin
  ActualizarAislamientos();
  pagina.TabIndex := 0;
end;

procedure TformAislamiento.btnGrabarClick(Sender: TObject);
var
  response: IResponse;
  apiRecurso : string;
  body : string;
  kpc: string;
begin
  apiRecurso := '/tablerocamas/agregarAislamiento';

  if disponiblesidAislamiento.AsInteger = 1 then // si es aislamiento de contacto, pregunto si es kpc
    begin
      if datos.MensajeConfirmacion('¿KPC?','¿Este aislamiento de contacto es por KPC?','Si, es KPC','No','pregunta',ancho,alto) = 6 then
        kpc := '1'
      else
        kpc := '0';
    end
  else
    begin
      kpc := '0';
    end;



  body := '{"idAislamiento":'+ disponiblesidAislamiento.AsString +',"idInternacion":'+form_DetallesCama.camasidInternacion.AsString+',"paciCodigo":'+ form_DetallesCama.camaspaciCodigo.AsString +',"creadoPorDni":"'+ datos.dniLogin +'","creadoPorNombre":"'+ datos.nombreLogin +'","kpc":"'+ kpc +'"}';

  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .AddBody(body)
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Post;

  if response.StatusCode = 200 then
    begin
      datos.VerMensaje('Aislamiento agregado',resultadomensaje.AsString,'Aceptar','OK',0);
      form_DetallesCama.Actualizar(form_DetallesCama.camasidCama.AsInteger);
      ActualizarAislamientos();
      pagina.TabIndex := 0;
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadomensaje.AsString,'Aceptar','ERROR',0);
    end;
end;

procedure TformAislamiento.btnNuevoAislamientoClick(Sender: TObject);
begin
  pagina.TabIndex := 1;
  ActualizarDisponibles(idInternacion);
end;

procedure TformAislamiento.clicBotonEliminar(sender: TObject);
var
  id:integer;
  mensaje:string;
  response: IResponse;
  recurso : string;
  body:string;
begin
  id := (sender as TSpeedButton).Tag;

  mensaje:= '¿Está seguro que desea finalizar este aislamiento?';
  if datos.MensajeConfirmacion('Confirme su decisión',mensaje,'Si. Estoy seguro','Cancelar','WARNING',ancho,alto) = 6 then
    begin
      //  finalizar aislamiento.
      recurso := '/tablerocamas/finalizarAislamiento';

      body := '{'+
                  '"idPacienteAislamiento":'+ id.ToString +','+
                  '"finalizadoPorDni":"'+ datos.dniLogin +'",'+
                  '"finalizadoPorNombre":"'+ datos.nombreLogin +'"'+
              '}';

      response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .AddBody(body)
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Post;

      if response.StatusCode = 200 then
        datos.VerMensaje('Aislamiento finalizado',resultadomensaje.AsString,'Aceptar','OK',0)
      else
        datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadomensaje.AsString,'Aceptar','ERROR',0);

      form_DetallesCama.Actualizar(form_DetallesCama.camasidCama.AsInteger);
      ActualizarAislamientos();
      pagina.TabIndex := 0;
    end;
end;

procedure TformAislamiento.crearAislamiento(id, idAislamiento, kpc: integer; FechaDesde: string);
begin
  // Contenedor del aislamiento
  lyAislamientos := TLayout.Create(contenedor);
  lyAislamientos.Parent := contenedor;
  lyAislamientos.Height := 85;
  lyAislamientos.Name := 'lyAislamiento' + id.ToString;
  lyAislamientos.Align := TAlignLayout.Top;
  lyAislamientos.HitTest := false;
  lyAislamientos.Margins.Top := 10;
  lyAislamientos.Margins.Bottom := 10;
  lyAislamientos.Margins.Left := 10;
  lyAislamientos.Margins.Right := 10;

  // separador
  with TRectangle.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Align := TAlignLayout.Bottom;
      Name := 'separador'+ id.ToString;
      Fill.Color := TAlphaColorRec.Lightseagreen;
      Stroke.Kind := TbrushKind.None;
      Height := 2;
    end;

  // ícono
  with TImage.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Align := TAlignLayout.Left;
      Name := 'iconoAislamiento'+ id.ToString;
      WrapMode := TImageWrapMode.Center;
      case idAislamiento of
          1:begin
            if form_DetallesCama.aislamientoskpc.AsInteger = 1 then
              Base64(aislamientoKPC)
            else
              Base64(aislamientoAC);
          end;
          2:Base64(aislamientoAR);
          3:Base64(aislamientoAG);
          4:Base64(aislamientoAN);
          5:Base64(aislamientoCD);
          6:Base64(aislamientoSC);
      end;
      HitTest := false;
    end;

  lyBtn := TLayout.Create(lyAislamientos);
  lyBtn.Parent := lyAislamientos;
  lyBtn.Name := 'lyBtn' + id.ToString;
  lyBtn.Align := TAlignLayout.Right;
  lyBtn.Margins.Top := 15;
  lyBtn.Margins.Bottom := 15;
  lyBtn.Margins.Left := 15;




  if form_DetallesCama.aislamientosestado.AsString = 'Vigente' then
    begin
      recBtn := TRectangle.Create(lyBtn);
      recBtn.Parent := lyBtn;
      recBtn.Name := 'recBtn' + id.ToString;
      recBtn.Align := TAlignLayout.Client;
      recBtn.Fill.Color := TAlphaColorRec.Red;
      recBtn.Stroke.Kind := TbrushKind.None;
      recBtn.Width := 55;
      recBtn.CornerType := TCornerType.Round;
      recBtn.Corners := [TCorner.TopLeft,TCorner.TopRight,TCorner.BottomLeft,TCorner.BottomRight];
      recBtn.XRadius := 5;
      recBtn.YRadius := 5;

      // ícono del botón
      with TImage.Create(recBtn) do
        begin
          Parent := recBtn;
          Align := TAlignLayout.Client;
          Name := 'iconoBoton'+ id.ToString;
          WrapMode := TImageWrapMode.Center;
          Base64(iconoEliminar);
          HitTest := false;
        end;

      // botón Eliminar aislamiento
      with TSpeedButton.Create(recBtn) do
        begin
          Parent := recBtn;
          Align := TAlignLayout.Client;
          Name := 'botonEliminar'+ id.ToString;
          Tag := id;
          Text := '';
          ShowHint := true;
          Hint := 'Finalizar este aislamiento';
          onClick := clicBotonEliminar;
        end;
    end;



  // Titulo
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'lbTitulo'+ id.ToString;
      if form_DetallesCama.aislamientoskpc.AsInteger = 1 then
        Text := form_DetallesCama.aislamientosnombre.AsString + '    KPC'
      else
        Text := form_DetallesCama.aislamientosnombre.AsString;
      Height := 17;
      Width := 380;
      Position.X := 75;
      Position.Y := 8;
      StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
      TextSettings.Font.Size := 14;
      TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
    end;


  // Fechas desde y hasta
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'lbFechas'+ id.ToString;
      Text := 'Desde: ' + form_DetallesCama.aislamientosfechaDesde.AsString + '      Hasta: ' + form_DetallesCama.aislamientosfechaHasta.AsString;
      Height := 17;
      Width := 476;
      Position.X := 85;
      Position.Y := 30;
    end;

  // Estado
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'lbEstado'+ id.ToString;
      if form_DetallesCama.aislamientosestado.AsString = 'Finalizado' then
        Text := 'Estado: Finalizado por ' + form_DetallesCama.aislamientosfinalizadoPorNombre.AsString + ' el '+ form_DetallesCama.aislamientosfechaHasta.AsString
      else
        Text := 'Estado: ' + form_DetallesCama.aislamientosestado.AsString;
      Height := 32;
      Width := 476;
      Position.X := 85;
      Position.Y := 49;
      TextSettings.WordWrap := true;
    end;
end;

procedure TformAislamiento.FormActivate(Sender: TObject);
begin
  ActualizarAislamientos();
end;

procedure TformAislamiento.FormCreate(Sender: TObject);
begin
  lbBtnNuevoAislamiento.Text := 'Nuevo' + #13 + 'Aislamiento';
  pagina.TabIndex := 0;

  alto := form_DetallesCama.Height;
  ancho := form_DetallesCama.Width;
end;

procedure TformAislamiento.noHayAislamientos;
begin
  // Contenedor del aislamieno
  lyAislamientos := TLayout.Create(contenedor);
  lyAislamientos.Parent := contenedor;
  lyAislamientos.Height := 85;
  lyAislamientos.Width := 373;
  lyAislamientos.Name := 'lyInfo1';
  lyAislamientos.Align := TAlignLayout.Center;
  lyAislamientos.HitTest := false;
  lyAislamientos.Margins.Top := 10;
  lyAislamientos.Margins.Bottom := 10;
  lyAislamientos.Margins.Left := 10;
  lyAislamientos.Margins.Right := 10;

  // ícono
  with TImage.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Align := TAlignLayout.Left;
      Name := 'iconoInfo1';
      WrapMode := TImageWrapMode.Center;
      Base64(iconoInfo);
      HitTest := false;
    end;

  // Titulo
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'lbTituloInfo1';
      Text := 'Este paciente no tiene ningún aislamiento';
      Height := 17;
      Width := 302;
      Position.X := 67;
      Position.Y := 24;
      StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
      TextSettings.Font.Size := 14;
      TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
    end;


  // Texto
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'textoInfo1';
      Text := 'Presione el botón Nuevo Aislamiento para agregar uno';
      Height := 17;
      Width := 302;
      Position.X := 67;
      Position.Y := 49;
      TextSettings.WordWrap := true;
    end;
end;

end.
