SELECT 
    identificacion_del_contratista || nom_razon_social_contratista AS ID_CONTRATISTA,
    date_trunc_ym(fecha_de_firma_del_contrato) AS MONTH_AT,
    date_extract_y(fecha_de_firma_del_contrato) AS YEAR_AT,
    COUNT(DISTINCT uid) AS PROJECTS,
    -- COUNT(CASE(valor_total_de_adiciones > 0, uid, TRUE, NULL)) AS PROJECTS_W_COST_ADITION,
    -- COUNT(CASE((tiempo_adiciones_en_dias > 0 OR tiempo_adiciones_en_meses > 0), uid, TRUE, NULL)) AS PROJECTS_W_TIME_ADITION,
    COUNT(CASE((tiempo_adiciones_en_dias > 0 OR tiempo_adiciones_en_meses > 0 OR valor_total_de_adiciones > 0), uid, TRUE, NULL)) AS PROJECTS_W_BOTH_ADITION,
    SUM(cuantia_proceso) AS SUM_ESTIMATED_COST_ORIG,
    SUM(cuantia_contrato) AS SUM_CONTRACT_VALUE_ORIG,
    SUM(CASE((rango_de_ejec_del_contrato = 'M' ), plazo_de_ejec_del_contrato*30, TRUE, plazo_de_ejec_del_contrato)) AS SUM_ORIGINAL_DEADLINE
WHERE  
    ID_CONTRATISTA IN ({ID_CONTRATISTA})
    AND tipo_de_contrato = 'Obra'
    AND date_extract_y(fecha_de_firma_del_contrato) >= 2013
GROUP BY
    ID_CONTRATISTA,
    MONTH_AT,
    YEAR_AT
LIMIT 20000


-- sin agregar prestacion de servicio

