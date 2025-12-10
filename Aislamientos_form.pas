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
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TformAislamiento = class(TForm)
    aislamientos: TFDMemTable;
    FondoTransparente: TRectangle;
    formulario: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    aislamientosid: TIntegerField;
    aislamientosdni: TStringField;
    aislamientosapellido_paciente: TStringField;
    aislamientosnombre_paciente: TStringField;
    aislamientosid_aislamiento: TIntegerField;
    aislamientosaislamiento: TStringField;
    aislamientosbreve: TStringField;
    aislamientoscolor: TStringField;
    aislamientosobservaciones: TStringField;
    aislamientosdni_usuario_alta: TStringField;
    aislamientosnombre_usuario_alta: TStringField;
    aislamientosdni_usuario_fin: TStringField;
    aislamientosnombre_usuario_fin: TStringField;
    aislamientosdesde: TStringField;
    aislamientoshasta: TStringField;
    aislamientosfecha_alta: TStringField;
    aislamientosfecha_fin: TStringField;
    pagina: TTabControl;
    tabAislamientos: TTabItem;
    Layout3: TLayout;
    botonNuevoAislamiento: TRectangle;
    lbBtnNuevoAislamiento: TLabel;
    Label5: TLabel;
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
    listaAislamientos: TComboBox;
    Label8: TLabel;
    hasta: TDateEdit;
    chk_hasta: TCheckBox;
    obs: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    disponibles: TFDMemTable;
    disponiblesid_aislamiento: TIntegerField;
    disponiblesaislamiento: TStringField;
    disponiblesbreve: TStringField;
    disponiblescolor: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
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
    lbObs: TLabel;
    separador1: TRectangle;
    icono: TImage;
    procedure ActualizarAislamientos(dni:string);
    procedure botonSalirClick(Sender: TObject);
    procedure crearAislamiento(id,id_aislamiento:integer;desde, hasta,observaciones:string);
    procedure FormActivate(Sender: TObject);
    procedure noHayAislamientos;
    procedure FormCreate(Sender: TObject);
    procedure btnNuevoAislamientoClick(Sender: TObject);
    procedure ActualizarDisponibles(dni:string);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure chk_hastaChange(Sender: TObject);
  private
    { Private declarations }
    procedure clicBotonEliminar(sender:TObject);
  public
    { Public declarations }
    lyAislamientos,lyBtn: TLayout;
    recBtn:TRectangle;
    dniPaciente: string;
    alto, ancho: integer;
  end;

var
  formAislamiento: TformAislamiento;

implementation

{$R *.fmx}

uses ModuloDatos, FMX.Image.Base64,constantes, UFunciones, DetallesCama_form;

{ TformAislamiento }

procedure TformAislamiento.ActualizarAislamientos(dni: string);
var
  response: IResponse;
  apiRecurso : string;
begin
  apiRecurso := '/aislamientos/' + dni;
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(aislamientos))
              .Get;

  if response.StatusCode = 200 then
    begin
      contenedor.Destroy;

      contenedor := TScrollBox.Create(tabAislamientos);
      contenedor.Parent := tabAislamientos;
      contenedor.Name := 'contenedor';
      contenedor.Align := TAlignLayout.Client;
      contenedor.ShowScrollBars := true;

      if aislamientos.RecordCount >= 1 then
        begin
          aislamientos.First;
          repeat
            crearAislamiento(aislamientosid.AsInteger,aislamientosid_aislamiento.AsInteger,aislamientosdesde.AsString, aislamientoshasta.AsString ,aislamientosobservaciones.AsString);
            aislamientos.Next;
          until aislamientos.eof;
        end
      else
        begin
          noHayAislamientos;
        end;


    end;
end;

procedure TformAislamiento.ActualizarDisponibles(dni: string);
var
  response: IResponse;
  apiRecurso : string;
begin
  apiRecurso := '/aislamientos/disponibles/' + dni;
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
  ActualizarAislamientos(dniPaciente);
  pagina.TabIndex := 0;
end;

procedure TformAislamiento.btnGrabarClick(Sender: TObject);
var
  response: IResponse;
  apiRecurso : string;
  fecha,fd,fm:string;
  d,m,a:Word;
begin
  apiRecurso := '/aislamientos/nuevo';

  // fecha hasta
  if chk_hasta.IsChecked then
    begin
      DecodeDate(hasta.Date,a,m,d);
      if(d < 10) then
        fd := '0'+d.ToString
      else
        fd := d.ToString;

      if(m < 10) then
        fm := '0'+ m.ToString
      else
        fm := m.ToString;

      fecha := a.ToString + '-' + fm + '-' + fd + ' 00:00:00';

      response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .AddParam('dni', dniPaciente)
              .AddParam('apellido_paciente',form_DetallesCama.camasapellido_paciente.AsString)
              .AddParam('nombre_paciente',form_DetallesCama.camasnombre_paciente.AsString)
              .AddParam('id_aislamiento',disponiblesid_aislamiento.AsString)
              .AddParam('hasta',fecha)
              .AddParam('observaciones',obs.Text)
              .AddParam('dni_usuario', datos.dniLogin)
              .AddParam('nombre_usuario',datos.nombreLogin)
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Post;
    end
  else
    begin
      response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .AddParam('dni', dniPaciente)
              .AddParam('apellido_paciente',form_DetallesCama.camasapellido_paciente.AsString)
              .AddParam('nombre_paciente',form_DetallesCama.camasnombre_paciente.AsString)
              .AddParam('id_aislamiento',disponiblesid_aislamiento.AsString)
              .AddParam('observaciones',obs.Text)
              .AddParam('dni_usuario', datos.dniLogin)
              .AddParam('nombre_usuario',datos.nombreLogin)
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Post;
    end;




  if response.StatusCode = 200 then
    begin
      datos.VerMensaje('Aislamiento agregado',resultadomensaje.AsString,'Aceptar','OK',0);
      ActualizarAislamientos(dniPaciente);
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
  chk_hasta.IsChecked := false;
  hasta.Enabled := false;
  obs.Text := '';
  ActualizarDisponibles(dniPaciente);
