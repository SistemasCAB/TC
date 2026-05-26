unit FiltrarCamas_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, FMX.Effects,
  FMX.ListView, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Layouts,
  RESTRequest4D,DataSet.Serialize.Adapter.RESTRequest4D;

type
  TformFiltrarCamas = class(TForm)
    FondoTransparente: TRectangle;
    Formulario: TRectangle;
    recTitulo: TRectangle;
    lbTitulo: TLabel;
    botonSalir: TSpeedButton;
    Image3: TImage;
    ShadowEffect1: TShadowEffect;
    estados: TFDMemTable;
    estadosidEstado: TIntegerField;
    estadosestado: TStringField;
    estadoscolor: TStringField;
    recEstado1: TRectangle;
    rec_etiquetaColor: TRectangle;
    lb_estado: TLabel;
    lb_cantidad: TLabel;
    botonEstado1: TSpeedButton;
    estadoscantidad: TIntegerField;
    contenedor: TLayout;
    procedure botonSalirClick(Sender: TObject);
    procedure actualizarEstados;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure clicBotonFiltrar(sender:TObject);
  public
    { Public declarations }
  end;

var
  formFiltrarCamas: TformFiltrarCamas;

implementation

{$R *.fmx}

uses ModuloDatos, UFunciones, form_Tablero;

procedure TformFiltrarCamas.actualizarEstados;
var
  response :IResponse;
  recurso: string;

  recEstado, recEtiquetaColor:TRectangle;


begin
  // Obtengo los estados
  recurso := '/tablerocamas/estadosCamas';
  response := TRequest.New.BaseURL(datos.urlTC)
              .Resource(recurso)
              .AddHeader('TokenAcceso', datos.tokenAcceso)
              .AddParam('idServicio',datos.servicio.ToString)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(estados))
              .Get;

  if response.StatusCode = 200 then
    begin
      // mostrar los estados

      contenedor.Destroy;
      contenedor := TLayout.Create(Self);
      contenedor.Parent := Formulario;
      contenedor.Name := 'contenedor';
      contenedor.Align := TAlignLayout.Client;

      estados.First;



      repeat
        // rectangulo Estado
        recEstado := TRectangle.Create(Self);
        recEstado.Parent := contenedor;
        recEstado.Height := 71;
        recEstado.Name := 'recEstado' + estadosidEstado.AsString;
        recEstado.Align := TAlignLayout.Top;
        recEstado.HitTest := false;
        recEstado.Margins.Top := 5;
        recEstado.Margins.Bottom := 0;
        recEstado.Margins.Left := 0;
        recEstado.Margins.Right := 0;
        recEstado.Fill.Color := TAlphaColorRec.Whitesmoke;
        recEstado.Stroke.Kind := TbrushKind.None;

        // rectangulo Etiqueta color
        recEtiquetaColor := TRectangle.Create(Self);
        recEtiquetaColor.Parent := recEstado;
        recEtiquetaColor.Width := 15;
        recEtiquetaColor.Name := 'recEtiquetaColor' + estadosidEstado.AsString;
        recEtiquetaColor.Align := TAlignLayout.Left;
        recEtiquetaColor.HitTest := false;
        recEtiquetaColor.Stroke.Kind := TbrushKind.None;
        recEtiquetaColor.Fill.Color := StrToAlphaColor(estadoscolor.AsString);

        // cantidad
        with TLabel.Create(Self) do
          begin
            Parent := recEstado;
            Name := 'lbCantidad'+ estadosidEstado.AsString;
            Text := estadoscantidad.AsString;
            Align := TAlignLayout.Right;
            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
            TextSettings.Font.Size := 18;
            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
            width := 73;
          end;

        // estado
        with TLabel.Create(Self) do
          begin
            Parent := recEstado;
            Name := 'lbEstado'+ estadosidEstado.AsString;
            Text := estadosestado.AsString;
            Align := TAlignLayout.Client;
            StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
            TextSettings.Font.Size := 16;
            TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
            Margins.Left := 15;
          end;

        // botón
        with TSpeedButton.Create(Self) do
          begin
            Parent := recEstado;
            Align := TAlignLayout.Contents;
            Name := 'botonSeleccionar'+ estadosidEstado.AsString;
            Tag := estadosidEstado.AsInteger;
            Text := '';
            ShowHint := true;
            Hint := 'Ver camas ' + estadosestado.AsString;
            onClick := clicBotonFiltrar;
            if estadoscantidad.AsInteger > 0 then
              Enabled := true
            else
              Enabled := false;
          end;

        estados.Next;
      until estados.Eof;

      // rectangulo Estado
      recEstado := TRectangle.Create(Self);
      recEstado.Parent := contenedor;
      recEstado.Height := 71;
      recEstado.Name := 'recEstado0';
      recEstado.Align := TAlignLayout.Top;
      recEstado.HitTest := false;
      recEstado.Margins.Top := 5;
      recEstado.Margins.Bottom := 0;
      recEstado.Margins.Left := 0;
      recEstado.Margins.Right := 0;
      recEstado.Fill.Color := TAlphaColorRec.Whitesmoke;
      recEstado.Stroke.Kind := TbrushKind.None;


      // estado
      with TLabel.Create(Self) do
        begin
          Parent := recEstado;
          Name := 'lbEstado0';
          Text := 'Ver todas las camas';
          Align := TAlignLayout.Client;
          //StyledSettings := [TStyledSetting.Family, TStyledSetting.FontColor];
          StyledSettings := [TStyledSetting.Family];
          TextSettings.Font.Size := 16;
          TextSettings.HorzAlign := TTextAlign.Center;
          TextSettings.Font.Style := Font.Style + [TFontStyle.fsBold];
          TextSettings.FontColor := TAlphaColorRec.Red;
          Margins.Left := 15;

        end;

      // botón
      with TSpeedButton.Create(Self) do
        begin
          Parent := recEstado;
          Align := TAlignLayout.Contents;
          Name := 'botonSeleccionar0';
          Tag := 0;
          Text := '';
          ShowHint := true;
          Hint := 'Ver todas las camas ';
          onClick := clicBotonFiltrar;
          Enabled := true
        end;
    end
  else
    begin
      datos.VerMensaje('Error ' + response.StatusCode.ToString, 'El endpoint ' + datos.urlTC + recurso + ' ha retornado el status code ' + response.StatusCode.ToString ,'Aceptar','error',0)
    end;
end;

procedure TformFiltrarCamas.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TformFiltrarCamas.clicBotonFiltrar(sender:TObject);
begin
  formTablero.filtroEstadoCamas := (sender as TSpeedButton).Tag;
  formTablero.ActualizarCamas;
  Close;
end;

procedure TformFiltrarCamas.FormActivate(Sender: TObject);
begin
  actualizarEstados;
end;

end.
