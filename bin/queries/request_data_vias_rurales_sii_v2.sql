SELECT DISTINCT
        id_contrato AS uid,
        nombre_entidad AS nombre_de_la_entidad, --already updated
        departamento AS departamento_entidad,
        orden AS orden_entidad,
        modalidad_de_contratacion AS tipo_de_proceso, --already updated
        objeto_del_contrato AS objeto_a_contratar,
        UPPER(descripcion_del_proceso) AS detalle_objeto,
        0 AS cuantia_proceso,
        valor_del_contrato AS cuantia_contrato,
        0 AS valor_total_de_adiciones,
        valor_del_contrato AS valor_contrato_con_adiciones,
        date_extract_y(fecha_de_firma) AS anno_firma, --already updated (anno_firma_del_contrato)
        date_trunc_ymd(fecha_de_firma) AS fecha_fima,
        fecha_de_inicio_de_ejecucion AS fecha_ini_ejec_contrato,
        0 AS plazo_de_ejec_del_contrato,
        'NA' AS rango_de_ejec_del_contrato,
        dias_adicionados AS tiempo_adiciones_en_dias,
        dias_adicionados AS tiempo_adiciones_en_meses,
        fecha_de_fin_de_ejecucion AS fecha_fin_ejec_contrato,
        '000000000' AS id_adjudicacion,
        urlproceso,
        nit_entidad AS nit_de_la_entidad,
        codigo_proveedor AS identificacion_del_contratista
WHERE
        detalle_objeto IS NOT NULL
        AND liquidaci_n = 'Si'
        AND codigo_de_categoria_principal LIKE '%.9511%'
        AND anno_firma IN ('2014','2015','2016','2017','2018','2019','2020')
        --AND cuantia_proceso > 20000000
        AND cuantia_contrato > 1000000
        --AND nombre_regimen_de_contratacion != 'Régimen Especial' --no hay similar
        -- AND tipo_de_proceso IN ('Licitación pública Obra Publica','Licitación pública', 'Licitación Pública Acuerdo Marco de Precios')
        --AND detalle_objeto LIKE '%SECUNDARIA%'
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
LIMIT
        2000