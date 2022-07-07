# frozen_string_literal: true



#2. После отработки скрипта результаты записывает в выходной файл с заданными именем
#3. В задании нужно использовать ​XPATH (не путать с CSS) ​для получения содержимого html элементов, таких как цена, название и т.п. 
#Возможно, понадобится использовать regexp для того чтобы достать отдельные части данных, если xpath
#4. Для скачивания страниц нужно использовать библиотеку ​curb,​ для парсинга страниц ​nokogiri​, для записи в csv файл – модуль ​csv
#5. Скрипт должен работать достаточно быстро и при этом не привлекать к себе внимание администраторов сайта
#6. Во время выполнения скрипта должно быть понятно, что он сейчас делает

require 'open-uri'
require 'nokogiri'

module Parser

#1. Должна ​быть написана программа/скрипт на Ruby​. Программа получает на вход:
#a. ссылка на страницу категории (может передаваться любая категория сайта)
puts 'What is '


category = {antiinflammatory: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=antiflamatorios-para-gatos',
    cancer_tumors: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=cancer-tumorales-para-gatos',
    cardiac: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=cardiacos-para-gatos',
    scarring: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=cicatrizantes-para-gatos',
    cognitive_neurological: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=cognitivos-neurologicos-para-gatos',
    chondroprotectors_joints: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=condroprotectores-articulaciones',
    Dermatitis Y Problemas Piel: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=dermatitis-y-problemas-piel-para-gatos',
 Gastrointestinales:'https://www.petsonic.com/farmacia-para-gatos/?categorias=gastrointestinales-para-gatos',
 Hepáticos:'https://www.petsonic.com/farmacia-para-gatos/?categorias=hepaticos',
 Higiene Dental:'https://www.petsonic.com/farmacia-para-gatos/?categorias=higiene-dental-para-gatos',
 Oculares: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=oculares-para-gatos',
 Óticos: 'https://www.petsonic.com/farmacia-para-gatos/?categorias=oticos-para-gatos',
 Pancreáticos: '',
 Pediatría / Lactancia Y Gestación: '',
 Renales: '',
 Sistema Inmunitario
 Suplementos Y Vitaminas
 Tranquilizantes / Control Estrés
 Urinarios}

 
 Chondroprotectors / Joints
 Dermatitis And Skin Problems
 Gastrointestinal
 liver
 Dental hygiene
 eyepieces
 optics
 Pancreatic
 Pediatrics / Lactation and Pregnancy
 renal
 Immune system
 Supplements and vitamins
 Tranquilizers / Stress Control
 urinals


url = 'https://www.petsonic.com/farmacia-para-gatos/'
html = open(url)
#b. имя файла в который будет записан результат
doc = Nokogiri::HTML(html)

#2. После отработки скрипта результаты записывает в выходной файл с заданными именем
#3. В задании нужно использовать ​XPATH (не путать с CSS) ​для получения содержимого html элементов, таких как цена, название и т.п. 
#Возможно, понадобится использовать regexp для того чтобы достать отдельные части данных, если xpath
#4. Для скачивания страниц нужно использовать библиотеку ​curb,​ для парсинга страниц ​nokogiri​, для записи в csv файл – модуль ​csv
#5. Скрипт должен работать достаточно быстро и при этом не привлекать к себе внимание администраторов сайта
#6. Во время выполнения скрипта должно быть понятно, что он сейчас делает
