library DLO_ft245usb;

uses
  Windows,Forms,Dialogs, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  D2XXUnit in 'D2XXUnit.pas',
  about in 'about.pas' {Form2};

Var
  lights_val : byte;

const USBBuffSize : integer = $4000;


function GetNch : Byte; cdecl; export;
  Begin
    GetNch := 8;
    //Specify the maximum number of channels.  1..127 are allowed
  end;

function GetName : PChar; cdecl; export;
  Begin
    GetName := 'FT245 USB Out';
    //Specify the name of the plugin, 60chrs maximum, null terminated string.
  end;

   //Use this routine to output values to individual litez.  Ch = channel, value = on/off 1=on, 0=off
procedure Output(ch, val : Byte); cdecl; export;
  begin
  if PortAIsOpen then
  begin
  if val = $0 then
  lights_val := lights_val AND NOT (1 shl (ch - 1))    // turn off the light
  else
  lights_val := lights_val OR (1 shl (ch - 1));        // turn on the light

  FT_Out_Buffer[0] := lights_val;
  if Write_USB_Device_Buffer(1) = 0 then
  begin
  ClosePort;
  form2.Memo1.Lines.Add('Connection Broken!');
  end;
  end;
  end;

procedure Init; cdecl; export;
  Begin
    // Use this routine to initialise all your forms/values
  form2 := TForm2.Create(form2);

  end;



procedure Done; cdecl; export;
  Begin
    ClosePort;
    form2.Free;
    // Use this routine to cleanup and free all instances/stuff
  end;

procedure About; cdecl; export;
  Begin
    form2.Show;
    // Put your about box in here B-)
  end;

exports
  GetNch  index 0 name 'DLO_getnch',
  GetName index 1 name 'DLO_getname',
  Output index 2 name 'DLO_datain',

  Init index 3 name 'DLO_init',
  Done index 4 name 'DLO_done',
  About index 5 name 'DLO_about';

begin
end.
