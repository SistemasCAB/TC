unit mensajeConfirmacion_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Ani;

type
  Tform_mensajeConfirmacion = class(TForm)
    Rectangle1: TRectangle;
    lyMain: TLayout;
    lyTitulo: TLayout;
    lbTitulo: TLabel;
    separador: TRectangle;
    lyTexto: TLayout;
    lbTexto: TLabel;
    lyBotones: TLayout;
    botonNo: TRectangle;
    lbTextoBotonNo: TLabel;
    lyIconos: TLayout;
    iconoPregunta: TImage;
    botonSi: TRectangle;
    lbTextoBotonSi: TLabel;
    FondoTransparente: TRectangle;
    iconoWarning: TImage;
    FloatAnimation1: TFloatAnimation;
    procedure botonSiClick(Sender: TObject);
    procedure botonNoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
//    constructor Create(AOwner: TComponent; Titulo, Mensaje,BotonSi, BotonNo:string);
  end;

var
  form_mensajeConfirmacion: Tform_mensajeConfirmacion;

implementation

{$R *.fmx}

//constructor Tform_mensajeConfirmacion.Create(AOwner: TComponent; Titulo, Mensaje, BotonSi, BotonNo: string);
//begin
//  inherited create(AOwner);
//
//  lbTitulo.Text       := Titulo;
//  lbTexto.Text        := Mensaje;
//  lbTextoBotonSi.Text := BotonSi;
//  lbTextoBotonNo.Text := BotonNo;
//end;

procedure Tform_mensajeConfirmacion.botonNoClick(Sender: TObject);
begin
  form_mensajeConfirmacion.ModalResult := 7; // mrNo
end;

procedure Tform_mensajeConfirmacion.botonSiClick(Sender: TObject);
begin
  form_mensajeConfirmacion.ModalResult := 6; // mrYes
end;

end.
