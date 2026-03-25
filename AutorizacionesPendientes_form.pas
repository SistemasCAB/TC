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
  FireDAC.Comp.Client;

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
    Layout3: TLayout;
    Label20: TLabel;
    Layout4: TLayout;
    Layout10: TLayout;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Layout5: TLayout;
    Label21: TLabel;
    linea2: TLabel;
    Rectangle11: TRectangle;
    Label30: TLabel;
    SpeedButton10: TSpeedButton;
    Image31: TImage;
    Rectangle10: TRectangle;
    Label28: TLabel;
    SpeedButton9: TSpeedButton;
    Image30: TImage;
    recCAma1: TRectangle;
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
    Rectangle3: TRectangle;
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
    Layout9: TLayout;
    Rectangle5: TRectangle;
    Layout11: TLayout;
    Label9: TLabel;
    Layout12: TLayout;
    Layout13: TLayout;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Layout14: TLayout;
    Label10: TLabel;
    Label11: TLabel;
    Rectangle6: TRectangle;
    Label12: TLabel;
    SpeedButton1: TSpeedButton;
    Image19: TImage;
    Rectangle8: TRectangle;
    Label13: TLabel;
    SpeedButton2: TSpeedButton;
    Image20: TImage;
    Rectangle9: TRectangle;
    Layout15: TLayout;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Label14: TLabel;
    Layout16: TLayout;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Rectangle12: TRectangle;
    Rectangle13: TRectangle;
    Layout17: TLayout;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Image38: TImage;
    Image39: TImage;
    Image40: TImage;
    Label19: TLabel;
    Layout18: TLayout;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Rectangle14: TRectangle;
    procedure botonSalirClick(Sender: TObject);
    procedure btn_AutorizarCambioCamaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_AutorizacionesPendientes: Tform_AutorizacionesPendientes;

implementation

{$R *.fmx}

procedure Tform_AutorizacionesPendientes.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_AutorizacionesPendientes.btn_AutorizarCambioCamaClick(
  Sender: TObject);
begin
  pagina.TabIndex := 1;
end;

end.
