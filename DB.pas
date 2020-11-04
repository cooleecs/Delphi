unit DB;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Uni, UniProvider,
  PostgreSQLUniProvider;

type
  TDataModule2 = class(TDataModule)
    PostgreSQLUniProvider1: TPostgreSQLUniProvider;
    UniConnection1: TUniConnection;
    UniQuery1: TUniQuery;
    UniQuery2: TUniQuery;
    UniQuery2name: TWideStringField;
    UniQuery2lon: TWideStringField;
    UniQuery2lat: TWideStringField;
    UniQuery2type: TWideStringField;
    UniQuery2create: TWideStringField;
    UniQuery2date: TDateField;
    UniQuery3: TUniQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
