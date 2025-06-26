*** Settings ***
Library    Browser    
Library    FakerLibrary

*** Variables ***
${BROWSER}  chromium
${HEADLESS}  ${false}    
${URL_SERV_REST}  https://front.serverest.dev/login


*** Keywords ***
Abrir o navegador
    New Browser    ${BROWSER}
    ...            ${HEADLESS}
    New Context    viewport={'width': 1200, 'height': 800}

Ir para o site
    New Page       ${URL_SERV_REST}
    ${TITLE}       Get Title  ==  Front - ServeRest
    Log    ${TITLE}

Preencher os dados do novo usuário e cadastrar
    Click        css=a[data-testid='cadastrar']
    Fill Text    css=input[data-testid='nome']    Deyvid LOUCAUM
    ${EMAIL}      FakerLibrary.email
    Set Test Variable    ${EMAIL}
    Fill Text    css=input[data-testid='email']    ${EMAIL}
    Fill Text    css=input[data-testid='password']    teste123
    Check Checkbox   css=input[data-testid='checkbox']    
    Click    css=button[data-testid='cadastrar']
    

Conferir se o usuário foi cadastrado
    Wait For Elements State       h1    visible
    Get Element States   css=button[data-testid='logout']  validate  value & visible

Acessar a lista de usuário
    Click        css=a[data-testid='listarUsuarios']

Validar se o usuário aparece na listagem
    ${elemento}      Get Table Cell Element    css=table    "Nome"    "${EMAIL}"
    ${usuario_nome}  Get Text  ${elemento}  ==  Deyvid LOUCAUM
    Take Screenshot       fullPage=${true}    

Cadastrar novo Produto
     Click    css=[data-testid='cadastrar-produtos']
     ${NOME_PRODUTO}    FakerLibrary.Word
     Set Test Variable  ${NOME_PRODUTO}
     Fill Text          css=input[data-testid='nome']          ${NOME_PRODUTO}
     Fill Text          css=input[data-testid='preco']         10
     Fill Text          css=textarea[data-testid='descricao']  Produto Teste Robot Framework
     Fill Text          css=input[data-testid='quantity']      5
     Click              text="Cadastrar"

Conferir que o produto aparece na listagem
     ${elemento}   Get Table Cell Element    css=table    "Descrição"    "${NOME_PRODUTO}"
     ${descricao}  Get Text  ${elemento}  ==  Produto Teste Robot Framework
     Take Screenshot       fullPage=${true}
