SELECT 
    id_adjudicacion AS ID_ADJUDICACION,
    COUNT(*) AS NUM_ADDITION,
    COUNT(CASE(adicion_en_valor > 0, adicion_en_valor, TRUE, NULL)) AS NUM_ADDITION_VALUE,
    COUNT(CASE(adicion_en_dias > 0, fecha_firma, adicion_en_meses > 0, fecha_firma, TRUE, NULL)) AS NUM_ADDITION_TIME,
    MIN(fecha_firma) AS FIRST_ADDITION_AT,
    MIN(CASE(adicion_en_valor > 0, fecha_firma, TRUE, NULL)) AS FIRST_ADDITION_VALUE_AT,
    MIN(CASE(adicion_en_dias > 0, fecha_firma, adicion_en_meses > 0, fecha_firma, TRUE, NULL)) AS FIRST_ADDITION_TIME_AT
    WHERE
    id_adjudicacion IN ({LIST_UID}) 
GROUP BY id_adjudicacion