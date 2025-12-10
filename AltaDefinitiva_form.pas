unit AltaDefinitiva_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Effects, FMX.StdCtrls, FMX.ListView, FMX.TabControl, FMX.Layouts,
  FMX.Controls.Presentation, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListBox,
  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.Win.ADODB;

type
  Tform_AltaDefinitiva = class(TForm)
    FondoTransparente: TRectangle;
    formulario: TRectangle;
    recTituloVentana: TRectangle;
    tituloVentana: TLabel;
    iconoVentana: TImage;
    botonSalir: TSpeedButton;
    Layout1: TLayout;
    panelPaciente: TRectangle;
    ShadowEffect2: TShadowEffect;
    lbTituloApellido: TLabel;
    lb_apellido: TLabel;
    lbTituloNombre: TLabel;
    lbTituloDocumento: TLabel;
    lb_nroDocumento: TLabel;
    Rectangle2: TRectangle;
    lb_tituloPaciente: TLabel;
    lb_nombre: TLabel;
    panelIndicacion: TRectangle;
    ShadowEffect4: TShadowEffect;
    lb_fechaAltaMedica: TLabel;
    Rectangle3: TRectangle;
    lb_tituloInternacion: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lb_tipoAlta: TLabel;
    botonAlta: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    btnAltaDefinitiva: TSpeedButton;
    Label6: TLabel;
    listaAltas: TComboBox;
    tipos: TFDMemTable;
    tiposid_tipoAlta: TIntegerField;
    tipostipoAlta: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    horaServidor: TFDMemTable;
    horaServidorhora: TStringField;
    alta: TFDMemTable;
    altaestado: TStringField;
    altamensaje: TStringField;
    camasMarkey: TFDMemTable;
    camasMarkeyid_cama: TWideStringField;
    camasMarkeycama: TWideStringField;
    camasMarkeyid_habitacion: TWideStringField;
    camasMarkeyhabitacion: TWideStringField;
    camasMarkeypiso: TWideStringField;
    camasMarkeypiso_texto: TWideStringField;
    camasMarkeytipocama: TWideStringField;
    camasMarkeyid_estado: TWideStringField;
    camasMarkeyestado: TWideStringField;
    camasMarkeycolor: TWideStringField;
    camasMarkeyId_Paciente: TWideStringField;
    camasMarkeynombre_paciente: TWideStringField;
    camasMarkeyapellido_paciente: TWideStringField;
    camasMarkeydni: TWideStringField;
    camasMarkeysexo: TWideStringField;
    camasMarkeyfecha_ingreso_institucion: TWideStringField;
    camasMarkeyfecha_ingreso_cama: TWideStringField;
    camasMarkeycobertura: TWideStringField;
    camasMarkeyfantasia: TWideStringField;
    camasMarkeyplan: TWideStringField;
    camasMarkeynro_afiliado: TWideStringField;
    camasMarkeyid_aislado: TWideStringField;
    camasMarkeyaislado: TWideStringField;
    camasMarkeyid_internacion: TWideStringField;
    camasMarkeyfecha_alta_medica: TWideStringField;
    camasMarkeyprofesional_alta: TWideStringField;
    camasMarkeycama_en_aislamiento: TWideStringField;
    camasMarkeyobservaciones: TWideStringField;
    camasMarkeyfoto_paciente: TWideStringField;
    camasMarkeyprocedimientos_no_cumplidos: TWideStringField;
    camasMarkeymedicacion_no_programada: TWideStringField;
    camasMarkeymedicacion_no_aplicada: TWideStringField;
    camasMarkeyaislamiento_contacto: TWideStringField;
    camasMarkeyaislamiento_gota_contacto: TWideStringField;
    camasMarkeyaislamiento_aire_respiratorio: TWideStringField;
    camasMarkeyaislamiento_proteccion: TWideStringField;
    camasMarkeyaislamiento_gotas_contacto: TWideStringField;
    camasMarkeytipo_alta_medica: TWideStringField;
    camasMarkeyacompanante: TWideStringField;
    camasMarkeyobservaciones_acompanante: TWideStringField;
    Label3: TLabel;
    lb_profesionalAlta: TLabel;
    conexion: TADOConnection;
    camasMarkey_ver: TADOQuery;
    camasMarkey_verid_cama: TIntegerField;
    camasMarkey_vercama: TStringField;
    camasMarkey_verid_habitacion: TIntegerField;
    camasMarkey_verhabitacion: TStringField;
    camasMarkey_verpiso: TStringField;
    camasMarkey_verpiso_texto: TStringField;
    camasMarkey_vertipocama: TStringField;
    camasMarkey_verid_estado: TIntegerField;
    camasMarkey_verestado: TStringField;
    camasMarkey_vercolor: TStringField;
    camasMarkey_verid_paciente: TIntegerField;
    camasMarkey_vernombre_paciente: TStringField;
    camasMarkey_verapellido_paciente: TStringField;
    camasMarkey_verdni: TStringField;
    camasMarkey_versexo: TStringField;
    camasMarkey_verfecha_ingreso_institucion: TDateTimeField;
    camasMarkey_verfecha_ingreso_cama: TDateTimeField;
    camasMarkey_vercobertura: TStringField;
    camasMarkey_verfantasia: TStringField;
    camasMarkey_verplan: TStringField;
    camasMarkey_vernro_afiliado: TStringField;
    camasMarkey_verid_aislado: TIntegerField;
    camasMarkey_veraislado: TStringField;
    camasMarkey_verid_internacion: TIntegerField;
    camasMarkey_verfecha_alta_medica: TDateTimeField;
    camasMarkey_verprofesional_alta: TStringField;
    camasMarkey_vercama_en_aislamiento: TIntegerField;
    camasMarkey_verobservaciones: TStringField;
    camasMarkey_verfoto_paciente: TMemoField;
    camasMarkey_verprocedimientos_no_cumplidos: TIntegerField;
    camasMarkey_vermedicacion_no_programada: TIntegerField;
    camasMarkey_vermedicacion_no_aplicada: TIntegerField;
    camasMarkey_veraislamiento_contacto: TDateTimeField;
    camasMarkey_veraislamiento_gota_contacto: TDateTimeField;
    camasMarkey_veraislamiento_aire_respiratorio: TDateTimeField;
    camasMarkey_veraislamiento_proteccion: TDateTimeField;
    camasMarkey_veraislamiento_gotas_contacto: TDateTimeField;
    camasMarkey_vertipo_alta_medica: TStringField;
    camasMarkey_veracompanante: TStringField;
    camasMarkey_verobservaciones_acompanante: TStringField;
    camasMarkey_borrarTodas: TADOStoredProc;
    camasActualizar: TADOStoredProc;
    camas: TADOStoredProc;
    camasid_cama: TIntegerField;
    camasid_estado: TIntegerField;
    camaslimpia: TIntegerField;
    camascama_en_aislamiento: TIntegerField;
    camastipo: TStringField;
    actualizarEstados: TADOStoredProc;
    procedure tiposAltas;
    procedure FormActivate(Sender: TObject);
    procedure botonSalirClick(Sender: TObject);
    procedure btnAltaDefinitivaClick(Sender: TObject);
    procedure ActualizarCama();
    procedure ActualizarCamasMarkey;
    procedure Actualizar;
    procedure listaAltasChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function verificarTipoAlta():boolean;
    procedure botonSalirMouseLeave(Sender: TObject);
    procedure botonSalirMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
    id_cama,soloAltaMedica,id_habitacion:integer;
    apellido,nombre,dni,fechaAlta,fechaIngresoCama,tipoAlta, profesional:string;
    ancho, alto:integer;
  end;

