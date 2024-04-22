SELECT 
    numero_de_contrato AS PENALTY_ID,
    nit_entidad AS NIT_ENTIDAD,
    documento_contratista AS ID_CONTRATISTA,
    valor_sancion AS PENALTY_VALUE,
    fecha_de_firmeza AS PENALTY_DATE
WHERE  
    nit_entidad IN ({NIT_ENTIDAD_LIST})
    OR documento_contratista IN ({NIT_CONTRATISTAS_LIST})