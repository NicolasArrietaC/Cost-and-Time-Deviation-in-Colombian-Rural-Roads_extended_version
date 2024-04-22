# ips_key_words.py
# Código para extraer las palabras pricipales de las eps y hospitales de todo el país

# Librerias usadas ------------------------------------------------------------------
# Libreria para leer el archivo de ips
import csv

# Libreria para manupular los textos
import nltk

# Correr esta parte solamente la primera vez
#nltk.download('punkt')
#nltk.download('stopwords')

from nltk.corpus import stopwords
from nltk.util import ngrams

# Libreria para generar el resumen de palabras
from collections import Counter
from itertools import compress

# Otras librerias
import numpy as np
from unidecode import unidecode
import sys


# Extraer los nombres de las ips únicas ----------------------------------------------
descriptions = []
groups = []

with open('data/collected_obra_data.csv', newline='', encoding="utf8") as csv_file:

    spamreader = csv.reader(csv_file, delimiter=';')
    
    next(spamreader) # Saltar los encabezados del csv
    
    # Lectura solamente del detalle
    for row in spamreader:
        
        desc = unidecode(row[6].upper())
        group = unidecode(row[28])

        descriptions.append(desc)
        groups.append(group)



# Consolidar todas las palabras conseguidas
all_names = ' '.join(descriptions)
words = nltk.word_tokenize(all_names)

# Lectura de los nombre de los municipios ----------------------------------------------
departments = []
municipies = []

with open('data/departamentos_y_municipios_de_colombia.csv', newline='', encoding="utf8") as csv_file:
    spamreader = csv.reader(csv_file, delimiter=',')
    
    next(spamreader) # Saltar los encabezados del csv

    # Lectura solamente de los nombres de los departamentos
    for row in spamreader:
        
        new_dep = unidecode(row[2].upper())
        new_mun = unidecode(row[4].upper())

        # Almacenar los nuevos departamentos
        is_new_dep = 0
        for dep in departments:
            
            if dep == new_dep:
                is_new_dep = 1
                
        if is_new_dep == 0:
            departments.append(new_dep)

        # Almacenar los nuevos municipios
        is_new_mun = 0
        for mun in municipies:
            
            if mun == new_mun:
                is_new_mun = 1
                
        if is_new_mun == 0:
            municipies.append(new_mun)

all_municipies = ' '.join(departments) + ' '.join(municipies)
words_municipies = nltk.word_tokenize(all_municipies)

#sys.exit("Finalizó")

# Establecer los stopwords
stop_words = [x.upper() for x in set(stopwords.words("spanish"))]

stop_words.append('-')
stop_words.append('.')
stop_words.append(',')
stop_words.append(';')
stop_words.append('?')
stop_words.append('MUNICIPIO')
stop_words.append('DEPARTAMENTO')
# stop_words = stop_words + list(set(words_municipies))

# Remover los stopwords del dataset
key_words = [x for x in words if x not in stop_words]

# Establecer el resumen de palabras seleccionadas
words = Counter(key_words)

freq = list(words.values())
words = list(words.keys())

percentile = 90
threshold = np.percentile(freq, percentile)

final_words = list(compress(words, freq > threshold))

# Almacenar palabras claves
with open('data/final_words.csv', 'w', newline='',encoding="utf8") as file:
     writer = csv.writer(file)
     writer.writerow(final_words)


def top_k_ngrams(word_tokens,n, percentile):
    
    ## Getting them as n-grams
    n_gram_list = list(ngrams(word_tokens, n))

    ### Getting each n-gram as a separate string
    n_gram_strings = [' '.join(each) for each in n_gram_list]
    
    n_gram_counter = Counter(n_gram_strings)
    
    freq = list(n_gram_counter.values())
    words = list(n_gram_counter.keys())

    threshold = np.percentile(freq, percentile)

    final_words = list(compress(words, freq > threshold))

    return(final_words)

# Imprimir el resultado
print("Total key words saved: {words}".format(words = len(final_words)))

grams = top_k_ngrams(key_words, 4, 90)

with open('data/grams4_vias_secundarias.csv', 'w', newline='',encoding="utf8") as file:
     writer = csv.writer(file)
     writer.writerow(grams)