var
  form_AltaDefinitiva: Tform_AltaDefinitiva;

implementation

{$R *.fmx}

uses ModuloDatos, DetallesCama_form;

{ Tform_AltaDefinitiva }

procedure Tform_AltaDefinitiva.Actualizar;
begin
  lb_apellido.Text        := apellido;
  lb_nombre.Text          := nombre;
  lb_nroDocumento.Text    := dni;
  lb_fechaAltaMedica.Text := fechaAlta;
  lb_tipoAlta.Text        := tipoAlta;
  lb_profesionalAlta.Text := profesional;
  botonAlta.Enabled       := false;
end;

procedure Tform_AltaDefinitiva.ActualizarCama();
var
  response : IResponse;
begin

{
  Actualiza la cama en Markey (cambia el estado). Para ello tiene en cuenta:
  - el tipo de cama (física o virtual)
  - si hay tareas de reparación
  - si hay aislamientos en la otra cama de la habitación.

  Si la cama es puesta como disponible, borro todas las alertas que había en esa cama.
}

  response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource('/camas/actualizarEstados')
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .AddParam('id_habitacion', id_habitacion.ToString)
                          .AddParam('dni', datos.dniLogin)
                          .AddParam('nombre_usuario', datos.nombreLogin)
                          .AddParam('id_servicio',datos.servicio.ToString)
                          .Accept('application/json')
                          .Adapters(TDataSetSerializeAdapter.New(actualizarEstados))
                          .Post;


  // actualizo todas las camas desde el servidor de Markey al servidor de la CAB.
  ActualizarCamasMarkey;
