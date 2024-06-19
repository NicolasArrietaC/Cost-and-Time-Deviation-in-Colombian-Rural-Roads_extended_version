import pandas as pd
# Otras librerias
from unidecode import unidecode
import re
import os


pd.set_option('display.max_columns', None)
pd.set_option('display.max_colwidth', None)


# Get query files function
def get_path(folder, file_path):
    current_directory = os.getcwd()
    return os.path.join(current_directory, '..', folder, file_path)

# to get the file 'suppliers_list_secop_i.csv' you have to download from the onedrive repo: 
# https://unisalleedu-my.sharepoint.com/:x:/g/personal/narrieta01_unisalle_edu_co/EaM775NLjf5OsHILtN67TC0BvwuVz0CH1KkD1lZWl4Dg8w?e=jneMy6

suppliers_list = pd.read_csv(
    '../data/suppliers_list_secop_i.csv', 
    # nrows=10000,
    dtype=str
                             )

col_names = {
    'Identificacion del Contratista': 'id_contratista',
    'Nom Razon Social Contratista': 'nom_contratista'
    }

suppliers_list.rename(columns=col_names, inplace=True)


suppliers_vias_rurales = pd.read_csv(
    '../data/collected_vias_rurales_data.csv'
                             )

interested_columns = ['ID_CONTRATISTA', 'NOM_CONTRATISTA']

suppliers_vias_rurales = suppliers_vias_rurales[interested_columns]

# Extraer la parte numerica de las columnas de identificacion y nombre
suppliers_list['numbers_from_id'] = suppliers_list['id_contratista'].str.replace(r'\D', '', regex=True)
suppliers_list['numbers_from_name'] = suppliers_list['nom_contratista'].str.replace(r'\D', '', regex=True)

# Extraer la parte de texto de las columnas de identificacion y nombre
def clean_and_normalize(text):
    # Remove digits
    text_without_digits = re.sub(r'\d+', '', str(text))
    text_without_digits = text_without_digits.replace(" ", "")
    # Normalize Unicode characters to their ASCII equivalents
    normalized_text = unidecode(text_without_digits)
    return normalized_text

# Apply the function to the DataFrame column
suppliers_list['chars_from_id'] = suppliers_list['id_contratista'].apply(clean_and_normalize)
suppliers_list['chars_from_name'] = suppliers_list['nom_contratista'].apply(clean_and_normalize)

def key_reforzed(row):
    if pd.isnull(row['numbers_from_id']) and not pd.isnull(row['numbers_from_name']):
        numberpart = row['numbers_from_name']
    else:
        numberpart = row['numbers_from_id']

    if pd.isnull(row['chars_from_name']) and not pd.isnull(row['chars_from_id']):
        textpart = row['chars_from_id']
    else:
        textpart = row['chars_from_name']

    return str(numberpart) + textpart

# Apply the custom function to create a new column
suppliers_list['key_reforzed'] = suppliers_list.apply(key_reforzed, axis=1)

interested_columns = ['id_contratista', 'nom_contratista', 'key_reforzed']

suppliers_vias_rurales = pd.merge(suppliers_vias_rurales, 
                  suppliers_list[interested_columns],
                  left_on=['ID_CONTRATISTA', 'NOM_CONTRATISTA'], 
                  right_on=['id_contratista', 'nom_contratista'], 
                  how='left')

suppliers_vias_rurales.drop(columns=['id_contratista', 'nom_contratista'], inplace=True)

suppliers_vias_rurales = pd.merge(suppliers_vias_rurales, 
                  suppliers_list[interested_columns],
                  left_on=['key_reforzed'], 
                  right_on=['key_reforzed'], 
                  how='left')

col_names = {
    'id_contratista': 'id_contratista_other_versions',
    'nom_contratista': 'nom_contratista_other_versions'
    }

suppliers_vias_rurales.rename(columns=col_names, inplace=True)

print(suppliers_vias_rurales.head(10))

suppliers_vias_rurales.to_csv(get_path('data', 'suppliers_list_secop_standarized.csv'), index=False)