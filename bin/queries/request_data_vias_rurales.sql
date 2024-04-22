SELECT 
        uid,
        nombre_entidad AS nombre_de_la_entidad, --already updated
        departamento_entidad,
        orden_entidad,
        modalidad_de_contratacion AS tipo_de_proceso, --already updated
        objeto_a_contratar,
        UPPER(detalle_del_objeto_a_contratar) AS detalle_objeto,
        cuantia_proceso,
        cuantia_contrato,
        valor_total_de_adiciones,
        valor_contrato_con_adiciones,
        anno_firma_contrato AS anno_firma, --already updated (anno_firma_del_contrato)
        fecha_de_firma_del_contrato AS fecha_fima,
        fecha_ini_ejec_contrato,
        plazo_de_ejec_del_contrato,
        rango_de_ejec_del_contrato,
        tiempo_adiciones_en_dias,
        tiempo_adiciones_en_meses,
        fecha_fin_ejec_contrato,
        id_adjudicacion,
        ruta_proceso_en_secop_i as urlproceso,
        nit_de_la_entidad,
        identificacion_del_contratista
WHERE
        anno_firma IS NOT NULL
        AND fecha_fima IS NOT NULL
        AND detalle_objeto IS NOT NULL

        AND id_familia = '9511'
        AND estado_del_proceso = 'Liquidado'
        AND anno_firma NOT IN ('2008','2009','2010','2011','2012','2013','2021','2022','2023','2024')
        AND cuantia_proceso IS NOT NULL
        AND cuantia_proceso > 1000000
        AND cuantia_contrato > 0
        --AND cuantia_proceso > 20000000
        --AND cuantia_contrato > 20000000
        --AND nombre_regimen_de_contratacion != 'Régimen Especial' --already updated (regimen_de_contratacion)
        --AND tipo_de_proceso IN ('Licitación obra pública','Licitación Pública')

        AND detalle_objeto NOT LIKE '%MEZCLA ASFÁLTICA%'
        AND detalle_objeto NOT LIKE '%REDUCTORES DE VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%MUROS DE CONTENCIÓN%'
        AND detalle_objeto NOT LIKE '%DEMOLICIÓN%'
        AND detalle_objeto NOT LIKE '%RESTAURACIÓN ESTACIÓN FÉRREA%'
        AND detalle_objeto NOT LIKE '%CONSTRUCCIÓN DE REDUCTORES DE VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%REDUCTORES DE VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%CONSTRUCCIÓN DE REDUCTORES DE VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%BARANDAS%'
        AND detalle_objeto NOT LIKE '%MUROS DE CONTENCIÓN%'
        AND detalle_objeto NOT LIKE '%DEMOLICIÓN%'
        AND detalle_objeto NOT LIKE '%RESTAURACIÓN ESTACIÓN FÉRREA%'
        AND detalle_objeto NOT LIKE '%SEÑALIZACIÓN%'
        AND detalle_objeto NOT LIKE '%REHABILITACIÓN Y CONSERVACIÓN PUENTE%'
        AND detalle_objeto NOT LIKE '%MANTENIMIENTO TÚNEL%'
        AND detalle_objeto NOT LIKE '%ALCANTARILLA%'
        AND detalle_objeto NOT LIKE '%MANO DE OBRA%'
        AND detalle_objeto NOT LIKE '%BOX CULVERT%'
        AND detalle_objeto NOT LIKE '%PUENTES COLGANTES%'
        AND detalle_objeto NOT LIKE '%CASCO URBANO%'
        AND detalle_objeto NOT LIKE '%VÍAS URBANAS%'
        AND detalle_objeto NOT LIKE '%EJERCITO%'
        AND detalle_objeto NOT LIKE '%SEMAFORIZACIÓN%'
        AND detalle_objeto NOT LIKE '%DEMOLICIONES%'
        AND detalle_objeto NOT LIKE '%MURO%'
        AND detalle_objeto NOT LIKE '%CICLOVÍAS%'
        AND detalle_objeto NOT LIKE '%CICLORUTA%'
        AND detalle_objeto NOT LIKE '%RESIDUOS SÓLIDOS%'
        AND detalle_objeto NOT LIKE '%DESMONTE Y LIMPIEZA%'
        AND detalle_objeto NOT LIKE '%AULAS%' 
        AND detalle_objeto NOT LIKE '%CALLE%'
        AND detalle_objeto NOT LIKE '%CARRERA%'
        AND detalle_objeto NOT LIKE '%URBAN%'
        AND detalle_objeto NOT LIKE '%CONSERVACION PUENTES%'
        AND detalle_objeto NOT LIKE '%PUENTES PEATONALES%' 
        AND detalle_objeto NOT LIKE '%CONSTRUCCION PUENTES%' 
LIMIT
        10000