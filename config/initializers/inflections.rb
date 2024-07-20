# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, "\\1en"
#   inflect.singular /^(ox)en/i, "\\1"
#   inflect.irregular "person", "people"
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:pt) do |inflect|
  inflect.acronym "RESTful"
  
  # Regras de pluralizacao
  inflect.plural /$/, 's'               # carro -> carros
  inflect.plural /r$/i, 'res'           # mulher -> mulheres
  inflect.plural /l$/i, 'is'            # animal -> animais
  inflect.plural /m$/i, 'ns'            # homem -> homens
  inflect.plural /ao$/i, 'oes'          # cao -> caes
  inflect.plural /el$/i, 'eis'          # papel -> papeis
  inflect.plural /il$/i, 'is'           # barril -> barris
  inflect.plural /ul$/i, 'uis'          # azul -> azuis
  inflect.plural /s$/i, 'ses'           # pais -> paises
  inflect.plural /z$/i, 'zes'           # cruz -> cruzes
  inflect.plural /al$/i, 'ais'          # animal -> animais
  inflect.plural /ol$/i, 'ois'          # sol -> sois
  inflect.plural /ul$/i, 'uis'          # azul -> azuis
  inflect.plural /x$/i, 'xes'           # tox -> toxes

  # Regras de singularizacao
  inflect.singular /s$/i, ''            # carros -> carro
  inflect.singular /res$/i, 'r'         # mulheres -> mulher
  inflect.singular /is$/i, 'l'          # animais -> animal
  inflect.singular /ns$/i, 'm'          # homens -> homem
  inflect.singular /oes$/i, 'ao'        # caes -> cao
  inflect.singular /eis$/i, 'el'        # papeis -> papel
  inflect.singular /is$/i, 'il'         # barris -> barril
  inflect.singular /uis$/i, 'ul'        # azuis -> azul
  inflect.singular /ses$/i, 's'         # paises -> pais
  inflect.singular /zes$/i, 'z'         # cruzes -> cruz
  inflect.singular /ais$/i, 'al'        # animais -> animal
  inflect.singular /ois$/i, 'ol'        # sois -> sol
  inflect.singular /xes$/i, 'x'         # toxes -> tox

  # Regras irregulares
  inflect.irregular 'heresia', 'heresias'

  # Palavras nao contaveis
  inflect.uncountable %w(torax xadrez tenis lapis fenix onibus caris lupus pires climax parentesis triceps biceps duplex triplex)
end
