unit AutorizacionesPendientes_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Effects, FMX.StdCtrls, FMX.TabControl, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  RESTRequest4D,DataSet.Serialize.Adapter.RESTRequest4D,
  System.JSON;

type
  Tform_AutorizacionesPendientes = class(TForm)
    FondoTransparente: TRectangle;
    FORMULARIO: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    Layout1: TLayout;
    pagina: TTabControl;
    tabOpciones: TTabItem;
    Rectangle7: TRectangle;
    botonInternaciones: TRectangle;
    Label17: TLabel;
    SpeedButton6: TSpeedButton;
    Label25: TLabel;
    botonCambioCama: TRectangle;
    Label26: TLabel;
    btn_AutorizarCambioCama: TSpeedButton;
    Label29: TLabel;
    tabCambioCamas: TTabItem;
    Rectangle2: TRectangle;
    circuloInternaciones: TRectangle;
    lb_CantInternaciones: TLabel;
    circuloCambios: TRectangle;
    lb_CantCambios: TLabel;
    tabInternaciones: TTabItem;
    contenedor: TScrollBox;
    pacientes: TFDMemTable;
    pendientes: TFDMemTable;
    pendientesidCamaCambiosPendientes: TIntegerField;
    pendientesidSolicitudCambio: TIntegerField;
    pendientesidCamaDestino: TIntegerField;
    pendientescamaDestino: TStringField;
    pendientespaciCodigo: TIntegerField;
    pendientespaciente: TStringField;
    pendientesidInternacion: TIntegerField;
    pendientesidCamaOrigen: TIntegerField;
    pendientescamaOrigen: TStringField;
    pendientesaislamientos: TMemoField;
    pacientesidCama: TIntegerField;
    pacientescama: TStringField;
    pacientespaciCodigo: TIntegerField;
    pacientespaciente: TStringField;
    pacientestdocCodigo: TIntegerField;
    pacientesnroDocumento: TStringField;
    pacientessexo: TStringField;
    pacientesidInternacion: TIntegerField;
    pacientesaislamientos: TMemoField;
    pendientestdocCodigo: TIntegerField;
    pendientesnroDocumento: TStringField;
    pendientessexo: TStringField;
    ly_pendiente1: TLayout;
    recAutorizar1: TRectangle;
    ly_datos: TLayout;
    Label20: TLabel;
    ly_datosPaciente: TLayout;
    ly_aislamientos: TLayout;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    lb_nombrePaciente: TLabel;
    lb_documentoPaciente: TLabel;
    botonAutorizar: TRectangle;
    Label30: TLabel;
    SpeedButton10: TSpeedButton;
    Image31: TImage;
    Rectangle10: TRectangle;
    Label28: TLabel;
    SpeedButton9: TSpeedButton;
    Image30: TImage;
    recCama1: TRectangle;
    Layout7: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Rectangle1: TRectangle;
    recCama2: TRectangle;
    Layout6: TLayout;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Label5: TLabel;
    Layout8: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Rectangle4: TRectangle;
    pendientesidHabitacion: TIntegerField;
    pendientestipoDocumento: TStringField;
    procedure botonSalirClick(Sender: TObject);
    procedure btn_AutorizarCambioCamaClick(Sender: TObject);
    procedure ActualizarPendientes;
    procedure FormActivate(Sender: TObject);
    procedure mostrarCambiosDeCamaPendientes;
    procedure ActualizarPacientesHabitacion(idHabitacion:integer);
  private
    { Private declarations }
    procedure clicBotonAutorizar(sender:TObject);
    procedure clicBotonNoAutorizar(sender:TObject);
  public
    { Public declarations }
  end;

var
  form_AutorizacionesPendientes: Tform_AutorizacionesPendientes;

implementation

{$R *.fmx}

uses ModuloDatos, UFunciones, FMX.Image.Base64, constantes;

