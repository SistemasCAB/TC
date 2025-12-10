unit FMX.Image.Base64;

interface

uses
  System.Classes, System.NetEncoding, FMX.Objects, FMX.GIFImage;

type
  TImageHelper = class helper for TImage
    function Base64 : String; overload;
    procedure Base64(str64:string) overload;
  end;

  TGIFImageHelper = class helper for TGIFImage
    function GifToBase64 : String;
    procedure LoadFromBase64(str64:string);
  end;

implementation

{ TImageHelper }

function TImageHelper.Base64: String;
var
  Input, Output : TStringStream;
begin
  Input := TStringStream.Create;
  Output := TStringStream.Create;

  try
    Self.Bitmap.SaveToStream(Input);
    Input.Position := 0;
    TNetEncoding.Base64.Encode(Input,Output);
    Output.Position := 0;
    Result := Output.DataString;
  finally
    Input.Free;
    Output.Free;
  end;
end;

procedure TImageHelper.Base64(str64: string);
var
  Input, Output : TStringStream;
begin
  Input := TStringStream.Create(str64);
  Output := TStringStream.Create;

  try
    Input.Position := 0;
    TNetEncoding.Base64.Decode(Input,Output);
    Output.Position := 0;
    Self.Bitmap.LoadFromStream(Output);
  finally
    Input.Free;
    Output.Free;
  end;
end;

{ TGIFImageHelper }

function TGIFImageHelper.GifToBase64: String;
var
  Input, Output : TStringStream;
begin
  Input := TStringStream.Create;
  Output := TStringStream.Create;

  try
    Self.GIFData.SaveToStream(Input);
    Input.Position := 0;
    TNetEncoding.Base64.Encode(Input,Output);
    Output.Position := 0;
    Result := Output.DataString;
  finally
    Input.Free;
    Output.Free;
  end;
end;

procedure TGIFImageHelper.LoadFromBase64(str64: string);
var
  Input, Output : TStringStream;
begin
  Input := TStringStream.Create(str64);
  Output := TStringStream.Create;

  try
    Input.Position := 0;
    TNetEncoding.Base64.Decode(Input,Output);
    Output.Position := 0;
    Self.GIFData.LoadFromStream(Output);
  finally
    Input.Free;
    Output.Free;
  end;
end;

end.
