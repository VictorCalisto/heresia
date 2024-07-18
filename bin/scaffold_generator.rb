#!/usr/bin/env ruby
require 'active_support/all'

# Script para gerar um scaffold no Rails interativamente
ATTRIBUTE_TYPE= %w[string text integer float decimal datetime timestamp time date binary boolean references]
SIM= %w[s si sim y ye yes yep]
# Método para obter entrada do usuário com uma mensagem
def get_input(prompt)
  print prompt
  gets.chomp
end

# Método para validar e formatar o nome do modelo
def format_model_name(model_name)
  # Remove números e caracteres especiais, substituindo por espaços
  model_name = model_name.gsub(/[^a-zA-Z\s]/, '')
  # Capitaliza cada palavra e junta sem espaços
  model_name = model_name.split.map(&:capitalize).join
  # Garante que o nome esteja no singular
  model_name = model_name.singularize(:pt)
  model_name
end

# Método para validar e formatar o nome do atributo
def format_attribute_name(attr_name)
  # Remove números e caracteres especiais, substituindo por espaços
  attr_name = attr_name.gsub(/[^a-zA-Z\s]/, '')
  # Converte para snake_case
  attr_name = attr_name.split.map(&:downcase).join('_')
  attr_name
end

# Método para validar o tipo do atributo
def valid_attribute_type?(attr_type)
  ATTRIBUTE_TYPE.include?(attr_type)
end

# Método para gerar o comando scaffold
def generate_scaffold(model_name, attributes, options = [])
  attributes_string = attributes.map { |attr| "#{attr[:name]}:#{attr[:type]}" }.join(' ')
  options_string = options.any? ? options.map { |option| "--skip-#{option}" }.join(' ') : ''
  "rails generate scaffold #{model_name} #{attributes_string} #{options_string}".strip
end

# Pergunta o nome do modelo ao usuário
model_name = get_input("Digite o nome do modelo: ")
formatted_model_name = format_model_name(model_name)

# Inicializa a lista de atributos
attributes = []

# Loop para adicionar atributos
loop do
  attr_name = get_input("Digite o nome do atributo: ")
  formatted_attr_name = format_attribute_name(attr_name)

  loop do
    attr_type = get_input("Digite o tipo do atributo \n (ex: #{ATTRIBUTE_TYPE})\n : ").gsub(/[^a-zA-Z]/, '').downcase
    
    if valid_attribute_type?(attr_type)
      # Adiciona o atributo à lista
      attributes << { name: formatted_attr_name, type: attr_type }
      break
    else
      puts "Tipo de atributo inválido.\n Tipos válidos: #{ATTRIBUTE_TYPE})"
    end
  end
  
  # Pergunta se há mais atributos
  more_attributes = get_input("Deseja adicionar mais um atributo? (s/n): ")
  break if !SIM.include?(more_attributes.downcase)
end

# Pergunta se o usuário deseja pular alguma parte do scaffold
options = []
if !SIM.include?(get_input("Deseja gerar o scaffold completo ? (s/n): "))
  options << 'view' if !SIM.include?(get_input("Deseja pular a view? (s/n): ").downcase)
  options << 'controller' if !SIM.include?(get_input("Deseja pular o controller? (s/n): ").downcase)
  options << 'model' if !SIM.include?(get_input("Deseja pular o model? (s/n): ").downcase)
  options << 'migration' if !SIM.include?(get_input("Deseja pular a migration? (s/n): ").downcase)
  options << 'resource-route' if !SIM.include?(get_input("Deseja pular a resource route? (s/n): ").downcase)
  options << 'scaffold-stylesheet' if  !SIM.include?(get_input("Deseja pular o scaffold stylesheet? (s/n): ").downcase)
end

# Gera o comando scaffold
scaffold_command = generate_scaffold(formatted_model_name, attributes)

# Exibe o comando scaffold gerado
puts "Comando scaffold gerado: #{scaffold_command}"

# Executa o comando scaffold no terminal
system(scaffold_command)