unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, d2xxunit;

type
  TForm2 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Names = Array[1..20] of string;
  Names_Ptr = ^Names;

procedure ClosePort;

var
  Form2: TForm2;
  My_Names : Names;
  Saved_Handle: DWord;
  PortAIsOpen : boolean;
  DName : String;

implementation

{$R *.dfm}

procedure ClosePort;

begin
if PortAIsOpen then
Close_USB_Device;
PortAIsOpen := False;
Form2.ComboBox1.Clear;

end;

function OpenPort(PortName : string) : boolean;
Var
  res : FT_Result;
  NoOfDevs,J : integer;
//  i  : integer;
  Name : String;
  DualName : string;
//  done : boolean;
begin
Result := False;
PortAIsOpen := False;
//OpenPort := False;       //wtf is this?
Name := '';
Dualname := PortName;
res := GetFTDeviceCount;
if res <> Ft_OK then exit;
NoOfDevs := FT_Device_Count;
J := 0;
if NoOfDevs > 0 then
  begin
    repeat
      repeat
      res := GetFTDeviceDescription(J);
      if (res <> Ft_OK) then  J := J + 1;
      until (res = Ft_OK) OR (J=NoOfDevs);
    if res <> Ft_OK then exit;
 //   done := false;
 //   i := 1;
 //   Name := '';
 //     repeat
 //     if ORD(FT_Device_String_Buffer[i]) <> 0 then
 //       begin
        Name := FT_Device_String;
        //Name := Name + FT_Device_String_Buffer[i];
 //       end
 //     else
 //       begin
 //       done := true;
 //       end;
 //     i := i + 1;
 //     until done;
    J := J + 1;
    until (J = NoOfDevs) or (Name = DualName);
  end;

if (Name = DualName) then
  begin
  res := Open_USB_Device_By_Device_Description(Name);
  if res <> Ft_OK then exit;
  OpenPort := true;
  res := Get_USB_Device_QueueStatus;
  if res <> Ft_OK then exit;
  PortAIsOpen := true;
  Result := True;
  end
else
  begin
  OpenPort := false;
  end;

end;

function List_Devs( My_Names_Ptr : Names_Ptr) : integer;
Var
  res : FT_Result;
  NoOfDevs,J : integer;
  Name : String;
begin
Result := 0;
Name := '';
res := GetFTDeviceCount;
if res <> Ft_OK then exit;
NoOfDevs := FT_Device_Count;
J := 0;
if NoOfDevs > 0 then
  begin
    repeat
    res := GetFTDeviceDescription(J);
    if res = Ft_OK then
      begin
      My_Names_Ptr[J+1]:= FT_Device_String;
      end;
    if res <> Ft_OK then
      begin
      My_Names_Ptr[J+1]:= 'Error: In Use';
    end;
    J := J + 1;
    until (J = NoOfDevs);
  end;
Result := NoOfDevs;
end;

procedure TForm2.Button1Click(Sender: TObject);
Var
  res : FT_Result;
  DName : string;
begin
  if PortAIsOpen then
    begin
      Close_USB_Device;
      PortAIsOpen := False;
    end;
  DName := form2.ComboBox1.Text;
  if (DName <> '') then
  begin
      //if OpenPort(DName) then
        res := Open_USB_Device(form2.ComboBox1.ItemIndex);
        if res = Ft_OK then
        begin
          res := Get_USB_Device_QueueStatus;
          if res = Ft_OK then
          begin
            PortAIsOpen := true;
            Set_USB_Device_LatencyTimer(16);
            res := Set_USB_Device_BitMode($FF,$1); // enable Async BitBang
            if res = Ft_OK  then
              form2.Memo1.Lines.Add('Init - Success')
            else
              form2.Memo1.Lines.Add('Init - Failed');
            end
        end
  else
    form2.Memo1.Lines.Add('You must select an FT245R device');
  end
end;

procedure TForm2.Button2Click(Sender: TObject);
Var
  NoOfDevs, i : integer;
begin
  ClosePort;
  for i := 1 to 20 do My_Names[i] := '';
  Form2.ComboBox1.Clear;
  form2.Memo1.Lines.Add('No Device Selected.');
  NoOfDevs := List_Devs(@My_Names);
  for i := 1 to NoOfDevs do
    begin
        Form2.ComboBox1.Items.Add(IntToStr(i) + ') ' + My_Names[i]);
    end;
end;

end.