end;

procedure Tform_AltaDefinitiva.ActualizarCamasMarkey;
var
  response: IResponse;
  distintos: integer;
begin
  //https://clinicaadventista.markey.com.ar/APIMarkeyCAB/api/camas/obtenercamas
  response := TRequest.New.BaseURL(datos.url + '/api/camas/obtenercamas')
                          .AddParam('APIKey', datos.APIKey)
                          .Accept('application/json')
                          .Adapters(TDataSetSerializeAdapter.New(camasMarkey))
                          .Get;

  if response.StatusCode = 200 then
    begin
      if camasMarkey.RecordCount > 0 then
        begin

          camasMarkey_ver.Active := false;
          camasMarkey_ver.Active := true;

          camasMarkey.IndexFieldNames := 'id_cama';

          if camasMarkey.RecordCount  = camasMarkey_ver.RecordCount then
            begin
              // recorro los registros para compararlos y ver si son iguales (los id_cama). Si hay al menos uno distinto,
              //borro todo y cargo todo de nuevo.
              camasMarkey.First;
              camasMarkey_ver.First;
              distintos := 0;
              repeat
                if camasMarkeyid_cama.AsInteger <> camasMarkey_verid_cama.AsInteger then
                  distintos := distintos + 1;
                camasMarkey.Next;
                camasMarkey_ver.Next
              until (camasMarkey.Eof) or (distintos > 0);

              if distintos > 0 then
                begin
                  // borro todos los registros.
                  camasMarkey_borrarTodas.ExecProc;
                end
            end
          else
            begin
              // borro todos los registros.
              camasMarkey_borrarTodas.ExecProc;
            end;



          camasMarkey.First;
          repeat
            camasActualizar.Parameters.ParamByName('@id_cama').Value := camasMarkeyid_cama.AsInteger;
            camasActualizar.Parameters.ParamByName('@cama').Value := camasMarkeycama.AsString;
            camasActualizar.Parameters.ParamByName('@id_habitacion').Value := camasMarkeyid_habitacion.AsInteger;
            camasActualizar.Parameters.ParamByName('@habitacion').Value := camasMarkeyhabitacion.AsString;
            camasActualizar.Parameters.ParamByName('@piso').Value := camasMarkeypiso.AsString;
            camasActualizar.Parameters.ParamByName('@piso_texto').Value := camasMarkeypiso_texto.AsString;
            camasActualizar.Parameters.ParamByName('@tipocama').Value := camasMarkeytipocama.AsString;
            camasActualizar.Parameters.ParamByName('@id_estado').Value := camasMarkeyid_estado.AsInteger;
            camasActualizar.Parameters.ParamByName('@estado').Value := camasMarkeyestado.AsString;
            camasActualizar.Parameters.ParamByName('@color').Value := camasMarkeycolor.AsString;
            camasActualizar.Parameters.ParamByName('@id_paciente').Value := camasMarkeyId_Paciente.AsInteger;
            camasActualizar.Parameters.ParamByName('@nombre_paciente').Value := camasMarkeynombre_paciente.AsString;
            camasActualizar.Parameters.ParamByName('@apellido_paciente').Value := camasMarkeyapellido_paciente.AsString;
            camasActualizar.Parameters.ParamByName('@dni').Value := camasMarkeydni.AsString;
            camasActualizar.Parameters.ParamByName('@sexo').Value := camasMarkeysexo.AsString;
            if camasMarkeyfecha_ingreso_institucion.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@fecha_ingreso_institucion').Value := camasMarkeyfecha_ingreso_institucion.AsString
            else
              camasActualizar.Parameters.ParamByName('@fecha_ingreso_institucion').Value := null;

            if camasMarkeyfecha_ingreso_cama.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@fecha_ingreso_cama').Value := camasMarkeyfecha_ingreso_cama.AsString
            else
              camasActualizar.Parameters.ParamByName('@fecha_ingreso_cama').Value := null;

            camasActualizar.Parameters.ParamByName('@cobertura').Value := camasMarkeycobertura.AsString;
            camasActualizar.Parameters.ParamByName('@fantasia').Value := camasMarkeyfantasia.AsString;
            camasActualizar.Parameters.ParamByName('@plan').Value := camasMarkeyplan.AsString;
            camasActualizar.Parameters.ParamByName('@nro_afiliado').Value := camasMarkeynro_afiliado.AsString;
            camasActualizar.Parameters.ParamByName('@id_aislado').Value := camasMarkeyid_aislado.AsInteger;
            camasActualizar.Parameters.ParamByName('@aislado').Value := camasMarkeyaislado.AsString;
            camasActualizar.Parameters.ParamByName('@id_internacion').Value := camasMarkeyid_internacion.AsInteger;

            if camasMarkeyfecha_alta_medica.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@fecha_alta_medica').Value := camasMarkeyfecha_alta_medica.AsString
            else
              camasActualizar.Parameters.ParamByName('@fecha_alta_medica').Value := null;

            camasActualizar.Parameters.ParamByName('@profesional_alta').Value := camasMarkeyprofesional_alta.AsString;

            if camasMarkeycama_en_aislamiento.AsBoolean = true then
              camasActualizar.Parameters.ParamByName('@cama_en_aislamiento').Value := 1
            else
              camasActualizar.Parameters.ParamByName('@cama_en_aislamiento').Value := 0;

            camasActualizar.Parameters.ParamByName('@observaciones').Value := camasMarkeyobservaciones.AsString;
            camasActualizar.Parameters.ParamByName('@foto_paciente').Value := camasMarkeyfoto_paciente.AsString;
            camasActualizar.Parameters.ParamByName('@procedimientos_no_cumplidos').Value := camasMarkeyprocedimientos_no_cumplidos.AsInteger;
            camasActualizar.Parameters.ParamByName('@medicacion_no_programada').Value := camasMarkeymedicacion_no_programada.AsInteger;
            camasActualizar.Parameters.ParamByName('@medicacion_no_aplicada').Value := camasMarkeymedicacion_no_aplicada.AsInteger;

            if camasMarkeyaislamiento_contacto.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@aislamiento_contacto').Value := camasMarkeyaislamiento_contacto.AsString
            else
              camasActualizar.Parameters.ParamByName('@aislamiento_contacto').Value := null;

            if camasMarkeyaislamiento_gota_contacto.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@aislamiento_gota_contacto').Value := camasMarkeyaislamiento_gota_contacto.AsString
            else
              camasActualizar.Parameters.ParamByName('@aislamiento_gota_contacto').Value := null;

            if camasMarkeyaislamiento_aire_respiratorio.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@aislamiento_aire_respiratorio').Value := camasMarkeyaislamiento_aire_respiratorio.AsString
            else
              camasActualizar.Parameters.ParamByName('@aislamiento_aire_respiratorio').Value := null;

            if camasMarkeyaislamiento_proteccion.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@aislamiento_proteccion').Value := camasMarkeyaislamiento_proteccion.AsString
            else
              camasActualizar.Parameters.ParamByName('@aislamiento_proteccion').Value := null;

            if camasMarkeyaislamiento_gotas_contacto.AsString <> '' then
              camasActualizar.Parameters.ParamByName('@aislamiento_gotas_contacto').Value := camasMarkeyaislamiento_gotas_contacto.AsString
            else
              camasActualizar.Parameters.ParamByName('@aislamiento_gotas_contacto').Value := null;

            camasActualizar.Parameters.ParamByName('@tipo_alta_medica').Value := camasMarkeytipo_alta_medica.AsString;
            camasActualizar.Parameters.ParamByName('@acompanante').Value := camasMarkeyacompanante.AsString;
            camasActualizar.Parameters.ParamByName('@observaciones_acompanante').Value := camasMarkeyobservaciones_acompanante.AsString;

            camasActualizar.ExecProc;

            camasMarkey.Next;
          until (camasMarkey.Eof);
        end;
    end;