end;

procedure TformAislamiento.chk_hastaChange(Sender: TObject);
begin
if chk_hasta.IsChecked then
    hasta.Enabled := true
  else
    hasta.Enabled := false;
end;

procedure TformAislamiento.clicBotonEliminar(sender: TObject);
var
  id:integer;
  mensaje:string;
  response: IResponse;
  apiRecurso : string;
begin
  id := (sender as TSpeedButton).Tag;



  mensaje:= '¿Está seguro que desea finalizar este aislamiento?';
  if datos.MensajeConfirmacion('Confirme su decisión',mensaje,'Si. Estoy seguro','Cancelar','WARNING',ancho,alto) = 6 then
    begin
      //  finalizar aislamiento.
      apiRecurso := '/aislamientos/finalizar';
      response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(apiRecurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .AddParam('id', id.ToString)
              .AddParam('dni_usuario', datos.dniLogin)
              .AddParam('nombre_usuario',datos.nombreLogin)
              .Adapters(TDataSetSerializeAdapter.New(resultado))
              .Post;

      if response.StatusCode = 200 then
        datos.VerMensaje('Aislamiento finalizado',resultadomensaje.AsString,'Aceptar','OK',0)
      else
        datos.VerMensaje('Error ' + response.StatusCode.ToString ,resultadomensaje.AsString,'Aceptar','ERROR',0);

      ActualizarAislamientos(dniPaciente);
      pagina.TabIndex := 0;
    end;
end;

procedure TformAislamiento.crearAislamiento(id, id_aislamiento: integer; desde, hasta, observaciones: string);
begin
  // Contenedor del aislamieno
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
      Name := 'separador'+ aislamientosid.AsString;
      Fill.Color := TAlphaColorRec.Lightseagreen;
      Stroke.Kind := TbrushKind.None;
      Height := 2;
    end;

  // ícono
  with TImage.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Align := TAlignLayout.Left;
      Name := 'iconoAislamiento'+ aislamientosid.AsString;
      WrapMode := TImageWrapMode.Center;
      case aislamientosid_aislamiento.AsInteger of
          1:Base64(aislamientoAC);
          2:Base64(aislamientoAR);
          4:Base64(aislamientoAG);
          5:Base64(aislamientoAN);
          6:Base64(aislamientoCD);
          7:Base64(aislamientoSC);
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
      Name := 'iconoBoton'+ aislamientosid.AsString;
      WrapMode := TImageWrapMode.Center;
      Base64(iconoEliminar);
      HitTest := false;
    end;

  // botón Eliminar aislamiento
  with TSpeedButton.Create(recBtn) do
    begin
      Parent := recBtn;
      Align := TAlignLayout.Client;
      Name := 'botonEliminar'+ aislamientosid.AsString;
      Tag := aislamientosid.AsInteger;
      Text := '';
      ShowHint := true;
      Hint := 'Finalizar este aislamiento';
      onClick := clicBotonEliminar;
    end;


  // Titulo
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'lbTitulo'+ aislamientosid.AsString;
      Text := aislamientosaislamiento.AsString;
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
      Name := 'lbFechas'+ aislamientosid.AsString;
      Text := 'Desde: ' + aislamientosdesde.AsString + '      Hasta: ' + aislamientoshasta.AsString;
      Height := 17;
      Width := 476;
      Position.X := 85;
      Position.Y := 30;
    end;

  // Observaciones
  with TLabel.Create(lyAislamientos) do
    begin
      Parent := lyAislamientos;
      Name := 'lbObservaciones'+ aislamientosid.AsString;
      Text := 'Observaciones: ' + aislamientosobservaciones.AsString;
      Height := 32;
      Width := 476;
      Position.X := 85;
      Position.Y := 49;
      TextSettings.WordWrap := true;
    end;
end;

procedure TformAislamiento.FormActivate(Sender: TObject);
begin
  ActualizarAislamientos(dniPaciente);
end;

procedure TformAislamiento.FormCreate(Sender: TObject);
begin
  lbBtnNuevoAislamiento.Text := 'Nuevo' + #13 + 'Aislamiento';
  pagina.TabIndex := 0;

  alto := form_DetallesCama.Height;
  ancho := form_DetallesCama.Width;

  // fecha hasta
  hasta.DateTime := now;
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
