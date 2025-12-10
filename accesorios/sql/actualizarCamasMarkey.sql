SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jorge Luis Rodríguez
-- Create date: 2025-12-01
-- Description:	Obtener las camas de Markey y actualizar la tabla [10.99.8.8].CAB.dbo.camasMarkey
-- =============================================
CREATE PROCEDURE actualizarCamasMarkey	
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE 
        @Object INT,
        @hr INT,
        @url VARCHAR(500) = 'https://clinicaadventista.markey.com.ar/APIMarkeyCAB/api/camas/obtenercamas?APIKey=d5e75bde-205b-4468-86ec-67e7160bad2e',
        @responseText NVARCHAR(MAX);

    --------------------------------------------------------------
    -- 1) CONSUMIR SERVICIO WEB
    --------------------------------------------------------------
    EXEC @hr = sp_OACreate 'MSXML2.XMLHTTP', @Object OUT;
    IF @hr <> 0 RAISERROR('Error en sp_OACreate', 16, 1);

    EXEC @hr = sp_OAMethod @Object, 'open', NULL, 'GET', @url, false;
    IF @hr <> 0 RAISERROR('Error en open', 16, 1);

    EXEC @hr = sp_OAMethod @Object, 'send';
    IF @hr <> 0 RAISERROR('Error en send', 16, 1);

    EXEC @hr = sp_OAGetProperty @Object, 'responseText', @responseText OUT;
    IF @hr <> 0 RAISERROR('Error obteniendo responseText', 16, 1);

    EXEC sp_OADestroy @Object;


    --------------------------------------------------------------
    -- 2) CANTIDAD DE REGISTROS DEL JSON
    --------------------------------------------------------------
    DECLARE @jsonCount INT = (
        SELECT COUNT(*) 
        FROM OPENJSON(@responseText)
    );

    --------------------------------------------------------------
    -- 3) CANTIDAD EN TABLA DESTINO
    --------------------------------------------------------------
    DECLARE @tableCount INT = (SELECT COUNT(*) FROM camasMarkey);

    --------------------------------------------------------------
    -- 4) SI CAMBIÓ LA CANTIDAD ? TRUNCATE + INSERT
    --------------------------------------------------------------
    IF @jsonCount <> @tableCount
    BEGIN
        --PRINT 'Cantidad distinta ? TRUNCATE + INSERT';

        TRUNCATE TABLE camasMarkey;

        INSERT INTO camasMarkey (idCama, sector, estado)
        SELECT 
            JSON_VALUE(value, '$.id'),
            JSON_VALUE(value, '$.sector'),
            JSON_VALUE(value, '$.estado')
        FROM OPENJSON(@responseText);

        RETURN;
    END


    --------------------------------------------------------------
    -- 5) SI EL CONTEO ES IGUAL ? MERGE (UPDATE SOLO SI CAMBIÓ)
    --------------------------------------------------------------
    ;WITH JsonData AS (
        SELECT
            JSON_VALUE(value, '$.id')      AS idCama,
            JSON_VALUE(value, '$.sector')  AS sector,
            JSON_VALUE(value, '$.estado')  AS estado
        FROM OPENJSON(@responseText)
    )
    MERGE camasMarkey AS dest
    USING JsonData AS src
        ON dest.idCama = src.idCama
    WHEN MATCHED AND (
            ISNULL(dest.sector, '') <> ISNULL(src.sector, '') OR
            ISNULL(dest.estado, '') <> ISNULL(src.estado, '')
        )
        THEN UPDATE SET 
            dest.sector = src.sector,
            dest.estado = src.estado
    WHEN NOT MATCHED BY TARGET
        THEN INSERT (idCama, sector, estado)
             VALUES (src.idCama, src.sector, src.estado)
    WHEN NOT MATCHED BY SOURCE
        THEN DELETE
    ;
END
GO
