unit Configuracion_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.TabControl, FMX.StdCtrls, FMX.Effects, FMX.Controls.Presentation,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.DBScope,
  FMX.ListBox, FMX.Edit;

type
  Tform_Configuracion = class(TForm)
    Formulario: TRectangle;
    contenedorPrincipal: TLayout;
    recTitulo: TRectangle;
    lbTitulo: TLabel;
    pagina: TTabControl;
    tabServicios: TTabItem;
    tabConexion: TTabItem;
    listaServicios: TListView;
    SpeedButton1: TSpeedButton;
    serviciosCli: TRESTClient;
    serviciosReq: TRESTRequest;
    serviciosRes: TRESTResponse;
    serviciosDSA: TRESTResponseDataSetAdapter;
    servicios: TFDMemTable;
    serviciosid_servicio: TWideStringField;
    serviciosnombreServicio: TWideStringField;
    serviciostipo_internacion: TWideStringField;
    servicioscambioCama_areaCerrada: TWideStringField;
    serviciosid_tipoInternacion: TWideStringField;
    serviciosTipoInternacion: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    contenedorTabServicios: TLayout;
    Layout1: TLayout;
    Layout3: TLayout;
    botonActualizarServicio: TRectangle;
    Label4: TLabel;
    botonActualizarServicios: TSpeedButton;
    Layout5: TLayout;
    Layout6: TLayout;
    Label6: TLabel;
    areaCerrada: TSwitch;
    Label5: TLabel;
    Layout7: TLayout;
    botonGuardar: TRectangle;
    Label7: TLabel;
    SpeedButton5: TSpeedButton;
    Layout8: TLayout;
    Rectangle4: TRectangle;
    Label8: TLabel;
    serviciosBotonQuitar: TSpeedButton;
    Rectangle7: TRectangle;
    Label11: TLabel;
    serviciosBotonAgregar: TSpeedButton;
    ListBox1: TListBox;
    listaCamasDisponibles: TListBox;
    Layout9: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    edt_nombreServicio: TEdit;
    botonEliminar: TRectangle;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    fichaCamas: TTabItem;
    HABITACIONES: TTabItem;
    TabItem3: TTabItem;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    camasCli: TRESTClient;
    camasReq: TRESTRequest;
    camasRes: TRESTResponse;
    camasDSA: TRESTResponseDataSetAdapter;
    camas: TFDMemTable;
    camasid_cama: TWideStringField;
    camascama: TWideStringField;
    camasid_habitacion: TWideStringField;
    camashabitacion: TWideStringField;
    procedure botonSalirClick(Sender: TObject);
    procedure paginaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ActualizarServicios;
    procedure botonActualizarServiciosClick(Sender: TObject);
    procedure ActualizarCamasDisponibles;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure listaServiciosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure edt_nombreServicioChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_Configuracion: Tform_Configuracion;

implementation

{$R *.fmx}

uses form_Tablero, mensajes_form, ModuloDatos, UFunciones;

procedure Tform_Configuracion.ActualizarCamasDisponibles;
var
  mens:string;
begin
  TThread.CreateAnonymousThread(procedure
    begin
      try
        // me conecto a la API del TC (10.99.8.107) para obtener las camas. Esta API se conecta a Markey para obtenter los datos de las camas.
        camasCli.BaseURL := datos.urlTC + '/camas/obtenerCamas';
        camasReq.Params.ParameterByName('TokenAcceso').Value        := datos.tokenAcceso;
        camasReq.Params.ParameterByName('idServicio').Value         := datos.servicio.ToString;
        camasReq.Params.ParameterByName('tareasPendientes').Value   := datos.pendientes.ToString;
        camasReq.Params.ParameterByName('idEstado').Value          := inttostr(0);
        camasReq.Execute;

        if camasRes.StatusCode = 200 then
          begin
            if camas.RecordCount > 0 then
              begin
                TThread.Synchronize(nil, procedure
                  begin
                    listaCamasDisponibles.Enabled := false;
                    serviciosBotonQuitar.Enabled := false;




                  end);
              end
            else
              begin
                datos.VerMensaje('No hay camas para vizualisar','Verifique que los filtros aplicados sean los correctos y que el tablero esté configurado para el servicio correcto.','Aceptar','INFO',0);
              end;
          end
        else
          begin
            listaCamasDisponibles.Enabled := false;
            mens := 'El servicio web '+ camasCli.BaseURL +' ha retornado status code ' + inttostr(camasRes.StatusCode);
            datos.VerMensaje('ERROR' + camasRes.StatusCode.ToString ,mens,'Aceptar','ERROR',0);
          end;

      except
        on E: Exception do
          begin
            datos.VerMensaje('ERROR','No se pudo completar el proceso de actualizar las camas que supervisa este servicio.','Aceptar','ERROR',0);
          end;
      end;
    end
  ).Start;


//  if camasMarkeyRes.StatusCode = 200 then
//    begin
//      listaCamasDisponibles.Enabled := true;
//
//      camasDisponibles.Close;
//      camasMarkey.First;
//      repeat
//        camasDisponibles.Append;
//        camasDisponiblesid_cama.Value       := camasMarkeyid_cama.AsInteger;
//        camasDisponiblescama.Value          := camasMarkeycama.AsString;
//        camasDisponiblesid_habitacion.Value := camasMarkeyid_habitacion.AsInteger;
//        camasDisponibleshabitacion.Value    := camasMarkeyhabitacion.AsString;
//        camasMarkey.Next;
//      until (camasMarkey.Eof);
//    end
//  else
//    begin
//      listaCamasDisponibles.Enabled := false;
//      datos.VerMensaje('Error' + camasMarkeyRes.StatusCode.ToString,'No se pudo acceder a la API de Markey'  ,'Aceptar','error')
//    end;

end;

procedure Tform_Configuracion.ActualizarServicios;
begin
  serviciosCli.BaseURL                                      := datos.urlTC;
  serviciosReq.Resource                                     := 'servicios/ver';
  serviciosReq.Params.ParameterByName('TokenAcceso').Value  := datos.tokenAcceso;
  serviciosReq.Execute;

  if serviciosRes.StatusCode = 200 then
    begin
      listaServicios.Enabled := true;
    end
  else
    begin
      listaServicios.Enabled := false;
      datos.VerMensaje('Error',servicios.Fields[1].AsString  ,'Aceptar','error',0)
    end;
end;

procedure Tform_Configuracion.botonActualizarServiciosClick(Sender: TObject);
begin
  ActualizarServicios;
end;

procedure Tform_Configuracion.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_Configuracion.edt_nombreServicioChange(Sender: TObject);
begin
  showmessage('ver camas de ' + serviciosnombreServicio.AsString);
end;

procedure Tform_Configuracion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  formTablero.ActualizarCamas;
end;

procedure Tform_Configuracion.FormCreate(Sender: TObject);
begin
  lbTitulo.Text := 'CONFIGURACIÓN -> ' + pagina.Tabs[0].Text;
  ActualizarServicios;
end;

procedure Tform_Configuracion.listaServiciosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
//  edt_nombreServicio.Text := serviciosnombreServicio.AsString;
//  if servicioscambioCama_areaCerrada.AsInteger = 1 then
//    areaCerrada.IsChecked := true
//  else
//    areaCerrada.IsChecked := false;
end;

procedure Tform_Configuracion.paginaChange(Sender: TObject);
begin
  lbTitulo.Text := 'CONFIGURACIÓN - ' + pagina.Tabs[pagina.TabIndex].Text;
end;

procedure Tform_Configuracion.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

end.
