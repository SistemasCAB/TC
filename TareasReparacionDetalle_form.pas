unit TareasReparacionDetalle_form;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  Tform_TareasReparacionDetalle = class(TForm)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idTarea :integer;
  end;

var
  form_TareasReparacionDetalle: Tform_TareasReparacionDetalle;

implementation

{$R *.fmx}

procedure Tform_TareasReparacionDetalle.FormActivate(Sender: TObject);
begin
showmessage('Tarea Nº :' + idTarea.ToString);
end;

end.