end;

procedure Tform_AltaDefinitiva.botonSalirClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_AltaDefinitiva.botonSalirMouseLeave(Sender: TObject);
begin
  botonSalir.FontColor := TAlphaColorRec.White;
end;

procedure Tform_AltaDefinitiva.botonSalirMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  botonSalir.FontColor := TAlphaColorRec.Red;
end;

procedure Tform_AltaDefinitiva.btnAltaDefinitivaClick(Sender: TObject);
var
  fechaEgreso :string;
  response,response2 :IResponse;
  url,mensaje:string;
begin

  if soloAltaMedica = 1 then
    begin
      fechaEgreso := form_DetallesCama.camasfecha_ingreso_cama.AsString;
    end
  else
    begin
      response := TRequest.New.BaseURL(datos.urlTC)
                          .Resource('/aplicacion/horaServidor')
                          .AddHeader('TokenAcceso', datos.tokenAcceso)
                          .Accept('application/json')
                          .Adapters(TDataSetSerializeAdapter.New(horaServidor))
                          .Get;

      if response.StatusCode = 200 then
        begin

          // ejecuto el alta en Markey
          {
           Si la cama en la que está el paciente es una cama soloAltaMedica (virtuales para alta médica), entonces la fecha de egreso
           debe ser la fecha en la que el paciente ingresó a la cama actual.
           Si es otra cama, la fecha de egreso será la fecha y hora actual.
          }

          if soloAltaMedica = 1 then // es una cama soloAltaMedica
            fechaEgreso := fechaIngresoCama
          else
            fechaEgreso := horaServidorhora.AsString;

          if verificarTipoAlta() then
            begin
              response2 := TRequest.New.BaseURL(datos.url + '/api/altaDefinitiva')
                                      .AddParam('APIKey', datos.APIKey)
                                      .AddParam('Id_Paciente',form_DetallesCama.camasid_paciente.AsString)
                                      .AddParam('id_tipoAlta',tiposid_tipoAlta.AsString)
                                      .AddParam('id_internacion',form_DetallesCama.camasid_internacion.AsString)
                                      .AddParam('id_Usuario', datos.dniLogin)
                                      .AddParam('fecha_hora_alta',fechaEgreso)
                                      .Accept('application/json')
                                      .Adapters(TDataSetSerializeAdapter.New(alta))
                                      .Post;

              if response2.StatusCode = 200 then
                begin
                  // Actualizo la cama al estado que le corresponda.
                  ActualizarCama;

                  datos.VerMensaje('ALTA EXITOSA',altamensaje.AsString,'Aceptar','OK',0);

                  form_DetallesCama.Cerrar;
                  Close;
                end
              else
                begin
                  datos.VerMensaje('ERROR ' + response2.StatusCode.ToString ,altamensaje.AsString,'Aceptar','ERROR',0);
                end;
            end;
        end
      else
        begin
          mensaje := 'No es posible conectarse a la API del Tablero de Camas' + #13 + 'WS: '+ datos.urlTC + '/aplicacion/horaServidor';
          datos.VerMensaje('ERROR ' + response.StatusCode.ToString ,mensaje,'Aceptar','ERROR',0);
        end;
    end;
