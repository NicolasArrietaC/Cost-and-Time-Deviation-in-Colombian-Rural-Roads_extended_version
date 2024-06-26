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
        identificacion_del_contratista,
        dpto_y_muni_contratista,
        municipio_entidad,
        nom_razon_social_contratista
WHERE
        anno_firma IS NOT NULL
        AND fecha_fima IS NOT NULL
        AND detalle_objeto IS NOT NULL

        AND nombre_grupo = '[G] Terrenos, Edificios, Estructuras y vías'
        --AND id_familia = '9511'
        AND estado_del_proceso = 'Liquidado'
        AND anno_firma IN ('2021','2022','2023')
        AND cuantia_proceso > 20000000
        AND cuantia_contrato > 20000000
        AND nombre_regimen_de_contratacion != 'Régimen Especial' --already updated (regimen_de_contratacion)
        AND tipo_de_proceso IN ('Licitación obra pública','Licitación Pública')
        AND tipo_de_contrato = 'Obra'
        --AND detalle_objeto LIKE '%SECUNDARIA%'
        AND detalle_objeto  LIKE '%VIA%' 
        AND detalle_objeto NOT LIKE '%TERCIARIA%'
        AND detalle_objeto NOT LIKE '%PLACA HUELLA%'
        AND detalle_objeto NOT LIKE '%VEREDA%'
        AND detalle_objeto NOT LIKE '%RURAL%'
        AND detalle_objeto NOT LIKE '%REDUCTORES DE VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%MUROS DE CONTENCIÓN%'
        AND detalle_objeto NOT LIKE '%DEMOLICIÓN%'
        AND detalle_objeto NOT LIKE '%RESTAURACIÓN ESTACIÓN FÉRREA%'
        AND detalle_objeto NOT LIKE '%REDUCTORES DE VELOCIDAD%'
        AND detalle_objeto NOT LIKE '%BARANDAS%'
        AND detalle_objeto NOT LIKE '%MUROS DE CONTENCIÓN%'
        AND detalle_objeto NOT LIKE '%DEMOLICIÓN%'
        AND detalle_objeto NOT LIKE '%RESTAURACIÓN ESTACIÓN FÉRREA%'
        AND detalle_objeto NOT LIKE '%SEÑALIZACIÓN%'
        AND detalle_objeto NOT LIKE '%REHABILITACIÓN Y CONSERVACIÓN PUENTE%'
        AND detalle_objeto NOT LIKE '%MANTENIMIENTO T%NEL%'
        AND detalle_objeto NOT LIKE '%ALCANTARILLA%'
        AND detalle_objeto NOT LIKE '%MANO DE OBRA%'
        AND detalle_objeto NOT LIKE '%BOX CULVERT%'
        AND detalle_objeto NOT LIKE '%PUENTES COLGANTES%'
        AND detalle_objeto NOT LIKE '%EJERCITO%'
        AND detalle_objeto NOT LIKE '%SEMAFORIZACIÓN%'
        AND detalle_objeto NOT LIKE '%DEMOLICIONES%'
        AND detalle_objeto NOT LIKE '%MURO%'
        AND detalle_objeto NOT LIKE '%CICLOVÍAS%'
        AND detalle_objeto NOT LIKE '%CICLORUTA%'
        AND detalle_objeto NOT LIKE '%RESIDUOS SÓLIDOS%'
        AND detalle_objeto NOT LIKE '%DESMONTE Y LIMPIEZA%'
        AND detalle_objeto NOT LIKE '%AULAS%'
        AND detalle_objeto NOT LIKE '%OBRAS DE ARTE%'
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
        -- NEW FILTERS
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
        AND NOT(detalle_objeto LIKE '%VEREDA%' OR detalle_objeto LIKE '%RURAL%' OR detalle_objeto LIKE '%TERCIARIA%')
LIMIT
        10000