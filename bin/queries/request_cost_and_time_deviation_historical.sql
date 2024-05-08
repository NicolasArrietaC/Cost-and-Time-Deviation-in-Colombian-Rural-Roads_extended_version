SELECT 
    nit_de_la_entidad AS NIT_ENTIDAD,
    date_trunc_ym(fecha_de_firma_del_contrato) AS MONTH_AT,
    COUNT(DISTINCT uid) AS PROJECTS,
    -- COUNT(CASE(valor_total_de_adiciones > 0, uid, TRUE, NULL)) AS PROJECTS_W_COST_ADITION,
    -- COUNT(CASE((tiempo_adiciones_en_dias > 0 OR tiempo_adiciones_en_meses > 0), uid, TRUE, NULL)) AS PROJECTS_W_TIME_ADITION,
    COUNT(CASE((tiempo_adiciones_en_dias > 0 OR tiempo_adiciones_en_meses > 0 OR valor_total_de_adiciones > 0), uid, TRUE, NULL)) AS PROJECTS_W_BOTH_ADITION
WHERE  
    nit_de_la_entidad IN ({NIT_ENTIDAD_LIST})
    AND tipo_de_contrato <> 'Prestación de Servicios'
GROUP BY
    NIT_ENTIDAD,
    MONTH_AT
LIMIT 10000


-- sin agregar prestacion de servicio
