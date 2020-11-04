object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 351
  Width = 213
  object PostgreSQLUniProvider1: TPostgreSQLUniProvider
    Left = 24
    Top = 16
  end
  object UniConnection1: TUniConnection
    ProviderName = 'PostgreSQL'
    Port = 5432
    Database = 'postgres'
    SpecificOptions.Strings = (
      'PostgreSQL.UseUnicode=True')
    Username = 'postgres'
    Server = '47.95.232.163'
    Connected = True
    Left = 80
    Top = 16
    EncryptedPassword = '9CFF8CFFCEFFC6FFC6FFC7FFCFFFC6FFCDFFC8FF'
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      
        'INSERT INTO "public"."POI"("name", "lon", "lat", "type") VALUES ' +
        '(:name, :lon, :lat, :type)')
    Left = 136
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'name'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'lon'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'lat'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'type'
        Value = nil
      end>
  end
  object UniQuery2: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'select * from "public"."POI"')
    Left = 24
    Top = 72
    object UniQuery2name: TWideStringField
      FieldName = 'name'
      Size = 255
    end
    object UniQuery2lon: TWideStringField
      FieldName = 'lon'
      Size = 255
    end
    object UniQuery2lat: TWideStringField
      FieldName = 'lat'
      Size = 255
    end
    object UniQuery2type: TWideStringField
      FieldName = 'type'
      Size = 255
    end
    object UniQuery2create: TWideStringField
      FieldName = 'create'
      Size = 255
    end
    object UniQuery2date: TDateField
      FieldName = 'date'
    end
  end
  object UniQuery3: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'select * from "public"."POI" where "name" like :poi')
    Left = 80
    Top = 72
    ParamData = <
      item
        DataType = ftString
        Name = 'poi'
        Value = '%422%'
      end>
  end
end