procedure Tform_AutorizacionesPendientes.ActualizarPacientesHabitacion(idHabitacion: integer);
var
  response:IResponse;
  recurso : String;
begin
  recurso := '/tablerocamas/pacientesHabitacion';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idHabitacion',idHabitacion.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(pacientes))
              .Get;

  if response.StatusCode <> 200 then
    begin
        datos.VerMensaje('Error ' + response.StatusCode.ToString,'El endpoint ' + recurso + ' ha respondido con status code ' + response.StatusCode.ToString,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_AutorizacionesPendientes.ActualizarPendientes;
var
  response:IResponse;
  recurso : String;
begin
  recurso := '/tablerocamas/camasCambiosPendientes';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(pendientes))
              .Get;

  // Re-parsear solo aislamientos
  var JsonRoot := TJSONObject.ParseJSONValue(response.Content) as TJSONArray;

  for var i := 0 to pendientes.RecordCount - 1 do
  begin
    pendientes.RecNo := i + 1;

    pendientes.Edit;

    var Obj := JsonRoot.Items[i] as TJSONObject;
    var arr := Obj.GetValue<TJSONArray>('aislamientos');

    if Assigned(arr) then
      pendientes.FieldByName('aislamientos').AsString := arr.ToJSON
    else
      pendientes.FieldByName('aislamientos').Clear;

    pendientes.Post;
  end;



  if response.StatusCode = 200 then
    begin
      if pendientes.RecordCount > 0 then
        begin
          botonCambioCama.Enabled := true;
          circuloCambios.Visible := true;

          mostrarCambiosDeCamaPendientes;

        end
      else
        begin
          circuloCambios.Visible := false;
          botonCambioCama.Enabled := false;
        end;

      lb_CantCambios.Text := pendientes.RecordCount.ToString;
    end
  else
    begin
        datos.VerMensaje('Error ' + response.StatusCode.ToString,'El endpoint ' + recurso + ' ha respondido con status code ' + response.StatusCode.ToString,'Aceptar','ERROR',0);
    end;
end;

procedure Tform_AutorizacionesPendientes.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_AutorizacionesPendientes.btn_AutorizarCambioCamaClick(
  Sender: TObject);
begin
  pagina.TabIndex := 1;
  tituloVentana.Text := 'CANBIOS DE CAMA A AUTORIZAR';
end;

procedure Tform_AutorizacionesPendientes.clicBotonAutorizar(sender: TObject);
var
  idCamasCambiosPendientes: integer;
begin
  idCamasCambiosPendientes := (sender as TSpeedButton).Tag;

  showmessage('Autorizar: ' + idCamasCambiosPendientes.ToString);
end;

procedure Tform_AutorizacionesPendientes.clicBotonNoAutorizar(sender: TObject);
var
  idCamasCambiosPendientes: integer;
begin
  idCamasCambiosPendientes := (sender as TSpeedButton).Tag;

  showmessage('No Autorizar: ' + idCamasCambiosPendientes.ToString);
end;

procedure Tform_AutorizacionesPendientes.FormActivate(Sender: TObject);
begin
  ActualizarPendientes;
end;

procedure Tform_AutorizacionesPendientes.mostrarCambiosDeCamaPendientes;
var
  ly_pendientes, ly_datos, ly_datosPaciente, ly_aislamientos:TLayout;
  recAutorizar,botonAutorizar, botonNoAutorizar:TRectangle;
  lbNroCama, lb_nombrePaciente, lb_documentoPaciente, lb_textoBotonAutorizar, lb_textoBotonNoAutorizar: TLabel;
  iconoBotonAutorizar, iconoBotonNoAutorizar: TImage;
  btnAutorizar, btnNoAutorizar:TSpeedButton;

  JsonValue: TJSONValue;
  JsonArray: TJSONArray;
  JsonObject: TJSONObject;
  i:integer;
