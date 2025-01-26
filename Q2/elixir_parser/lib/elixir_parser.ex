defmodule Parser do
  # Função principal que inicia o processo de parsing.
  # Recebe uma lista de tokens e chama a função 'parse_programa' para analisar o programa completo.
  def parse(tokens) do
    {ast, []} = parse_programa(tokens)  # A função parse_programa retorna a árvore sintática e os tokens restantes.
    ast  # Retorna a árvore sintática gerada.
  end

  # Função para analisar a estrutura do programa.
  # Verifica se o programa começa com 'program', seguido de um identificador (id) e um ponto e vírgula.
  def parse_programa([{:keyword, "program"}, {:id, id}, {:ponto_virgula, ";"} | restante_tokens]) do
    {stat, tokens_restantes} = parse_declaracao(restante_tokens)  # Chama a função para analisar declarações.
    case tokens_restantes do
      [{:keyword, "end"} | tokens_finais] ->  # Se encontrar 'end', finaliza a análise do programa.
        {{:prog, id, stat}, tokens_finais}  # Retorna a árvore sintática do programa.
      _ -> {:error, "Expected 'end'"}  # Se não encontrar 'end', retorna um erro.
    end
  end

  # Função para analisar uma lista de declarações.
  # Permite múltiplas declarações separadas por ponto e vírgula.
  def parse_lista_declaracoes(tokens) do
    {stat, tokens_restantes} = parse_declaracao(tokens)  # Chama a função para analisar uma declaração.
    case tokens_restantes do
      [{:semicolon, ";"} | tokens_seguinte] ->  # Se encontrar um ponto e vírgula, analisa a próxima declaração.
        {resto_stats, tokens_finais} = parse_lista_declaracoes(tokens_seguinte)
        {[stat | resto_stats], tokens_finais}  # Adiciona a declaração à lista e continua.
      _ -> {[stat], tokens_restantes}  # Se não houver mais declarações, retorna a lista de declarações.
    end
  end

  # Função para analisar declarações específicas.
  def parse_declaracao([{:keyword, "begin"} | restante_tokens]) do
    {stats, tokens_restantes} = parse_lista_declaracoes(restante_tokens)  # Chama a função para analisar uma lista de declarações.
    case tokens_restantes do
      [{:keyword, "end"} | tokens_finais] ->  # Verifica se o bloco 'begin' termina com 'end'.
        {{:begin_end, stats}, tokens_finais}  # Retorna o bloco de declarações.
      _ -> {:error, "Expected 'end'"}  # Se não encontrar 'end', retorna um erro.
    end
  end

  # Função para analisar uma atribuição.
  # Espera um identificador seguido de ':=' e uma expressão.
  def parse_declaracao([{:id, id}, {:operator, ":="} | restante_tokens]) do
    {expr, tokens_restantes} = parse_expressao(restante_tokens)  # Chama a função para analisar a expressão à direita da atribuição.
    {{:assign, id, expr}, tokens_restantes}  # Retorna a atribuição na forma de uma árvore sintática.
  end

  # Função para analisar uma declaração de estrutura condicional (if).
  def parse_declaracao([{:keyword, "if"} | restante_tokens]) do
    {comp, tokens_restantes} = parse_comparacao(restante_tokens)  # Chama a função para analisar a expressão de comparação.
    case tokens_restantes do
      [{:keyword, "then"} | tokens_then] ->  # Se encontrar 'then', analisa o próximo bloco.
        {stat1, tokens_else} = parse_declaracao(tokens_then)  # Analisa a primeira parte do 'if'.
        case tokens_else do
          [{:keyword, "else"} | tokens_finais] ->  # Se encontrar 'else', analisa o bloco do 'else'.
            {stat2, tokens_end} = parse_declaracao(tokens_finais)  # Analisa o bloco do 'else'.
            {{:if, comp, stat1, stat2}, tokens_end}  # Retorna a árvore sintática do 'if' com a expressão condicional e os dois blocos.
          _ -> {:error, "Expected 'else'"}  # Se não encontrar 'else', retorna erro.
        end
      _ -> {:error, "Expected 'then'"}  # Se não encontrar 'then', retorna erro.
    end
  end

  # Função para analisar uma declaração de estrutura de repetição (while).
  def parse_declaracao([{:keyword, "while"} | restante_tokens]) do
    {comp, tokens_restantes} = parse_comparacao(restante_tokens)  # Analisa a expressão de comparação da condição do 'while'.
    case tokens_restantes do
      [{:keyword, "do"} | tokens_do] ->  # Se encontrar 'do', analisa o bloco de instruções.
        {stat, tokens_end} = parse_declaracao(tokens_do)  # Analisa o bloco de instruções do 'while'.
        case tokens_end do
          [{:keyword, "end"} | tokens_finais] ->  # Verifica se o bloco 'while' termina com 'end'.
            {{:while, comp, stat}, tokens_finais}  # Retorna a árvore sintática do 'while' com a condição e o bloco de instruções.
          _ -> {:error, "Expected 'end'"}  # Se não encontrar 'end', retorna erro.
        end
      _ -> {:error, "Expected 'do'"}  # Se não encontrar 'do', retorna erro.
    end
  end

  # Função para analisar uma declaração de leitura.
  def parse_declaracao([{:keyword, "read"}, {:id, id} | restante_tokens]), do: {{:read, id}, restante_tokens}

  # Função para analisar uma declaração de escrita.
  def parse_declaracao([{:keyword, "write"} | restante_tokens]) do
    {expr, tokens_restantes} = parse_expressao(restante_tokens)  # Analisa a expressão a ser escrita.
    {{:write, expr}, tokens_restantes}  # Retorna a árvore sintática da declaração de escrita.
  end

  # Função para analisar comparações (expressões lógicas como ==, <, >, etc).
  def parse_comparacao(tokens) do
    {esquerda, [{:operator, op} | tokens_restantes]} = parse_expressao(tokens)  # Analisa o operando esquerdo da comparação.
    {direita, tokens_finais} = parse_expressao(tokens_restantes)  # Analisa o operando direito da comparação.
    {{:operator, op, esquerda, direita}, tokens_finais}  # Retorna a árvore sintática da comparação.
  end

  # Função para analisar expressões aritméticas.
  def parse_expressao(tokens) do
    {termo, tokens_restantes} = parse_termo(tokens)  # Analisa um termo (número ou variável).
    case tokens_restantes do
      [{:operator, op} | tokens_seguinte] when op in ["+", "-"] ->  # Se encontrar um operador de soma ou subtração, analisa a próxima parte da expressão.
        {direita, tokens_finais} = parse_expressao(tokens_seguinte)
        {{:operator, op, termo, direita}, tokens_finais}  # Retorna a árvore sintática da expressão.
      _ -> {termo, tokens_restantes}  # Se não houver mais operadores, retorna o termo.
    end
  end

  # Função para analisar termos (multiplicação e divisão).
  def parse_termo(tokens) do
    {factor, tokens_restantes} = parse_fator(tokens)  # Analisa o fator da expressão.
    case tokens_restantes do
      [{:operator, op} | tokens_seguinte] when op in ["*", "/"] ->  # Se encontrar um operador de multiplicação ou divisão, analisa a próxima parte.
        {direita, tokens_finais} = parse_termo(tokens_seguinte)
        {{op, factor, direita}, tokens_finais}  # Retorna a árvore sintática do termo.
      _ -> {factor, tokens_restantes}  # Se não houver mais operadores, retorna o fator.
    end
  end

  # Função para analisar fatores (números inteiros, identificadores ou expressões entre parênteses).
  def parse_fator([{:integer, int} | tokens_restantes]), do: {{:integer, int}, tokens_restantes}  # Se for um número, retorna como um fator.
  def parse_fator([{:id, id} | tokens_restantes]), do: {{:id, id}, tokens_restantes}  # Se for um identificador, retorna como um fator.
  def parse_fator([{:parentesis, :left} | tokens_restantes]) do
    {expr, [{:parentesis, :right} | tokens_finais]} = parse_expressao(tokens_restantes)  # Se for uma expressão entre parênteses, analisa a expressão dentro.
    {expr, tokens_finais}  # Retorna a expressão dentro dos parênteses.
  end
end
