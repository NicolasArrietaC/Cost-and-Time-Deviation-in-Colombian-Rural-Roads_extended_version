SELECT 
    numero_de_contrato AS PENALTY_ID,
    documento_contratista AS ID_CONTRATISTA,
    nombre_contratista AS NAME_CONTRATISTA,
    valor_sancion AS PENALTY_VALUE,
    fecha_de_firmeza AS PENALTY_DATE
WHERE  
     documento_contratista IN ({ID_CONTRATISTA}) OR
     nombre_contratista IN ({NAME_CONTRATISTA})