end;

procedure Tform_AltaDefinitiva.FormActivate(Sender: TObject);
begin
  tiposAltas;
end;

procedure Tform_AltaDefinitiva.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  conexion.Connected := false;
end;

procedure Tform_AltaDefinitiva.FormCreate(Sender: TObject);
begin
  alto := form_DetallesCama.Height;
  ancho := form_DetallesCama.Width;

  try
    conexion.Connected := false;
    conexion.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ datos.passwordBD +';Persist Security Info=True;User ID='+ datos.usuarioBD +';Initial Catalog='+ datos.baseDatos +';Data Source=' + datos.servidorSQL;
    conexion.Connected := true;
  except
    datos.VerMensaje('ERROR DE CONEXIÓN','No fue posible conectarse a la base de datos: ' + datos.baseDatos,'Aceptar','ERROR',0);
  end;
end;

procedure Tform_AltaDefinitiva.listaAltasChange(Sender: TObject);
begin
  botonAlta.Enabled := true;
end;

procedure Tform_AltaDefinitiva.tiposAltas;
var
  response: IResponse;
begin
  response := TRequest.New.BaseURL(datos.url+ '/api/tiposAlta?APIKey=d5e75bde-205b-4468-86ec-67e7160bad2e')
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(tipos))
              .Get;
