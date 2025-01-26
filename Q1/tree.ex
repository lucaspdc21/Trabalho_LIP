# Dupla: Lucas Pinheiro e Luiza Esther Martins

defmodule Tree do

  # Estrutura de dados que representa um nó de uma árvore binária.
  # Cada nó contém:
  # - chave: o identificador do nó (como "A", "B", etc.);
  # - valor: algum valor armazenado no nó (um número ou qualquer outro dado);
  # - x, y: as coordenadas do nó, que serão calculadas para definir onde o nó será posicionado em um plano;
  # - esquerda: o filho esquerdo do nó, que é outro nó ou nil (caso não tenha filho);
  # - direita: o filho direito do nó, que também pode ser outro nó ou nil;
  defstruct [:chave, :valor, :x, :y, :esquerda, :direita]

  # Função para criar um nó "folha", ou seja, um nó que não contém filhos.
  # Retorna uma árvore binária com o nó definido como nulo (sem filhos esquerdo ou direito);
  def folha do
    %Tree{esquerda: nil, direita: nil}
  end

  # Função para criar um nó com todos os seus parâmetros:
  def no(chave, valor, x, y, esquerda, direita) do
    %Tree{chave: chave, valor: valor, x: x, y: y, esquerda: esquerda, direita: direita}
  end

  # Função recursiva que implementa o algoritmo de Busca em Profundidade (DFS - Depth First Search) que percorre a árvore para calcular as coordenadas dos nós.
  # Essa função vai ajustar as coordenadas 'x' e 'y' de cada nó com base na posição de seus filhos.
  # A função é chamada de forma recursiva para as subárvores esquerda e direita, calculando as coordenadas dos nós.
  # O cálculo de x é baseado na média das posições dos filhos esquerdo e direito.
  #
  # - `nivel`: é a profundidade atual do nó na árvore. Ele vai determinar a coordenada `y` (distância vertical).
  # - `limite_esquerdo`: é o limite da posição x para a subárvore esquerda. Ele vai ajudar a calcular a posição do nó
  #                       de forma a não sobrepor outros nós.
  #
  # A recursão ocorre de forma que, ao atingir um nó folha (nulo), ele retorna o limite atual da posição x.
  def dfs(nil, _nivel, limite_esquerdo) do

    # Caso base: quando encontramos um nó folha (nil), simplesmente retornamos o limite x atual.
    {nil, limite_esquerdo, limite_esquerdo}

  end

def dfs(%Tree{chave: chave, valor: valor, esquerda: esquerda, direita: direita}, nivel, limite_esquerdo) do
  y = 40 * nivel

  # Fazendo a chamada recursiva para a subárvore da esquerda
  {esquerda_atualizada, raiz_esquerda_x, _} = dfs(esquerda, nivel + 1, limite_esquerdo)

  # Fazendo a chamada recursiva para a subárvore da direita
  limite_direito = raiz_esquerda_x + 50 # Distância entre os nós
  {direita_atualizada, raiz_direita_x, _} = dfs(direita, nivel + 1, limite_direito)

  # Calculando a posição X do nó
  x =
    cond do
      # Caso o nó tenha ambos os filhos
      esquerda_atualizada != nil and direita_atualizada != nil ->
        div(raiz_esquerda_x + raiz_direita_x, 2)

      # Caso o nó tenha apenas o filho esquerdo
      esquerda_atualizada != nil ->
        raiz_esquerda_x

      # Caso o nó tenha apenas o filho direito
      direita_atualizada != nil ->
        raiz_direita_x

      # Caso o nó seja folha
      true ->
        limite_esquerdo
    end

  # O `max_x` é o maior valor entre a posição `x` do nó e a posição `x` dos filhos.
  max_x = max(raiz_direita_x || raiz_esquerda_x, x)

  # Retorna o nó com as novas coordenadas x e y, além de retornar as coordenadas x e o limite máximo das subárvores.
  {
    %Tree{
      chave: chave,
      valor: valor,
      x: x,
      y: y,
      esquerda: esquerda_atualizada,
      direita: direita_atualizada
    },
    x,
    max_x
  }
end


  # Função que inicializa a árvore e adiciona as coordenadas (x, y) a todos os nós.
  # Ela utiliza a função `dfs` para calcular as coordenadas dos nós e retornar a árvore com as coordenadas calculadas.
  def adicionar_coordenadas(tree) do

    {new_tree, _x, _} = dfs(tree, 0, 0)
    new_tree

  end
end
