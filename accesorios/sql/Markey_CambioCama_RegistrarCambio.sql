USE [TableroCamas]
GO
/****** Object:  StoredProcedure [dbo].[Markey_camasCambiarEstado]    Script Date: 16/11/2023 11:20:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jorge Luis Rodríguez
-- Create date: 2023-11-16
-- Description:	Cambia de cama a un paciente en Markey.
-- Retorna el statusCode del servicio web api/cambiarCama
-- =============================================
CREATE PROCEDURE Markey_CambioCama_RegistrarCambio
	@id_camaorigen int = null,
	@id_camadestino int = null,
	@id_internacion int = null,
	@id_paciente int = null,
	@dni int = null
WITH EXECUTE AS OWNER
AS
BEGIN
	SET NOCOUNT ON;

	declare @url varchar(max)
	declare @apikey varchar(255) = 'd5e75bde-205b-4468-86ec-67e7160bad2e' -- ApiKey de Markey
	declare @endpoint varchar(255) = 'https://clinicaadventista.markey.com.ar/APIMarkeyCAB/api/cambiarCama?APIKey='

	DECLARE  @Object as Int
	DECLARE  @Status int = 0
	DECLARE  @ResponseText as Varchar (8000);

	DECLARE @requestBody NVARCHAR(MAX) -- = '{variable1 : «texto»,variable2 : 1 }'
	DECLARE @len INT

    if(@id_camaorigen is null) or (@id_camadestino is null) or (@id_internacion is null) or (@id_paciente is null) or (@dni is null)
		begin
			set @Status = 0
		end
	else
		begin
			
			set @url = @endpoint + @apikey + '&id_camaorigen=' + cast(@id_camaorigen as varchar) + '&id_camadestino=' + cast(@id_camadestino as varchar) + '&id_internacion=' + cast(@id_internacion as varchar) +'&id_paciente=' + cast(@id_paciente as varchar) + '&usuario=' + cast(@dni as varchar)

			EXEC sp_OACreate 'WinHttp.WinHttpRequest.5.1', @Object OUT;
			EXEC sp_OAMethod @Object, 'Open', NULL, 'POST', @url, 'false'
			EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/json'

			--set  @requestBody = '{variable1 : «texto»,variable2 : 1 }'
			set @len = len(@requestBody)
			EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Length', @len
			EXEC sp_OAMethod @Object, 'send', null, @requestBody
			EXEC sp_OAGetProperty @Object, 'Status', @Status OUT
			EXEC sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
			EXEC sp_OADestroy @Object
		end

	return @Status
END