end;

function Tform_AltaDefinitiva.verificarTipoAlta: boolean;
var
  resultado : boolean;
  mensaje :string;
begin
  // devuelve true si se puede avanzar con el alta del paciente, ya sea porque el tipo de alta indicado por el médico es igual
  // al que el operador seleccionó o porque el operador decidió avanzar con el tipo de alta elegido aunque no coincida
  // con el que indicó el médico.

  if tipostipoAlta.AsString <> tipoAlta then
    begin
      // el tipo de alta no coincide con la que indicó el médico.
      mensaje := 'El tipo de alta seleccionado, "' + tipostipoAlta.AsString + '" no coincide con el tipo de alta indicada por el médico' + #13 +#13 + '¿Desea continuar de todos modos?';
      if datos.MensajeConfirmacion('EL TIPO DE ALTA NO COINCIDE',mensaje,'Continuar con el Alta','Cancelar','PREGUNTA',ancho,alto) = 6 then
        resultado := true
      else
        resultado := false;
    end
  else
    resultado := true;

  if resultado then
    begin
      mensaje:= 'Está a punto de dar el alta a este paciente. Esto significa que esta internación se finalizará y ya no se podrá registrar nada más en esta internación.';
      mensaje := mensaje + #13+#13+ '¿Está seguro del alta?';
      if datos.MensajeConfirmacion('Confirme su decisión',mensaje,'Si. Estoy seguro','Cancelar','WARNING',ancho,alto) = 6 then
        verificarTipoAlta := resultado
      else
        verificarTipoAlta := false;
    end;
end;

end.
