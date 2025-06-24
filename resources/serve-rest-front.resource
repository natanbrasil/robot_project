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
    Fill Text    css=input[data-testid='nome']    TesteM
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
    ${usuario_nome}  Get Text  ${elemento}  ==  TesteM
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${true}    