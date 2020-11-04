unit Unit6;

interface
uses System.math,System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants;

function wgs2GCJ(wgLat:double;wgLon:double):String;
function delta(wgLat:double;wgLon:double):String;
function transformLat(x:double;y:double):Double;
function transformLon(x:double;y:double):Double;

implementation

Const
  axis=6378245.0;
  offset=0.00669342162296594323 ;
  x_pi=pi*3000.0/180.0 ;

var
  latlng:Array of Double;
  lat,lon:String;

function wgs2GCJ(wgLat:double;wgLon:double):String;//WGS84 =》GCJ02地球坐标系 = > 火星坐标系
var
  deltaD:String;
begin
  //deltaD := delta(wgLat, wgLon);
  //lat:=(wgLat + latlng[0]-0.0016).ToString;
  //lon:=(wgLon + latlng[1]+0.0079).ToString;
  //Result:=lat+','+lon;
  deltaD := delta(wgLat, wgLon);
  lat:=(wgLat + latlng[0]).ToString;
  lon:=(wgLon + latlng[1]).ToString;
  Result:=lon+','+lat;
end;

function transformLat(x:double;y:double):Double;
var
  ret:double;
begin
  ret:= -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(Abs(x));
  ret:=ret+ (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0 ;
  ret:=ret+ (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0 ;
  ret:=ret+ (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0 ;
  Result:=ret;
end;

function transformLon(x:double;y:double):Double;
var
  ret:double;
begin
  ret := 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));
  ret :=ret+ (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0 ;
  ret :=ret+ (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0 ;
  ret :=ret+ (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0 ;
  Result:=ret;
end;

function delta(wgLat:double;wgLon:double):String;
var
  dLat,dLon,radLat,magic,sqrtMagic:double;
begin
  latlng:=[0,0];
  dLat := transformLat(wgLon - 105.0, wgLat - 35.0);
  dLon := transformLon(wgLon - 105.0, wgLat - 35.0);
  radLat := wgLat / 180.0 * pi;
  magic := sin(radLat);
  magic := 1 - offset * magic * magic ;
  sqrtMagic := sqrt(magic);
  dLat := (dLat * 180.0) / (axis * (1 - offset)/ (magic * sqrtMagic) * pi);
  dLon := (dLon * 180.0) / (axis / sqrtMagic * cos(radLat) * pi);
  latlng[0] := dLat;
  latlng[1] := dLon;
  Result:= dLat.ToString+','+dLon.ToString;
end;



end.
