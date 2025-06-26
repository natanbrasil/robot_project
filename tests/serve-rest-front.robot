*** Settings ***    
Resource   ../resources/serve-rest-front.resource

*** Test Cases ***
Login com sucesso Serve Rest front
    Abrir o navegador
    Ir para o site
    Preencher os dados do novo usuário e cadastrar
    Conferir se o usuário foi cadastrado
    Acessar a lista de usuário
    Validar se o usuário aparece na listagem
    Cadastrar novo Produto
    Conferir que o produto aparece na listagem