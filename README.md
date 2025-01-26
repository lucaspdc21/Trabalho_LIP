# Desenhando Árvores e Parsing em Elixir
Este repositório foi construído com o objetivo de armazenar a *Questão 01* e a *Questão 02* da disciplina de Linguagens de Programação do bacharelado em Ciência da Computação. 

As pastas presentes no repositório (*Q1* e *Q2*) armazenam, respectivamente, os programas: Árvore Binária e Parsing.  Além disso, vale ressaltar que essas aplicações foram desenvolvidas em conjunto pelos discentes Lucas Pinheiro da Costa e Luiza Esther Martins Pessoa.

# Questão 01 - Desenhando Árvores
Este projeto implementa uma estrutura de árvore binária utilizando o Elixir. Ele é composto por dois módulos principais: `Tree` e `Main`.

## Como rodar

### 1. Pré-requisitos

- Elixir instalado em sua máquina. Caso não tenha, siga as instruções para instalar o Elixir:
  - [Elixir Install Guide](https://elixir-lang.org/install.html)

### 2. Estrutura do Projeto

O projeto é composto por dois arquivos principais:

- `tree.ex`: Define a estrutura da árvore binária e as funções auxiliares.
- `main.ex`: Contém a função principal que cria a árvore e a exibe no console.

### 3. Passos para executar o projeto

#### 3.1. Clonando o repositório

Primeiro, clone este repositório para o seu computador:

```bash
git clone https://github.com/lucaspdc21/Trabalho_LIP.git
cd Q1
```

#### 3.2.  Compilando o código no IEx
1. Abra o terminal e entre no diretório do projeto.
2. Carregue o arquivo `Tree.ex` para definir a estrutura da árvore.

```bash
iex> c("tree.ex")
```

3.Em seguida, carregue o arquivo `main.ex` que contém a função principal para criar a árvore.

```bash
iex> c("main.ex")
```

## Explicação do código
- Módulo Tree: Define a estrutura de dados da árvore binária, incluindo as funções folha/0 e no/6 para criar nós e folhas.
- Módulo Main: Contém a função criar_arvore/0, que cria uma árvore binária com alguns valores de exemplo.

## Personalizando árvore
Se você quiser modificar a árvore, pode ajustar os valores diretamente no módulo Main dentro da função criar_arvore/0. Isso permitirá personalizar as chaves, valores e a estrutura da árvore conforme necessário.

# Questão 02 - Parsing
Este projeto implementa um **parser** simples em **Elixir**. O parser analisa um conjunto de tokens e gera uma árvore sintática (AST) representando o programa.

## Como rodar

### 1. Pré-requisitos

- Elixir instalado em sua máquina. Caso não tenha, siga as instruções para instalar o Elixir:
  - [Elixir Install Guide](https://elixir-lang.org/install.html)

### 2. Estrutura do Projeto

```
Q2/
├── .formatter.exs
├── .gitignore
├── mix.exs
├── lib/
│   └── elixir_parser.ex
└── test/
    └── parser_test.exs
```

- `lib/parser.ex`: Contém a implementação do parser em Elixir.
- `test/parser_test.exs`: Arquivo com os testes automatizados para validar o comportamento do parser.
- `mix.exs`: Arquivo de configuração do Mix (o gerenciador de dependências e build do Elixir).

### 3. Passos para executar o projeto

#### 3.1. Clonando o repositório

Primeiro, clone este repositório para o seu computador:

```bash
git clone https://github.com/lucaspdc21/Trabalho_LIP.git
cd Q2
```

#### 3.2. Compilando o código e executando os testes

Agora que você tem o repositório localmente, é hora de compilar o código e rodar os testes para garantir que tudo está funcionando corretamente.

2. **Compile o código**:
   ```bash
   mix compile
   ```

3. **Execute os testes**:
   ```bash
   mix test
   ```

Esse comando irá rodar todos os testes localizados no diretório `test/` e mostrar os resultados no terminal. Se todos os testes passarem, você verá algo como:

```
Finished in 0.03 seconds
3 test, 0 failures
```

Caso algum teste falhe, a saída exibirá detalhes sobre a falha, como qual teste não passou e o motivo.

#### 3.3. Modificando testes
Você pode criar novos testes em `elixir_parser_test.exs`, os tokens devem ser criados e passados para parse(). Logo em seguida deve ser feito sua comparação com o resultado esperado
