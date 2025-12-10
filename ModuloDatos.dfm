object datos: Tdatos
  OnCreate = DataModuleCreate
  Height = 451
  Width = 719
  object ticketsCli: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://10.99.8.107/tc/public/api/aplicacion/usuarioTickets'
    Params = <>
    SynchronizedEvents = False
    Left = 80
    Top = 136
  end
  object ticketsReq: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = ticketsCli
    Params = <
      item
        Name = 'dni'
        Value = '20764733'
      end
      item
        Kind = pkHTTPHEADER
        Name = 'TokenAcceso'
        Value = 
          'cv44uu1depYrgYVwq7S6W7wC0F2OfjbZQvJ9Ay4wqY8qn1jDufmfZszW2V8bnnSa' +
          'sGtHJMQyBVjQzZGC361iOMZGEU9jYTFUYxv2jZ6yZh7QoHEfb59kWgohM1FoB5aB'
      end>
    Response = ticketsRes
    SynchronizedEvents = False
    Left = 80
    Top = 184
  end
  object ticketsRes: TRESTResponse
    ContentType = 'application/json'
    Left = 80
    Top = 232
  end
  object ticketsDSA: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tickets
    FieldDefs = <>
    Response = ticketsRes
    TypesMode = JSONOnly
    Left = 80
    Top = 280
  end
  object tickets: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'dni'
        DataType = ftWideString
        Size = 8
      end
      item
        Name = 'id_usuario_ticket'
        DataType = ftFloat
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 80
    Top = 328
    object ticketsdni: TWideStringField
      FieldName = 'dni'
      Size = 8
    end
    object ticketsid_usuario_ticket: TFloatField
      FieldName = 'id_usuario_ticket'
    end
  end
end
