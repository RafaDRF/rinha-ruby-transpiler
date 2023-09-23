# rinha-ruby
Interpretador de *Abstract Syntax Tree* (AST) para a [rinha-de-compiler](https://github.com/aripiprazole/rinha-de-compiler). 

Meu primeiro contato com o assunto, então só escrevi os testes e fui indo.

## Como funciona
Ele lê a AST localizada em `/var/rinha/source.rinha.json` e executa um código Ruby equivalente.

## Como executar

Buildar a imagem docker:
```
docker build -t rinha .
```
e rodar:
```
docker run rinha
```

## Como gerar uma nova AST
Usando o parser disponibilizado pela organização da Rinha:

```
rinha var/rinha/source.rinha > var/rinha/source.rinha.json
```
Para configurar o parser é preciso:
- Instalar o Rust
- Instalar o Parser:
    ```
    cargo install rinha
    ```
- Adicionar o Cargo ao $PATH
