#!/usr/bin/env ruby
require 'active_support/inflector'

# Script para gerar um scaffold no Rails interativamente

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
  model_name = model_name.singularize
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
attribute_type= %w[string text integer float decimal datetime timestamp time date binary boolean references]
def valid_attribute_type?(attr_type)
  attribute_type.include?(attr_type)
end

# Método para gerar o comando scaffold
def generate_scaffold(model_name, attributes)
  attributes_string = attributes.map { |attr| "#{attr[:name]}:#{attr[:type]}" }.join(' ')
  "rails generate scaffold #{model_name} #{attributes_string}"
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
    attr_type = get_input("Digite o tipo do atributo \n (ex: #{attribute_type.})\n : ").gsub(/[^a-zA-Z]/, '').downcase
    
    if valid_attribute_type?(attr_type)
      # Adiciona o atributo à lista
      attributes << { name: formatted_attr_name, type: attr_type }
      break
    else
      puts "Tipo de atributo inválido.\n Tipos válidos: #{attribute_type.})"
    end
  end
  
  # Pergunta se há mais atributos
  more_attributes = get_input("Deseja adicionar mais um atributo? (s/n): ")
  break if %w[n na nao no not nop].include?(more_attributes.downcase)
end

# Gera o comando scaffold
scaffold_command = generate_scaffold(formatted_model_name, attributes)

# Exibe o comando scaffold gerado
puts "Comando scaffold gerado: #{scaffold_command}"

# Executa o comando scaffold no terminal
system(scaffold_command)