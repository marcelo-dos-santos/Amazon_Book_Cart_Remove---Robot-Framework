*** Settings ***
Library    SeleniumLibrary
Library    Screenshot

*** Variables ***
${URL}                    https://www.amazon.com.br
${LOGO_AMAZON}            //a[contains(@class,'nav-logo-link nav-progressive-attribute')]
${BOOK}                   //a[@class='a-link-normal s-underline-text s-underline-link-text s-link-style a-text-normal'][contains(.,'The Lord of the Rings: Boxed Set')]
${BOOK_NAME}              //span[@class='a-size-extra-large'][contains(.,'The Lord of the Rings: Boxed Set')]
${CART}                   //input[contains(@name,'submit.add-to-cart')]
${ADD_TO_CART}            //span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]  
${CART_NAV}               //span[@aria-hidden='true'][contains(.,'Carrinho')]
${DELETE_CART}            //input[@value='Excluir']

*** Keywords ***

Close Browser
    Close Browser

The user is on the Amazon website
    Open Browser     browser=chrome
    Go To    url=${URL}
    Maximize Browser Window
    Wait Until Element Is Visible    locator=${LOGO_AMAZON}

the user searches for "${product}" book
    Wait Until Page Contains Element    id=twotabsearchtextbox
    Input Text    id=twotabsearchtextbox    ${product}
    Click Button    xpath=//input[@type='submit' and @value='Ir']
    Wait Until Page Contains    ${product}

selects the first search result
    Sleep    5s
    Click Element    locator=${BOOK}
    Wait Until Element Is Visible    locator=${BOOK_NAME}

adds the book to the shopping cart
    Click Button    xpath=//input[contains(@name,'submit.add-to-cart')]
    Element Should Be Visible    locator=${ADD_TO_CART}
    Take Screenshot

goes to the shopping cart page
    Click Element    locator=${CART_NAV}
    Wait Until Element Is Visible    locator=//h1[contains(.,'Carrinho de compras')]

the shopping cart should contain the "The Lord of the Rings" book
    Element Should Be Visible    locator=//span[@class='a-truncate-cut'][contains(.,'The Lord of the Rings: Boxed Set')]
    Element Text Should Be    locator=//span[@class='a-truncate-cut'][contains(.,'The Lord of the Rings: Boxed Set')]    expected=The Lord of the Rings: Boxed Set

the user removes the book from the shopping cart
    Sleep    3s
    Click Element    locator=${DELETE_CART}

the shopping cart should be empty
    Wait Until Page Contains    Seu carrinho de compras da Amazon está vazio.
    Take Screenshot
