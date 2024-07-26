*** Settings ***
Documentation     A test suite for valid login.
...
...               Keywords are imported from the resource file
Library          SeleniumLibrary
Library          CustomLibrary.py
Resource         Keywords.resource
Default Tags      positive

*** Variables ***
${LOGIN URL}      https://www.postoffice.co.uk/travel-money/foreign-currency
${BROWSER}        Firefox
${ACCEPT_COOKIES}    ensCloseBanner
${EXPECTED_TITLE}    Foreign Currency Exchange - Bureau de Change | Post Office
${SHOWN_VALUE}    0

*** Test Cases ***
Check site can be loaded
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Click Button    ${ACCEPT_COOKIES}
    Title Should Be  ${EXPECTED_TITLE}
    [Teardown]    Close Browser

Check minimum online spend
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Click Button    ${ACCEPT_COOKIES}
    Click Button    datalist-input
    Click Element    item-AED
    Input Text    tmGBPvalue    150
    Wait Until Element Contains    tmRatesSummary    Today’s online rate
    Click Element    tmPlaceOrder
    Wait Until Element Is Visible    accept_all_button
    Click Element    accept_all_button
    Title Should Be    Great Foreign Currency Exchange Rates - Post Office®
    [Teardown]    Close Browser

Check maximum online spend
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Click Button    ${ACCEPT_COOKIES}
    Click Button    datalist-input
    Click Element    item-AED
    Input Text    tmGBPvalue    150000
    Wait Until Element Contains    tmRatesSummary    Today’s online rate
    Click Element    tmPlaceOrder
    Wait Until Element Is Visible    accept_all_button
    Click Element    accept_all_button
    Wait Until Element Is Visible    gbpValue
    ${SHOWN_VALUE}=    Get Text    gbpValue
    Element Text Should Not Be    gbpValue    150000
    Value Is Lower Than    ${SHOWN_VALUE}    2500
    [Teardown]    Close Browser

Using keywords to perform maximum spend test
    Open Royal Mail Currency Converter    ${LOGIN URL}
    Input Exchange Value    150000
    Place The Order
    Ensure Value Is Lower Than    2500
    [Teardown]    Close Browser