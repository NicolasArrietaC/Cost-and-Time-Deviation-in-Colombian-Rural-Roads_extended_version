"""
Utility funtions for ETL process
"""
# Author: Heriberto Felizzola Jimenez <ing.heriberto.felizzola@gmail.com>

import os
from sodapy import Socrata # type: ignore
import pandas as pd
import numpy as np
#import seaborn as sns
#import matplotlib.pyplot as plt
#pd.set_option('display.max_columns', None)

def extract_data(query, url='www.datos.gov.co', id_data='xvdy-vvsk', api_key='SzZ4759qpp2oHfKaHnlgR5T1n'):
    """
    Extract data from the Socrata API
    """
    
    # Create client
    socrata_token = None
    
    if api_key != None:
        socrata_token = os.environ.get(api_key)
    
    client = Socrata(url, socrata_token, timeout=100)


    # Query data
    query_results = client.get(id_data, query=query)
    query_results = pd.DataFrame.from_dict(query_results)
    print("El numero de contratos extraidos: {}".format(query_results.shape[0]))
    return query_results


def process_data(df):
    """
    Process data
    """
    
    # Set data type 
    df = (df
     .astype({'cuantia_proceso':'float',
              'cuantia_contrato':'float',
              'valor_total_de_adiciones':'float',
              'valor_contrato_con_adiciones':'float',
              'anno_firma':'int32',
              'plazo_de_ejec_del_contrato':'int32',
              'tiempo_adiciones_en_dias':'int32',
              'tiempo_adiciones_en_meses':'int32',
              'fecha_fima':'datetime64[ns]',
              'fecha_ini_ejec_contrato':'datetime64[ns]',
              'fecha_fin_ejec_contrato':'datetime64[ns]',
              'id_adjudicacion':'object',
              'nit_de_la_entidad':'object',
              'identificacion_del_contratista':'object'}))
    
    # Rename columns
    df.rename(columns={'cuantia_proceso':'ESTIMATED_COST_ORIG',
                       'plazo_de_ejec_del_contrato':'ORIGINAL_DEADLINE',
                       'cuantia_contrato':'CONTRACT_VALUE_ORIG',
                       'valor_contrato_con_adiciones':'FINAL_COST_ORIG',
                       'valor_total_de_adiciones':'ADDITIONAL_COST_ORIG',
                       'anno_firma':'YEAR',
                       'orden_entidad': 'MUNICIPALITY_TYPE',
                       'departamento_entidad': 'DEPARTMENT',
                       'fecha_fima':'CONTRACT_DATE',
                       'fecha_ini_ejec_contrato':'START_DATE',
                       'fecha_fin_ejec_contrato':'END_DATE',
                       'nombre_de_la_entidad':'ENTITY_NAME',
                       'municipio_entidad':'MUNICIPALITY',
                       'tipo_de_proceso':'PROCESS_TYPE',
                       'objeto_a_contratar':'CONTRACT_OBJECT',
                       'detalle_objeto':'OBJETC_DETAIL',
                       'uid':'CONTRACT_ID',
                       'id_adjudicacion':'ID_ADJUDICACION',
                       'urlproceso':'URLPROCESO',
                       'nit_de_la_entidad':'NIT_ENTIDAD',
                       'identificacion_del_contratista':'ID_CONTRATISTA'}, 
              inplace=True)
    
    # Scale all values of contracto to monthly legal minimimun salary 
    cuantia_col = ['ESTIMATED_COST_ORIG', 'CONTRACT_VALUE_ORIG', 'ADDITIONAL_COST_ORIG', 'FINAL_COST_ORIG']
    
    salario_minimo = {2014:616000, 
                      2015:644350,
                      2016:689455,
                      2017:737717,
                      2018:781242,
                      2019:828116,
                      2020:877803,
                      2021:908526,
                      2022:1000000,
                      2023:1160000,
                      2024:1300000}
    
    for col in cuantia_col:
        temp = [val/salario_minimo[anno] for val,anno in zip(df[col],df['YEAR'])]
        df[col.replace("_ORIG", "_NORM")] = temp
        del temp
    
    # Convert all duration to days 
    df.loc[df['rango_de_ejec_del_contrato'] == 'M', 'ORIGINAL_DEADLINE'] = df['ORIGINAL_DEADLINE']*30
    df.drop(columns=['rango_de_ejec_del_contrato'], inplace=True)

    # Unify additional time to days
    df['ADDITIONAL_TIME'] = df['tiempo_adiciones_en_dias'] + df['tiempo_adiciones_en_meses']*30
    df.drop(columns=['tiempo_adiciones_en_dias', 'tiempo_adiciones_en_meses'], inplace=True)

    # Calculate duration of project
    df['FINAL_DEADLINE'] = df['ORIGINAL_DEADLINE'] + df['ADDITIONAL_TIME']
    
    # Calculate project intensity
    df['PROJECT_INTENSITY_NORM'] = df['CONTRACT_VALUE_NORM']/df['ORIGINAL_DEADLINE']
    df['PROJECT_INTENSITY_ORIG'] = df['CONTRACT_VALUE_ORIG']/df['ORIGINAL_DEADLINE']

    # Calculate award growth
    df['AWARD_GROWTH_NORM'] = ((df['CONTRACT_VALUE_NORM'] - df['ESTIMATED_COST_NORM'])/df['ESTIMATED_COST_NORM'])
    df['AWARD_GROWTH_ORIG'] = ((df['CONTRACT_VALUE_ORIG'] - df['ESTIMATED_COST_ORIG'])/df['ESTIMATED_COST_ORIG'])

    # Calculate cost deviation
    df['COST_DEVIATION_ORIG'] = (df['FINAL_COST_ORIG'] - df['CONTRACT_VALUE_ORIG'])/df['CONTRACT_VALUE_ORIG']
    df['COST_DEVIATION_NORM'] = (df['FINAL_COST_NORM'] - df['CONTRACT_VALUE_NORM'])/df['CONTRACT_VALUE_NORM']

    # Calculate cost deviation 
    df['TIME_DEVIATION'] = (df['FINAL_DEADLINE'] - df['ORIGINAL_DEADLINE'])/df['ORIGINAL_DEADLINE']

    
    # Standardize owner
    df['OWNER'] = df['MUNICIPALITY_TYPE']
    original_municipality_type = ['TERRITORIAL DISTRITAL MUNICIPAL NIVEL 1',
                                  'TERRITORIAL DISTRITAL MUNICIPAL NIVEL 2',
                                  'TERRITORIAL DISTRITAL MUNICIPAL NIVEL 3',
                                  'TERRITORIAL DISTRITAL MUNICIPAL NIVEL 4',
                                  'TERRITORIAL DISTRITAL MUNICIPAL NIVEL 5',
                                  'TERRITORIAL DISTRITAL MUNICIPAL NIVEL 6',
                                  'TERRITORIAL DEPARTAMENTAL CENTRALIZADO',
                                  'TERRITORIAL DEPARTAMENTAL DESCENTRALIZADO',
                                  'DISTRITO CAPITAL',
                                  'NACIONAL CENTRALIZADO']

    new_municipality_type = ['TYPE_1', 'TYPE_2', 'TYPE_3', 'TYPE_4', 'TYPE_5', 'TYPE_6', 'OTHER', 'OTHER', 'OTHER', 'OTHER']
    df['MUNICIPALITY_TYPE'] = df['MUNICIPALITY_TYPE'].replace(original_municipality_type, new_municipality_type)

    # Reassign municipality type
    new_owner = ['MUNICIPALITY', 'MUNICIPALITY', 'MUNICIPALITY', 'MUNICIPALITY', 'MUNICIPALITY', 'MUNICIPALITY', 'DEPARTMENT_GOVERNMENT', 'DEPARTMENT_GOVERNMENT', 'OTHER', 'OTHER']
    df['OWNER'] =  df['OWNER'].replace(original_municipality_type, new_owner)

    # Assign regions
    AMAZONIA = ['Amazonas', 'Caquetá', 'Putumayo', 'Guainía', 'Guaviare', 'Vaupés']
    ORINOQUIA = ['Meta', 'Arauca', 'Casanare', 'Vichada']
    ANDINA = ['Antioquia', 'Boyacá', 'Caldas', 'Cundinamarca', 'Huila', 'Norte De Santander', 'Quindío', 'Risaralda', 'Santander', 'Tolima', 'Bogotá D.C.']
    CARIBE = ['Atlántico', 'Bolívar', 'Cesar', 'Córdoba', 'La Guajira', 'Magdalena', 'Sucre', 'San Andrés, Providencia y Santa Catalina']
    PACIFICA = ['Cauca', 'Valle del Cauca', 'Chocó', 'Nariño']

    df['REGION'] = df['DEPARTMENT'].apply(lambda x: 'AMAZONIA' if x in AMAZONIA else
                                            'ORINOQUIA' if x in ORINOQUIA else
                                            'ANDINA' if x in ANDINA else
                                            'CARIBE' if x in CARIBE else
                                            'PACIFICA' if x in PACIFICA else
                                            'OTRA')

    # Some columns to upper case
    df['DEPARTMENT'] = df['DEPARTMENT'].str.upper()
    df['PROCESS_TYPE'] = df['PROCESS_TYPE'].str.upper()
    df['CONTRACT_OBJECT'] = df['CONTRACT_OBJECT'].str.upper()   
    df['OBJETC_DETAIL'] = df['OBJETC_DETAIL'].str.upper()

    return df