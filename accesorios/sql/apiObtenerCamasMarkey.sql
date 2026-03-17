-- EXEC APIObtenerCamas @APIKey = 'd5e75bde-205b-4468-86ec-67e7160bad2e'

drop table #inteAltas
drop table #Resultado

declare @APIKey varchar (MAX) = 'd5e75bde-205b-4468-86ec-67e7160bad2e'
declare @id_estado bigint = NULL
declare @id_cama bigint = NULL
declare @id_sala bigint = NULL
declare @id_habitacion bigint = NULL

DECLARE @Fecha DATETIME

SET @Fecha = GETDATE()


IF NOT EXISTS (SELECT TOP 1 1 FROM ApiKey WHERE apikKey = @APIKey AND ApiKey.apikVigente = 1) AND @APIKey <> ''
	BEGIN
		RAISERROR('La API Key informada no está hablitada.', 16, 1)
		RETURN
	END


--28/08/23 IM Trae las fecha de alta. 
SElect I.inteCodigo,
ISNULL	((SELECT TOP 1 
convert(varchar(23),CONCAT(
			SUBSTRING(engpValor,7,4)
			,'-'
			,SUBSTRING(engpValor,4,2)
			,'-'
			,LEFT(engpValor,2)
			,RIGHT(engpValor,6)
			)			
		,121
	)+':00'),'') as fecha_alta_medica
INTO #inteAltas
FROM Internacion I, entrada E, EntradaGrupoPropiedad EGP
where I.intefechaegreso > getdate()
and E.inteCodigo = I.intecodigo
AND	EGP.entrCodigo = E.entrCodigo
AND	E.grtiCodigo = 10015
and EGP.grprCodigo = 54
AND	EGP.engpValor IS NOT NULL


