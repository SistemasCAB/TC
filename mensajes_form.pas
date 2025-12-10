unit mensajes_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  Tform_mensajes = class(TForm)
    lyIconos: TLayout;
    lyMain: TLayout;
    iconoOk: TImage;
    iconoError: TImage;
    iconoInfo: TImage;
    lyTitulo: TLayout;
    lbTitulo: TLabel;
    separador: TRectangle;
    lyTexto: TLayout;
    lyBotones: TLayout;
    lbTexto: TLabel;
    Rectangle2: TRectangle;
    lbTextoBoton: TLabel;
    Rectangle1: TRectangle;
    reloj: TTimer;
    procedure Rectangle2Click(Sender: TObject);
    procedure relojTimer(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; Titulo, Mensaje,TextoBoton, Icono:string; tiempo:integer);
  end;

var
  form_mensajes: Tform_mensajes;

implementation

{$R *.fmx}

constructor Tform_mensajes.Create(AOwner: TComponent; Titulo, Mensaje, TextoBoton, Icono: string; tiempo:integer);
var
  mseg:integer;
begin
  inherited create(AOwner);

  lbTitulo.Text := Titulo;
  lbTexto.Text := Mensaje;
  lbTextoBoton.Text := TextoBoton;

  if Icono = 'OK' then
    begin
      iconoOk.Visible     := true;
      iconoError.Visible  := false;
      iconoInfo.Visible   := false;
    end;

  if Icono = 'ERROR' then
    begin
      iconoOk.Visible     := false;
      iconoError.Visible  := true;
      iconoInfo.Visible   := false;
    end;

  if Icono = 'INFO' then
    begin
      iconoOk.Visible     := false;
      iconoError.Visible  := false;
      iconoInfo.Visible   := true;
    end;

  if tiempo > 1 then
    begin
      mseg := tiempo * 1000;
      reloj.Interval := mseg;
      reloj.Enabled := true;
    end
  else
    begin
      reloj.Enabled := false;
    end;
end;

procedure Tform_mensajes.Rectangle2Click(Sender: TObject);
begin
  Close;
end;

procedure Tform_mensajes.relojTimer(Sender: TObject);
begin
  Close;
end;

end.
