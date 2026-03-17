unit DateTimeMaskEdit_unit;

interface

uses
  System.SysUtils, System.Classes, FMX.Edit, FMX.Types, System.UITypes;

type
  TDateTimeMaskEdit = class(TEdit)
  private
    function IsSeparator(Pos: Integer): Boolean;
    procedure FixSeparators;
  protected
    procedure KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState); override;
    procedure EditEnter(Sender: TObject);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetDateTime: TDateTime;
    procedure SetDateTime(Value: TDateTime);
  end;

implementation

{ TDateTimeMaskEdit }

constructor TDateTimeMaskEdit.Create(AOwner: TComponent);
begin
  inherited;
  Text := '__/__/____ __:__';
  CaretPosition := 0;
  MaxLength := 16;

  OnEnter := EditEnter;
end;

function TDateTimeMaskEdit.IsSeparator(Pos: Integer): Boolean;
begin
  Result := Pos in [2,5,10,13];
end;

procedure TDateTimeMaskEdit.EditEnter(Sender: TObject);
begin
  CaretPosition := 0;
end;

procedure TDateTimeMaskEdit.FixSeparators;
var
  s: string;
begin
  s := Text;

  if Length(s) < 16 then
    s := '__/__/____ __:__';

  s[3]  := '/';
  s[6]  := '/';
  s[11] := ' ';
  s[14] := ':';

  Text := s;
end;

procedure TDateTimeMaskEdit.KeyDown(var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  p: Integer;
  s: string;
begin
  p := CaretPosition;
  s := Text;

  {permitir flechas izquierda y derecha}
  if Key in [vkLeft, vkRight] then
  begin
    inherited;
    Exit;
  end;

  if Key = vkBack then
  begin
    if p > 0 then
    begin
      Dec(p);
      if IsSeparator(p) then
        Dec(p);

      if p >= 0 then
      begin
        s[p+1] := '_';
        Text := s;
        CaretPosition := p;
      end;
    end;

    Key := 0;
    Exit;
  end;

  if not CharInSet(KeyChar,['0'..'9']) then
  begin
    KeyChar := #0;
    Exit;
  end;

  if IsSeparator(p) then
    Inc(p);

  if p >= Length(s) then
  begin
    KeyChar := #0;
    Exit;
  end;



  s[p+1] := KeyChar;
  Text := s;

  CaretPosition := p + 1;

  FixSeparators;

  KeyChar := #0;
end;

procedure TDateTimeMaskEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin
  inherited;
  CaretPosition := 0;
end;

procedure TDateTimeMaskEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  inherited;
  CaretPosition := 0;
end;

function TDateTimeMaskEdit.GetDateTime: TDateTime;
begin
  if not TryStrToDateTime(Text, Result) then
    Result := 0;
end;

procedure TDateTimeMaskEdit.SetDateTime(Value: TDateTime);
begin
  Text := FormatDateTime('dd/mm/yyyy hh:nn', Value);
end;
end.