SELECT DISTINCT
S.salaCodigo,
A.areaCodigo,
C.camaCodigo AS id_cama,
C.camaDescripcion AS cama,
ISNULL((H.habiCodigo),0) AS id_habitacion,
ISNULL(H.habiDescripcion,'')  AS habitacion,
ISNULL(H.habiPiso,'') AS piso,
ISNULL(H.habiPiso,'') AS piso_texto,
ISNULL(C.camaTipo,'')  AS tipoCama, 
2 AS id_estado,
'Ocupada' AS estado,
'' AS color,
I.paciCodigo AS Id_Paciente,
persNombre AS nombre_paciente,
persApellido apellido_paciente,						   
persNroDocumento AS DNI,
ISNULL(persSexo,'') AS sexo,
CONVERT(VARCHAR,inteFechaIngreso,20) AS fecha_ingreso_institucion,
CONVERT(VARCHAR,IM.inmoFechaDesde,20) AS fecha_ingreso_cama,
ISNULL((SELECT Top 1 PCO.persapellido FROM persona PCO where PCO.perscodigo = CO.cobecodigo),'') AS Cobertura, 
ISNULL((SELECT Top 1 PCO.persNombre FROM persona PCO where PCO.perscodigo = CO.cobecodigo),'') AS Fantasia, 
PL.planDescripcion AS "Plan",
ISNULL(pacoAfiliado,'') AS Nro_Afiliado,
0 AS Id_Aislado,
'' AS aislado,
I.inteCodigo AS id_internacion,
--ISNULL(AM.fechaIndicAlta,'') AS fecha_alta_medica,
ISNULL((SELECT TOP 1 fecha_alta_medica FROM #inteAltas IA WHERE IA.inteCodigo = I.inteCodigo),'') AS fecha_alta_medica, 

/* SE COMENTA ESTA PARTE PORQUE ESTA DEMORANDO
ISNULL	((SELECT TOP 1 
convert(varchar(23),CONCAT(
			SUBSTRING(engpValor,7,4)
			,'-'
			,SUBSTRING(engpValor,4,2)
			,'-'
			,LEFT(engpValor,2)
			,RIGHT(engpValor,6)
			)			
		,121
	)+':00'  
				FROM entrada E, entradagrupopropiedad EGP
				 WHERE E.inteCodigo = i.INTECODIGO
				 AND EGP.entrCodigo = E.entrCodigo
				 AND E.grtiCodigo = 10015
				 AND EGP.grprCodigo = 54),'') AS fecha_alta_medica,*/
				 
ISNULL((SELECT TOP 1 GPO.grpoDescripcion
		FROM Entrada E, EntradaGrupoPropiedad EGP, EntradaGrupoOpcion EGO, GrupoPropiedadOpcion GPO
		WHERE E.inteCodigo = I.inteCodigo
		AND EGP.entrCodigo= E.entrCodigo
		AND EGP.grprCodigo = 55 --Tipo de alta
		AND EGO.engpCodigo = EGP.engpCodigo
		AND GPO.grpoCodigo = EGO.grpoCodigo), '') AS tipo_alta_medica,

ISNULL ((SELECT TOP 1 P.persApellido + ' ' + P.persNombre 		    
						
		 FROM Entrada E
		 INNER JOIN GrupoTipo GT ON E.grtiCodigo = GT.grtiCodigo 
		 LEFT JOIN  Persona P ON P.persCodigo = E.mediCodigo
		 WHERE 
			 E.inteCodigo = I.inteCodigo 
		 AND    GT.grtiAltaMedica = 1
		 ORDER BY entrCodigo desc),'') AS Profesional_Alta,


0 AS cama_en_aislamiento,
ISNULL((SELECT TOP 1 CB.cablObservaciones FROM CamaBloqueo CB WHERE CB.camaCodigo = C.camaCodigo ORDER BY CB.cablCodigo desc ),'') AS observaciones,
ISNULL((SELECT TOP 1 IVV.invvValor from InternacionVariableValor IVV,SistemaVariable SV 
WHERE
	IVV.inteCodigo = I.inteCodigo
AND SV.sivaCodigo = IVV.sivaCodigo
AND sivaCodigoInterno IN ('ACOMP') ),'') AS acompanante,
ISNULL((SELECT TOP 1 IVV.invvValor from InternacionVariableValor IVV,SistemaVariable SV 
WHERE
	IVV.inteCodigo = I.inteCodigo
AND SV.sivaCodigo = IVV.sivaCodigo
AND sivaCodigoInterno IN ('ACOMOBS') ),'') AS observaciones_acompanante


INTO #Resultado

FROM	
	Internacion I
INNER JOIN InternacionMovimiento IM ON IM.inteCodigo = I.inteCodigo
INNER JOIN Cama C ON C.camaCodigo = IM.camaCodigo 
INNER JOIN Area A ON A.areaCodigo = C.areaCodigo   
INNER JOIN Sala S ON S.salaCodigo = A.salaCodigo  
INNER JOIN Persona P ON P.persCodigo = I.paciCodigo
INNER JOIN TipoInternacion T ON T.tiinCodigo  = I.tiinCodigo
INNER JOIN PacienteCobertura PC ON PC.pacoCodigo = I.pacoCodigo
INNER JOIN [Plan] PL ON PL.planCodigo = PC.planCodigo
INNER JOIN Cobertura CO ON CO.cobeCodigo = PL.cobeCodigo
LEFT JOIN Habitacion H ON H.habiCodigo = C.habiCodigo


WHERE	
		I.inteFechaEgreso > GETDATE()
AND		I.taltCodigo IS NULL
AND		IM.inmoCodigo = (SELECT MAX(IM2.inmoCodigo) 
										 FROM InternacionMovimiento IM2 
										 WHERE IM2.inteCodigo = IM.inteCodigo)
AND		C.camaCodigo = ISNULL(@id_cama,C.camaCodigo)
AND		ISNULL(@id_estado,2) = 2
AND		S.salaCodigo = ISNULL(@id_sala,S.salaCodigo)
AND		C.habiCodigo = ISNULL(@id_habitacion,C.habiCodigo)


--##################################################################################

UNION

SELECT DISTINCT
S.salaCodigo,
A.areaCodigo,
C.camaCodigo AS id_cama,
C.camaDescripcion AS cama,
ISNULL((H.habiCodigo),0) AS id_habitacion,
ISNULL(H.habiDescripcion,'')  AS habitacion,
ISNULL(H.habiPiso,'') AS piso,
ISNULL(H.habiPiso,'') AS piso_texto,
ISNULL(C.camaTipo,'')  AS tipoCama, 
1 AS id_estado,
'Disponible' AS estado,
'' AS color,
0 AS Id_Paciente,
'' AS nombre_paciente,
'' AS apellido_paciente,			
'' AS DNI,
'' AS sexo,
'' AS fecha_ingreso_institucion,
'' AS fecha_ingreso_cama,
'' AS Cobertura,
'' AS Fantasia,
'' AS "Plan",
'' AS Nro_Afiliado,
0 AS Id_Aislado,
'' AS aislado,
0 AS id_internacion,
'' AS fecha_alta_medica,
'' AS tipo_alta_medica,
'' AS profesional_alta,
0 AS cama_en_aislamiento,
ISNULL((SELECT TOP 1 CB.cablObservaciones FROM CamaBloqueo CB WHERE CB.camaCodigo = C.camaCodigo ORDER BY CB.cablCodigo desc ),'') AS observaciones,
'' AS acompanante,
'' as observaciones_acompanante
		
FROM Cama C

INNER JOIN Area A   ON A.areaCodigo = C.areaCodigo
INNER JOIN Sala S ON S.salaCodigo = A.salaCodigo
LEFT JOIN Habitacion H ON H.habiCodigo = C.habiCodigo

WHERE	
		C.camaVigente = 1    
AND		C.camaCodigo = ISNULL(@id_cama,C.camaCodigo)
AND		NOT EXISTS (SELECT TOP 1 1     
					FROM Internacion I, InternacionMovimiento IM    
					WHERE I.inteCodigo = IM.inteCodigo    
					AND IM.camaCodigo = C.camaCodigo    
					AND I.inteFechaEgreso > GETDATE()
					AND IM.inmoCodigo = (SELECT MAX(IM2.inmoCodigo) 
										 FROM InternacionMovimiento IM2 
										 WHERE IM2.inteCodigo = IM.inteCodigo))    
AND		NOT EXISTS (SELECT TOP 1 1 
					FROM CamaBloqueo CB
					WHERE CB.camaCodigo = C.camaCodigo
					AND @Fecha BETWEEN CB.cablFechaDesde AND CB.cablFechaHasta)
 
AND		ISNULL(@id_estado,1) = 1
AND		S.salaCodigo = ISNULL(@id_sala,S.salaCodigo)
AND		C.habiCodigo = ISNULL(@id_habitacion,C.habiCodigo)

UNION 

SELECT DISTINCT
S.salaCodigo,
A.areaCodigo,
C.camaCodigo AS id_cama,
C.camaDescripcion AS cama,
ISNULL((H.habiCodigo),0) AS id_habitacion,
ISNULL(H.habiDescripcion,'')  AS habitacion,
ISNULL(H.habiPiso,'') AS piso,
ISNULL(H.habiPiso,'') AS piso_texto,
ISNULL(C.camaTipo,'')  AS tipoCama, 
ISNULL(CBM.cabmCodigoInterno,'') AS id_estado,
ISNULL(CBM.cabmDescripcion,'') AS estado,
'' AS color,
0 AS Id_Paciente,
'' AS nombre_paciente,
'' AS apellido_paciente,
'' AS DNI,
'' AS sexo,
'' AS fecha_ingreso_institucion,
'' AS fecha_ingreso_cama,
'' AS Cobertura,
'' AS Fantasia,
'' AS "Plan",
'' AS Nro_Afiliado,
0 AS Id_Aislado,
'' AS aislado,
0 AS id_internacion,
'' AS fecha_alta_medica,
'' AS tipo_alta_medica,
'' AS profesional_alta,
0 AS cama_en_aislamiento,
ISNULL((SELECT TOP 1 CB.cablObservaciones FROM CamaBloqueo CB WHERE CB.camaCodigo = C.camaCodigo ORDER BY CB.cablCodigo desc ),'') AS observaciones,
'' AS acompanante,
'' as observaciones_acompanante


FROM Cama C

INNER JOIN Area A   ON A.areaCodigo = C.areaCodigo
INNER JOIN Sala S ON S.salaCodigo = A.salaCodigo
INNER JOIN CamaBloqueo CB ON CB.camaCodigo = C.camaCodigo
LEFT JOIN Habitacion H ON H.habiCodigo = C.habiCodigo
LEFT JOIN CamaBloqueoMotivo CBM ON  CBM.cabmCodigo = CB.cabmCodigo

WHERE	
		C.camaVigente = 1    
AND		C.camaCodigo = ISNULL(@id_cama,C.camaCodigo)
AND		S.salaCodigo = ISNULL(@id_sala,S.salaCodigo)
AND		C.habiCodigo = ISNULL(@id_habitacion,C.habiCodigo)

AND @Fecha BETWEEN CB.cablFechaDesde AND CB.cablFechaHasta

AND		NOT EXISTS (SELECT TOP 1 1     
					FROM Internacion I, InternacionMovimiento IM    
					WHERE I.inteCodigo = IM.inteCodigo    
					AND I.inteFechaEgreso >= @Fecha  
					AND IM.camaCodigo = C.camaCodigo    
					AND IM.inmoCodigo = (SELECT MAX(IM2.inmoCodigo) 
										 FROM InternacionMovimiento IM2 
										 WHERE IM2.inteCodigo = IM.inteCodigo) )
AND	 (CBM.cabmCodigoInterno = @id_estado OR @id_estado IS NULL)

ORDER BY S.salaCodigo,A.areaCodigo,C.camaDescripcion

--###########################################################################################


DECLARE @result VARCHAR (MAX)

-- SET @result = ISNULL((SELECT * FROM #Resultado ORDER BY salaCodigo,areaCodigo,cama FOR JSON PATH ),'[]')
SELECT * FROM #Resultado ORDER BY salaCodigo,areaCodigo,cama

-- SELECT @result

--SELECT * FROM #Resultado

/*
drop table #inteAltas
drop table #Resultado

*/