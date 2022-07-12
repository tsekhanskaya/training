# frozen_string_literal: true

products =
  [
    [['farmadiet Hepatosil para Gato y Perro -10kg (30 Comprimidos)'],
     ['20.22'],
     ['https://www.petsonic.com/24209-large_default/hepatosil-para-gato-perro-10kg.jpg']],
    [['farmadiet Hepatosil para Perro +10 Kg 200/20 (30 Comprimidos)'],
     ['27.50'],
     ['https://www.petsonic.com/15037-large_default/hepatosil-para-perro-10-kg.jpg']],
    [['farmadiet Hepatosil Plus para Perro y Gato (30 Comprimidos)',
      'farmadiet Hepatosil Plus para Perro y Gato (60 Comprimidos)'],
     ['21.41',
      '36.50'],
     ['https://www.petsonic.com/28952-large_default/hepatosil-plus-para-perro-gato.jpg']],
    [['Vetnova Adiva Hepátic para Gato (60 Comprimidos)'],
     ['30.50'],
     ['https://www.petsonic.com/13236-large_default/adiva-hepatic-para-gato.jpg']],
    [['Silycure Protector hepatico perros y gatos (60 Comprimidos - 40 mg)',
      'Silycure Protector hepatico perros y gatos (30 Comprimidos - 160 mg)'],
     ['23.91',
      '35.14'],
     ['https://www.petsonic.com/25126-large_default/silycure-protector-hepatico-perros-y-gatos.jpg']],
    [['JTPharma Hepato Pharma para Perro y Gato (60 Comprimidos)',
      'JTPharma Hepato Pharma para Perro y Gato (300 Comprimidos)'],
     ['19.71',
      '75.03'],
     ['https://www.petsonic.com/15548-large_default/hepato-pharma-para-perro-gato.jpg']],
    [['JTPharma Hepato Pharma Same Solución para Perro y Gato (55 ml)'],
     ['35.57'],
     ['https://www.petsonic.com/15551-large_default/hepato-pharma-same-solucion-para-perro-gato.jpg']]
  ]

result = []
products.each do |product|
  # get information about all names, prices, pictures
  product.each_with_index do |elem, index_elem|
    # information about names or prices or pictures
    elem.each_with_index do |_item, _index_item|
      if elem.size == 1
        result << "#{elem[0]}, #{elem[1]}, #{elem[2]}"
        break
      else
        result << "#{elem[0][index_elem]}, #{elem[1][index_elem]}, #{elem[2]}" # add name, price, picture
      end
      break
    end
  end
end
print result

# result = ['farmadiet Hepatosil para Gato y Perro -10kg (30 Comprimidos), , ',
#         '20.22, , ',
#         'https://www.petsonic.com/24209-large_default/hepatosil-para-gato-perro-10kg.jpg, , ',
#         'farmadiet Hepatosil para Perro +10 Kg 200/20 (30 Comprimidos), , ',
#         '27.50, , ',
#         'https://www.petsonic.com/15037-large_default/hepatosil-para-perro-10-kg.jpg, , ',
#         'f, f, ',
#         '1, 6, ',
#         'https://www.petsonic.com/28952-large_default/hepatosil-plus-para-perro-gato.jpg, , ',
#         'Vetnova Adiva Hepátic para Gato (60 Comprimidos), , ',
#         '30.50, , ',
#         'https://www.petsonic.com/13236-large_default/adiva-hepatic-para-gato.jpg, , ',
#         'S, S, ',
#         '3, 5, ',
#         'https://www.petsonic.com/25126-large_default/silycure-protector-hepatico-perros-y-gatos.jpg, , ',
#         'J, J, ',
#         '9, 5, ',
#         'https://www.petsonic.com/15548-large_default/hepato-pharma-para-perro-gato.jpg, , ',
#         'JTPharma Hepato Pharma Same Solución para Perro y Gato (55 ml), , ', '35.57, , ',
#         'https://www.petsonic.com/15551-large_default/hepato-pharma-same-solucion-p']
