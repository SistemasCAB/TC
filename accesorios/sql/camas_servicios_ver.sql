USE TableroCamas

declare
	@id_servicio int = 1,
	@pendientes int = 0,
	@id_estado int = 0

select
	cm.id_cama,
	cm.cama,
	cm.id_habitacion,
	cm.habitacion,
	cm.piso,
	cm.id_estado,
	cm.estado,
	e.color,
	cm.id_paciente,
	cm.nombre_paciente,
	cm.apellido_paciente,
	cm.dni,
	cm.sexo,
	cm.fecha_ingreso_institucion,
	cm.fecha_ingreso_cama,
	cm.cobertura,
	cm.fantasia,
	cm.[plan],
	cm.nro_afiliado,
	cm.id_internacion,
	cm.fecha_alta_medica,
	cm.profesional_alta,
	cm.cama_en_aislamiento,
	cm.observaciones,
	cm.foto_paciente,
	cm.procedimientos_no_cumplidos,
	cm.medicacion_no_programada,
	cm.medicacion_no_aplicada,
	cm.aislamiento_contacto,
	cm.aislamiento_gota_contacto,
	cm.aislamiento_aire_respiratorio,
	cm.aislamiento_proteccion,
	cm.aislamiento_gotas_contacto,
	cm.tipo_alta_medica,
	cm.acompanante,
	cm.observaciones_acompanante,
	c.orden,
	cambioCamaPendiente = dbo.fn_CambiosDeCamaPendiente(cm.id_cama, cm.id_internacion),

	-- obtengo la cantidad de alertas que hay para esta cama.
	alertas = dbo.fn_cantidadAlertasCama(@id_servicio, cm.id_cama),

	-- obtengo la cantidad de tareas pendientes
	tareasPendientes = dbo.fn_CamaConTareasPendientes(cm.id_cama, @id_servicio),

	-- alta probable
	a.fechaAltaProbable as altaProbable_fecha,
	a.tipoAltaProbable as altaProbable_tipo,
	a.dniUsuarioAltaProbable as altaProbable_dniUsuario,

	-- obtengo las reservas
	r.id_reserva,
	r.fecha_reserva,
	r.motivo as reserva_motivo,
	r.reservada_por_dni,
	r.reservada_por_nombre,
	r.fecha_cancelada as reserva_fecha_cancelada,
	r.cancelada_por_dni as reserva_cancelada_por_dni,
	r.cancelada_por_nombre as reserva_cancelada_por_nombre,
	r.paciente_dni as reserva_paciente_dni,
	r.paciente_nombre as reserva_paciente_nombre,
	r.id_motivo_fin_reserva,
	r.id_solicitudCambio as reserva_id_solicitudCambio

from camasMarkey cm
	left join camasEstados e on cm.id_estado = e.id_estado
	left join camas c on cm.id_cama = c.id_cama
	left join reservas r on cm.id_cama = r.id_cama and r.fecha_cancelada is null
	left join (select id_internacion, fechaAltaProbable,tipoAltaProbable, dniUsuario as dniUsuarioAltaProbable from altaProbable ap left join tipoAltaProbable tap on ap.id_tipoAltaProbable = tap.idTipoAltaProbable) a on cm.id_internacion = a.id_internacion
where
	cm.id_cama in (select id_cama from camasServicios where id_servicio = @id_servicio)
order by
	c.orden