begin
  contenedor.Destroy;
  contenedor := TScrollBox.Create(Rectangle2);
  contenedor.Parent := Rectangle2;
  contenedor.Name := 'contenedor';
  contenedor.Align := TAlignLayout.Client;
  contenedor.ShowScrollBars := true;

  // ly_pendientes
  pendientes.First;
  repeat
    // obtengo los datos de los pacientes que están en esta habitación
    ActualizarPacientesHabitacion(pendientesidHabitacion.AsInteger);

    ly_pendientes := TLayout.Create(Self);
    ly_pendientes.Parent := contenedor;
    ly_pendientes.Name := 'ly_pendientes' + pendientesidCamaCambiosPendientes.AsString;
    ly_pendientes.Align := TAlignLayout.Top;
    ly_pendientes.HitTest := false;
    ly_pendientes.Margins.Top := 25;
    ly_pendientes.Margins.Bottom := 0;
    ly_pendientes.Margins.Left := 0;
    ly_pendientes.Margins.Right := 0;
    ly_pendientes.Height := 85 + (53 * pacientes.RecordCount);

    // Rectangulo autorizar (borde azul)
    recAutorizar := TRectangle.Create(Self);
    recAutorizar.Parent := ly_pendientes;
    recAutorizar.Name := 'recAutorizar'+ pendientesidCamaCambiosPendientes.AsString;
    recAutorizar.Align := TAlignLayout.Top;
    recAutorizar.Height := 85;
    recAutorizar.HitTest := false;
    recAutorizar.Fill.Color := TAlphaColorRec.Whitesmoke;
    recAutorizar.Stroke.Kind := TbrushKind.Solid;
    recAutorizar.Stroke.Color := TAlphaColor(StrToAlphaColor('#00558C'));
    recAutorizar.Stroke.Thickness := 2;

    // Layout Datos del paciente y de la cama
    ly_datos := TLayout.Create(Self);
    ly_datos.Parent := recAutorizar;
    ly_datos.Name := 'ly_datos' + pendientesidCamaCambiosPendientes.AsString;
    ly_datos.Align := TAlignLayout.Left;
    ly_datos.HitTest := false;
    ly_datos.Width := 412;

    // Número de Cama
    lbNroCama := TLabel.Create(Self);
    with lbNroCama do
      begin
        Parent := ly_datos;
        Name := 'lbNroCama'+ pendientesidCamaCambiosPendientes.AsString;
        Align := TAlignLayout.Left;
        Width := 88;
        StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        TextSettings.Font.Size := 18;
        TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
        TextSettings.HorzAlign := TTextAlign.Center;
        TextSettings.VertAlign := TTextAlign.Center;
        Text := pendientescamaDestino.AsString;
        HitTest := false;
      end;

    // Layout Datos del paciente
    ly_datosPaciente := TLayout.Create(Self);
    ly_datosPaciente.Parent := ly_datos;
    ly_datosPaciente.Name := 'ly_datosPaciente' + pendientesidCamaCambiosPendientes.AsString;
    ly_datosPaciente.Align := TAlignLayout.Left;
    ly_datosPaciente.HitTest := false;
    ly_datosPaciente.Width := 324;

    // Nombre del paciente
    lb_nombrePaciente := TLabel.Create(Self);
    with lb_nombrePaciente do
      begin
        Parent := ly_datosPaciente;
        Name := 'lb_nombrePaciente'+ pendientesidCamaCambiosPendientes.AsString;
        Align := TAlignLayout.Top;
        Width := 17;
        StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
        //TextSettings.Font.Size := 18;
        TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
        Text := pendientespaciente.AsString;
        HitTest := false;
      end;

    // Documento del paciente
    lb_documentoPaciente := TLabel.Create(Self);
    with lb_documentoPaciente do
      begin
        Parent := ly_datosPaciente;
        Name := 'lb_documentoPaciente'+ pendientesidCamaCambiosPendientes.AsString;
        Align := TAlignLayout.Top;
        Width := 17;
        Text :=  pendientestipoDocumento.AsString + ' ' + pendientesnroDocumento.AsString + '    Sexo: ' + pendientessexo.AsString;
        HitTest := false;
      end;

    // Layout Aislamientos
    ly_aislamientos := TLayout.Create(Self);
    ly_aislamientos.Parent := ly_datosPaciente;
    ly_aislamientos.Name := 'ly_aislamientos' + pendientesidCamaCambiosPendientes.AsString;
    ly_aislamientos.Align := TAlignLayout.Client;
    ly_aislamientos.HitTest := false;

    //Aislamientos

    JsonArray := TJSONObject.ParseJSONValue(pendientesaislamientos.AsString) as TJSONArray;

    if Assigned(JsonArray) then
    begin
      try
        for i := 0 to JsonArray.Count - 1 do
          begin
            JsonValue := JsonArray.Items[i];
            JsonObject := JsonValue as TJSONObject;

            // Obtener valores
            var idPacienteAislamiento := JsonObject.GetValue<Integer>('idPacienteAislamiento');
            var idAislamiento := JsonObject.GetValue<Integer>('idAislamiento');
            //var breve := JsonObject.GetValue<string>('breve');
            var kpc := JsonObject.GetValue<Integer>('kpc');

            // muestro el ícono del aislamiento
            // Ícono Aislamiento
            with TImage.Create(Self) do
              begin
                Parent := ly_aislamientos;
                Height := 50;
                Align := TAlignLayout.Left;
                Name := 'iconoAislamiento'+ idPacienteAislamiento.ToString +  pendientesidCamaCambiosPendientes.AsString;
                WrapMode := TImageWrapMode.Fit;
                HitTest := false;
                case idAislamiento of
                  1: begin
                    if kpc = 1 then
                      Base64(aislamientoKPC)
                    else
                      Base64(aislamientoAC);
                  end;

                  2: begin
                    Base64(aislamientoAR);
                  end;

                  3: begin
                    Base64(aislamientoAG);
                  end;
                  4: begin
                    Base64(aislamientoAN);
                  end;
                  5: begin
                    Base64(aislamientoCD);
                  end;
                  6: begin
                    Base64(aislamientoSC);
                  end;
                end;
              end;
          end;
      finally
        JsonArray.Free;
      end;
    end;

    // botón Autorizar - fondo azul
    botonAutorizar := TRectangle.Create(Self);
    botonAutorizar.Parent := recAutorizar;
    botonAutorizar.Name := 'botonAutorizar'+ pendientesidCamaCambiosPendientes.AsString;
    botonAutorizar.Align := TAlignLayout.None;
    botonAutorizar.Height := 55;
    botonAutorizar.Width := 110;
    botonAutorizar.HitTest := false;
    botonAutorizar.Fill.Color := TAlphaColor(StrToAlphaColor('#00558C'));
    botonAutorizar.Stroke.Kind := TbrushKind.None;
    botonAutorizar.Position.X := 425;
    botonAutorizar.Position.Y := 18;
    botonAutorizar.XRadius := 5;
    botonAutorizar.YRadius := 5;

    // icono del botón autorizar (check)
    iconoBotonAutorizar := TImage.Create(Self);
    iconoBotonAutorizar.Parent := botonAutorizar;
    iconoBotonAutorizar.Name := 'iconoBotonAutorizar' + pendientesidCamaCambiosPendientes.AsString;
    iconoBotonAutorizar.Align := TalignLayout.Left;
    iconoBotonAutorizar.Width := 38;
    iconoBotonAutorizar.WrapMode := TImageWrapMode.Fit;
    iconoBotonAutorizar.Base64(iconoCheckBlanco);
    iconoBotonAutorizar.HitTest := false;

    // Texto del botón autorizar
    lb_textoBotonAutorizar := TLabel.Create(Self);
    with lb_textoBotonAutorizar do
      begin
        Parent := botonAutorizar;
        Name := 'lb_textoBotonAutorizar'+ pendientesidCamaCambiosPendientes.AsString;
        Align := TAlignLayout.Client;
        Text :=  'Autorizar Cambio';
        HitTest := false;
        StyledSettings := [TStyledSetting.Family];
        TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
        TextSettings.HorzAlign := TTextAlign.Center;
        TextSettings.FontColor := TAlphaColorRec.Whitesmoke;
      end;

    // boton TSpeedButton
    btnAutorizar := TSpeedButton.Create(Self);
    btnAutorizar.Parent := botonAutorizar;
    btnAutorizar.Name := 'btnAutorizar' + pendientesidCamaCambiosPendientes.AsString;
    btnAutorizar.Align := TAlignLayout.Contents;
    btnAutorizar.Hint := 'Autorizar este cambio de cama';
    btnAutorizar.Text := '';
    btnAutorizar.Tag := pendientesidCamaCambiosPendientes.AsInteger;
    btnAutorizar.OnClick := clicBotonAutorizar;


    // botón No Autorizar - fondo azul
    botonNoAutorizar := TRectangle.Create(Self);
    botonNoAutorizar.Parent := recAutorizar;
    botonNoAutorizar.Name := 'botonNoAutorizar'+ pendientesidCamaCambiosPendientes.AsString;
    botonNoAutorizar.Align := TAlignLayout.None;
    botonNoAutorizar.Height := 55;
    botonNoAutorizar.Width := 110;
    botonNoAutorizar.HitTest := false;
    botonNoAutorizar.Fill.Color := TAlphaColor(StrToAlphaColor('#00558C'));
    botonNoAutorizar.Stroke.Kind := TbrushKind.None;
    botonNoAutorizar.Position.X := 549;
    botonNoAutorizar.Position.Y := 18;
    botonNoAutorizar.XRadius := 5;
    botonNoAutorizar.YRadius := 5;

    // icono del botón no autorizar (check)
    iconoBotonNoAutorizar := TImage.Create(Self);
    iconoBotonNoAutorizar.Parent := botonNoAutorizar;
    iconoBotonNoAutorizar.Name := 'iconoBotonNoAutorizar' + pendientesidCamaCambiosPendientes.AsString;
    iconoBotonNoAutorizar.Align := TalignLayout.Left;
    iconoBotonNoAutorizar.Width := 38;
    iconoBotonNoAutorizar.WrapMode := TImageWrapMode.Fit;
    iconoBotonNoAutorizar.Base64(iconoBlock);
    iconoBotonNoAutorizar.HitTest := false;

    // Texto del botón no autorizar
    lb_textoBotonNoAutorizar := TLabel.Create(Self);
    with lb_textoBotonNoAutorizar do
      begin
        Parent := botonNoAutorizar;
        Name := 'lb_textoBotonNoAutorizar'+ pendientesidCamaCambiosPendientes.AsString;
        Align := TAlignLayout.Client;
        Text :=  'No Autorizar Cambio';
        HitTest := false;
        StyledSettings := [TStyledSetting.Family];
        TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
        TextSettings.HorzAlign := TTextAlign.Center;
        TextSettings.FontColor := TAlphaColorRec.Whitesmoke;
      end;

    // boton TSpeedButton
    btnNoAutorizar := TSpeedButton.Create(Self);
    btnNoAutorizar.Parent := botonNoAutorizar;
    btnNoAutorizar.Name := 'btnNoAutorizar' + pendientesidCamaCambiosPendientes.AsString;
    btnNoAutorizar.Align := TAlignLayout.Contents;
    btnNoAutorizar.Hint := 'No autorizar este cambio de cama';
    btnNoAutorizar.Text := '';
    btnNoAutorizar.Tag := pendientesidCamaCambiosPendientes.AsInteger;
    btnNoAutorizar.OnClick := clicBotonNoAutorizar;








    pendientes.Next;
  until pendientes.eof;


end;

end.
