unit TareaRepracionCrear_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Effects, FMX.StdCtrls, FMX.ListView, FMX.TabControl, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tform_TareaRepracionCrear = class(TForm)
    Rectangle1: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    Layout1: TLayout;
    pagina: TTabControl;
    tabSolicitar: TTabItem;
    Rectangle3: TRectangle;
    botonSolicitar: TRectangle;
    Label6: TLabel;
    btnSolicitarAutorizacion: TSpeedButton;
    Image1: TImage;
    Label3: TLabel;
    Label5: TLabel;
    lyCambioACamaVirtual: TLayout;
    Label13: TLabel;
    Rectangle4: TRectangle;
    lb_botonCambioVirtual: TLabel;
    SpeedButton4: TSpeedButton;
    Image2: TImage;
    Label17: TLabel;
    tabMotivosCambio: TTabItem;
    Rectangle5: TRectangle;
    Label19: TLabel;
    listaMotivos: TListView;
    botonFinalizarNuevaSolicitud: TRectangle;
    Label21: TLabel;
    Label22: TLabel;
    btn_NuevaSolicitud: TSpeedButton;
    tabSolicitud: TTabItem;
    Rectangle2: TRectangle;
    Label4: TLabel;
    recBotonCambiarCama: TRectangle;
    Label7: TLabel;
    Label11: TLabel;
    botonCambiarCama: TSpeedButton;
    botonCancelarCambio: TRectangle;
    Label9: TLabel;
    Label10: TLabel;
    btn_CancelarSolicitudCambio: TSpeedButton;
    lb_fecha_solicitud: TLabel;
    Label1: TLabel;
    lb_solicitado_por: TLabel;
    Label14: TLabel;
    lb_idSolicitud: TLabel;
    Label15: TLabel;
    lb_motivo: TLabel;
    rectCambioCama: TRectangle;
    CalloutPanel1: TCalloutPanel;
    lb_cama_origen: TLabel;
    Label28: TLabel;
    sombra: TShadowEffect;
    Label16: TLabel;
    lb_estadoSolicitud: TLabel;
    Label18: TLabel;
    lb_autorizadoFecha: TLabel;
    Label20: TLabel;
    lb_autorizadoNombre: TLabel;
    Label23: TLabel;
    lb_cama_destino: TLabel;
    tabCambioVirtual: TTabItem;
    tabTipoCambio: TTabItem;
    Rectangle6: TRectangle;
    recCambioInterno: TRectangle;
    lb_botonCambioInterno: TLabel;
    botonCambioInterno: TSpeedButton;
    Label29: TLabel;
    lb_cambioInterno: TLabel;
    recCambioExterno: TRectangle;
    lb_botonCambioExterno: TLabel;
    botonCambioExterno: TSpeedButton;
    lb_cambioExterno: TLabel;
    lyCambioVirtual: TLayout;
    Label8: TLabel;
    recCambioVirtual: TRectangle;
    Label12: TLabel;
    SpeedButton6: TSpeedButton;
    TabCambioInternoCamas: TTabItem;
    Rectangle8: TRectangle;
    Label26: TLabel;
    listaCamas: TListView;
    botonRegistrarCambioAreaCerrada: TRectangle;
    Label27: TLabel;
    SpeedButton2: TSpeedButton;
    FondoTransparente: TRectangle;
    Rectangle7: TRectangle;
    Rectangle9: TRectangle;
    Label2: TLabel;
    Image3: TImage;
    Layout2: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Rectangle10: TRectangle;
    recBotonSalir: TRectangle;
    Label24: TLabel;
    SpeedButton3: TSpeedButton;
    Image4: TImage;
    TabItem2: TTabItem;
    Rectangle13: TRectangle;
    Label34: TLabel;
    ListView1: TListView;
    Rectangle14: TRectangle;
    Label35: TLabel;
    Label36: TLabel;
    SpeedButton7: TSpeedButton;
    recBotonSiguiente: TRectangle;
    Label25: TLabel;
    botonSiguiente: TSpeedButton;
    Image5: TImage;
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_TareaRepracionCrear: Tform_TareaRepracionCrear;

implementation

{$R *.fmx}

procedure Tform_TareaRepracionCrear.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

end.
