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
        0 AS tiempo_adiciones_en_meses,
        fecha_de_fin_de_ejecucion AS fecha_fin_ejec_contrato,
        '000000000' AS id_adjudicacion,
        urlproceso,
        '000000000' AS nit_de_la_entidad,
        '000000000' AS identificacion_del_contratista,
        departamento || ' - ' || ciudad as dpto_y_muni_contratista,
        ciudad AS municipio_entidad
WHERE
        detalle_objeto IS NOT NULL
        AND liquidaci_n = 'Si'
        AND codigo_de_categoria_principal LIKE '%.95%'
        AND anno_firma IN ('2014','2015','2016','2017','2018','2019','2020')
        AND cuantia_proceso > 20000000
        AND cuantia_contrato > 20000000
        -- AND nombre_regimen_de_contratacion != 'Régimen Especial' --no hay similar
        AND tipo_de_proceso IN ('Licitación pública Obra Publica','Licitación pública', 'Licitación Pública Acuerdo Marco de Precios')
        AND detalle_objeto  LIKE '%VIA%' 
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
        AND detalle_objeto NOT LIKE '%VIVIENDA%'
        AND detalle_objeto NOT LIKE '%CONSERVACI%N PUENTE%'
        AND detalle_objeto NOT LIKE '%PUENTE%PEATONAL%' 
        AND detalle_objeto NOT LIKE '%CONSTRUCCI%N PUENTE%'
        AND detalle_objeto NOT LIKE '%SUMINISTRO%'
        AND detalle_objeto NOT LIKE '%INTERVENTOR%A%' 
        AND detalle_objeto NOT LIKE '%CONSULTOR%A%' 
        AND detalle_objeto NOT LIKE '%RO%ER%A%' 
        AND detalle_objeto NOT LIKE '%DISEÑO%'  
        AND detalle_objeto NOT LIKE '%UNAR ESFUERZOS%'
        AND detalle_objeto NOT LIKE '%AUNAR ESPUERZOS%'
        AND detalle_objeto NOT LIKE '%CONVENIO INTERADMINISTRATIVO%'
        AND detalle_objeto NOT LIKE '%CONVEIO INTERAMINISTRATIVO%' 
        AND detalle_objeto NOT LIKE '%MANTENIMIENTO RUTINARIO%'
        AND detalle_objeto NOT LIKE '%ESFUERZOS%'
LIMIT
        2000