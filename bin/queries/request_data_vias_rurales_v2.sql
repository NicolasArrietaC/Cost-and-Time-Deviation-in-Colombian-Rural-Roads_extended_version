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

        AND detalle_objeto NOT LIKE '%MEZCLA%ASF%LTICA%'
        AND detalle_objeto NOT LIKE '%DEMOLICI%N%'
        AND detalle_objeto NOT LIKE '%RESTAURACI%N%ESTACI%N%F%RREA%'
        AND detalle_objeto NOT LIKE '%DEMOLICI%N%'
        AND detalle_objeto NOT LIKE '%REHABILITACI%N%CONSERVACI%N%PUENTE%'
        AND detalle_objeto NOT LIKE '%MANTENIMIENTO%T%NEL%'
        AND detalle_objeto NOT LIKE '%MANO%DE%OBRA%'
        AND detalle_objeto NOT LIKE '%BOX%C%ULVERT%'
        AND detalle_objeto NOT LIKE '%CICLOVÍAS%'
        AND detalle_objeto NOT LIKE '%CICLOVIAS%'
        AND detalle_objeto NOT LIKE '%CICLORUTA%'
        AND detalle_objeto NOT LIKE '%RESIDUOS%S%LIDOS%'
        AND detalle_objeto NOT LIKE '%PUENTE%PEATONAL%'
        AND detalle_objeto NOT LIKE '%CONSERVACI%N%PUENTE%'
        AND detalle_objeto NOT LIKE '%CONSTRUCCI%N%PUENTE%' 

        AND detalle_objeto NOT LIKE '%REDUCTORES%VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%MUROS%'
        AND detalle_objeto NOT LIKE '%BARANDAS%'
        AND detalle_objeto NOT LIKE '%SEÑALIZACI%N%'        
        AND detalle_objeto NOT LIKE '%SENALIZACI%N%'        
        AND detalle_objeto NOT LIKE '%ALCANTARILLA%'
        AND detalle_objeto NOT LIKE '%PUENTES%COLGANTES%'
        AND detalle_objeto NOT LIKE '%SEMAFORIZACI%N%'
        AND detalle_objeto NOT LIKE '%DESMONTE%LIMPIEZA%'
        AND detalle_objeto NOT LIKE '%SUMINISTRO%'
        AND detalle_objeto NOT LIKE '%INTERVENTOR%A%' 
        AND detalle_objeto NOT LIKE '%CONSULTOR%A%' 
        AND detalle_objeto NOT LIKE '%ROCER%A%'
        AND detalle_objeto NOT LIKE '%ROSER%A%'
        AND detalle_objeto NOT LIKE '%DISEÑO%'
        AND detalle_objeto NOT LIKE '%DISENO%' 
        AND detalle_objeto NOT LIKE '%UNAR%ESFUERZO%'
        AND detalle_objeto NOT LIKE '%UNNAR%ESFUERZO%'
        AND detalle_objeto NOT LIKE '%AUNAR%ESPUERZO%'
        AND detalle_objeto NOT LIKE '%CONVE%IO%'
        AND detalle_objeto NOT LIKE '%INTERADMINISTRATIVO%'
        AND detalle_objeto NOT LIKE '%MANTENIMIENTO%RUTINARIO%'

        --AND detalle_objeto NOT LIKE '%CASCO%URBANO%'
        --AND detalle_objeto NOT LIKE '%VÍAS%URBANAS%'
        --AND detalle_objeto NOT LIKE '%VIAS%URBANAS%'
        AND detalle_objeto NOT LIKE '%EJERCITO%'
        AND detalle_objeto NOT LIKE '%AULAS%'
        AND detalle_objeto NOT LIKE '%CALLE%'
        AND detalle_objeto NOT LIKE '%CARRERA%'
        AND detalle_objeto NOT LIKE '%URBAN%'

        -- NEW FILTERS
        AND detalle_objeto NOT LIKE '%SECUNDARIA%'
        AND detalle_objeto NOT LIKE '%CARRETERA%'
        AND detalle_objeto NOT LIKE '%ANDEN%'
        AND detalle_objeto NOT LIKE '%PARQUE%'
        AND detalle_objeto NOT LIKE '%SE%ALIZACION%'
        AND detalle_objeto NOT LIKE '%PISTA%'
        AND detalle_objeto NOT LIKE '%ESTUDIOS%'
        AND detalle_objeto NOT LIKE '%ADMINISTRACI%N%'
        AND detalle_objeto NOT LIKE '%INVENTARIO%'
        AND detalle_objeto NOT LIKE '%ELABORACI%N%MANUAL%'
        AND detalle_objeto NOT LIKE '%INSTITUCI%N%EDUCATIVA%'
        AND detalle_objeto NOT LIKE '%COMPLEMENTA%ESFUERZOS%INSTITUCIONALES%'
        AND detalle_objeto NOT LIKE '%UNI%ESFUERZOS%'
        --CONTAIN FILTERS
        AND (detalle_objeto LIKE '%VIA%' OR detalle_objeto LIKE '%VIAS%' OR detalle_objeto LIKE '%VIAL%')
        AND (detalle_objeto LIKE '%VEREDA%' OR detalle_objeto LIKE '%RURAL%' OR detalle_objeto LIKE '%TERCIARIA%')
LIMIT
        10000