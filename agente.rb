puts 'Olá PO, bem-vindo ao seu Agente Priorizador!'
puts 'Insira o título da demanda para avaliação:'

class Demanda
attr_accessor :titulo, :tem_okr, :tem_dados, :tem_urgencia
def initialize(titulo:, tem_okr:, tem_dados:, tem_urgencia:)
@titulo = titulo
@tem_okr = tem_okr
@tem_dados = tem_dados
@tem_urgencia = tem_urgencia
end

def pontuacao

pontos = 0
pontos += 3 if @tem_okr
pontos += 2 if @tem_dados
pontos += 1 if @tem_urgencia
pontos
end
end

usuario = []

10.times do |i|
puts "Insira o título da demanda #{i+1}:"

titulo = gets.chomp
puts "Tem OKR? (s/n)"

tem_okr = gets.chomp.downcase == 's'
puts "Tem dados? (s/n)"

tem_dados = gets.chomp.downcase == 's'
puts "Tem urgência? (s/n)"

tem_urgencia = gets.chomp.downcase == 's'

demanda_usuario << Demanda.new(

titulo: titulo,
tem_okr: tem_okr,
tem_dados: tem_dados,
tem_urgencia: tem_urgencia

)
end
puts "Ranking de Demandas"
# Exemplo de uso
demanda_usuario.each do |item|
puts "Demanda: #{item.titulo} | Pontuação: #{item.pontuacao}"
end
