defmodule Main do

  # Função que cria a árvore binária para teste.
  # Aqui é montada uma árvore simples, com alguns nós e suas respectivas subárvores.
  # Cada nó é instanciado usando a função `Tree.no/5`, onde definimos a chave, valor, coordenadas x e y e seus filhos.
  def criar_arvore do
    %Tree{
      chave: "Mercúrio",
      valor: 12,
      esquerda: %Tree{
        chave: "Vênus",
        valor: 18,
        esquerda: %Tree{
          chave: "Terra",
          valor: 25,
          esquerda: nil,
          direita: %Tree{
            chave: "Marte",
            valor: 34,
            esquerda: nil,
            direita: nil
          }
        },
        direita: %Tree{
          chave: "Júpiter",
          valor: 42,
          esquerda: %Tree{
            chave: "Saturno",
            valor: 29,
            esquerda: nil,
            direita: nil
          },
          direita: %Tree{
            chave: "Urano",
            valor: 38,
            esquerda: nil,
            direita: nil
          }
        }
      },
      direita: %Tree{
        chave: "Netuno",
        valor: 45,
        esquerda: %Tree{
          chave: "Plutão",
          valor: 50,
          esquerda: nil,
          direita: nil
        },
        direita: nil
      }
    }
  end

  # Função principal que orquestra a criação da árvore e a adição das coordenadas.
  # Aqui chamamos a função `criar_arvore` para criar a árvore e, em seguida, chamamos `Arvore.adicionar_coord`
  # para calcular as coordenadas dos nós. Por fim, imprimimos a árvore no console para verificar as coordenadas calculadas.
  def main do
    arvore = criar_arvore()
    arvore_com_coordenadas = Tree.adicionar_coordenadas(arvore)
    IO.inspect(arvore_com_coordenadas) # Exibe a árvore no console com as coordenadas calculadas
  end
end

# Chama a função main para rodar o programa
Main.main()
