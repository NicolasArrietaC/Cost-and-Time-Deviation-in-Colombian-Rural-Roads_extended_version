SELECT 
    numero_de_contrato AS PENALTY_ID,
    nit_entidad AS NIT_ENTIDAD,
    valor_sancion AS PENALTY_VALUE,
    fecha_de_firmeza AS PENALTY_DATE
WHERE  
    nit_entidad IN ({NIT_ENTIDAD_LIST})