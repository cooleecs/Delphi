unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  System.Sensors.Components, FMX.Objects, FMX.TabControl, FMX.WebBrowser,
  FMX.ListBox, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Grid, System.math;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Text1: TText;
    Rectangle1: TRectangle;
    LocationSensor1: TLocationSensor;
    Layout1: TLayout;
    Layout2: TLayout;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Switch1: TSwitch;
    Layout3: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout4: TLayout;
    Label4: TLabel;
    Edit2: TEdit;
    Layout5: TLayout;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Layout6: TLayout;
    Button2: TButton;
    TabItem3: TTabItem;
    GridPanelLayout1: TGridPanelLayout;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Timer1: TTimer;
    WebBrowser2: TWebBrowser;
    Timer2: TTimer;
    OrientationSensor1: TOrientationSensor;
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Switch1Switch(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure TabItem2Click(Sender: TObject);
    procedure TabItem2Tap(Sender: TObject; const Point: TPointF);
    procedure Timer2Timer(Sender: TObject);
    procedure OrientationSensor1SensorChoosing(Sender: TObject;
      const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses DB, SG.ScriptGate, Unit2, Unit3, Unit4, Unit5, Unit6, login;
var
  lon,lat,POIlon,POIlat:String;
  SG,SG1: TScriptGate;

procedure TForm1.Button1Click(Sender: TObject);
var
  poistring,poilonlng,nowlonlat: String;
begin
  poistring:= Edit1.Text;
  if Edit1.Text<>'' then
  begin
    DB.DataModule2.UniQuery3.ParamByName('poi').Asstring := '%'+poistring+'%';
    DB.DataModule2.UniQuery3.ExecSQL;
    if DB.DataModule2.UniQuery3.RecordCount>0 then
    begin
      POIlon:=DB.DataModule2.UniQuery3.FieldByName('lon').AsString;
      POIlat:=DB.DataModule2.UniQuery3.FieldByName('lat').AsString;
      poilonlng:=wgs2GCJ(StrToFloat(POIlat),StrToFloat(POIlon));
      nowlonlat:=wgs2GCJ(StrToFloat(lat),StrToFloat(lon));
      //ShowMessage(poilonlng);
      SG.CallScript('drawline('+nowlonlat+','+poilonlng+')',
      procedure(const sResult: string)
      begin
        Caption := sResult;
      end);

    end
    else
    begin
      ShowMessage('无相关地址！');
    end;

  end
  else
  begin
    ShowMessage('请输入地址！');
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
    name,ptype: String;
begin
  if lon<>'0' then
    begin
    name:= Edit2.Text;
    ptype:= ComboBox1.Items[ComboBox1.ItemIndex];
    //DB.DataModule2.UniQuery1.Close;
    DB.DataModule2.UniQuery1.ParamByName('name').Asstring := name;
    DB.DataModule2.UniQuery1.ParamByName('lon').Asstring := lon;
    DB.DataModule2.UniQuery1.ParamByName('lat').Asstring := lat;
    DB.DataModule2.UniQuery1.ParamByName('type').Asstring := ptype;
    DB.DataModule2.UniQuery1.ExecSQL;
    if DataModule2.UniQuery1.RecordCount=0 then
      begin
       ShowMessage('提交成功！');
      end
    else
      begin
        ShowMessage('提交失败！');
      end;
    end
  else
    begin
      ShowMessage('请开启定位！');
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form7.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Form7.show();
  LocationSensor1.Active:=True;
  lon:='116.6778';
  lat:='40.406383';
  SG := TScriptGate.Create(Self, WebBrowser1, 'delphi') ;
  SG1:= TScriptGate.Create(Self, WebBrowser2, 'delphi') ;
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
begin
  lon:= NewLocation.Longitude.ToString;
  lat:= NewLocation.Latitude.ToString;
  label3.Text := lon+','+lat;
end;

procedure TForm1.OrientationSensor1SensorChoosing(Sender: TObject;
  const Sensors: TSensorArray; var ChoseSensorIndex: Integer);
var
  I: Integer;
  Found: Integer;
begin
  Found := -1;
  for I := 0 to High(Sensors) do
  begin
    if (TCustomOrientationSensor.TProperty.TiltX
      in TCustomOrientationSensor(Sensors[I]).AvailableProperties) then
    begin
      Found := I;
      //Break;
    end;
  end;

  if Found < 0 then
  begin
    Found := 0;
    ShowMessage('Compass（电子罗盘） not（不） available（可用）');
  end;

  ChoseSensorIndex := Found;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  LocationSensor1.Active:=Switch1.IsChecked;
end;

procedure TForm1.TabItem2Click(Sender: TObject);
begin
  Timer2.Enabled:=True;
end;

procedure TForm1.TabItem2Tap(Sender: TObject; const Point: TPointF);
begin
  Timer2.Enabled:=True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  nowlonlat:string;
  TiltZ:double;
begin
  TiltZ:=OrientationSensor1.Sensor.TiltZ;
  if OrientationSensor1.Sensor.TiltZ.IsNan then
  begin
     TiltZ:=0;
  end;
  //ShowMessage(OrientationSensor1.Sensor.TiltZ.ToString);
  nowlonlat:=wgs2GCJ(StrToFloat(lat),StrToFloat(lon));
  //ShowMessage(nowlonlat);
  SG.CallScript('setPosition('+nowlonlat+','+Trunc(TiltZ).ToString()+')',
      procedure(const sResult: string)
      begin
        Caption := sResult;
      end);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  nowlonlat:string;
begin
  nowlonlat:=wgs2GCJ(StrToFloat(lat),StrToFloat(lon));
  //ShowMessage(nowlonlat);
  SG1.CallScript('setPosition('+nowlonlat+',90)',
      procedure(const sResult: string)
      begin
        Caption := sResult;
      end);
end;

end.
