*** Settings ***
Documentation     This is a resource file, that can contain variables and keywords.
...               Keywords defined here can be used where this Keywords.resource in loaded.
Library           SeleniumLibrary
Library           CustomLibrary.py


*** Keywords ***
Open Royal Mail Currency Converter
    [Arguments]    ${url}
    Open Browser    ${url}    Firefox
    Maximize Browser Window
    Click Button    ensCloseBanner

Input Exchange Value
    [Documentation]    This adds a value of currency to be exchanged
    [Arguments]    ${value}
    Input Text    tmGBPvalue    150000
    Wait Until Element Contains    tmRatesSummary    Today’s online rate

Place The Order
    Click Element    tmPlaceOrder
    Wait Until Element Is Visible    accept_all_button
    Click Element    accept_all_button
    Wait Until Element Is Visible    gbpValue

Ensure Value Is Lower Than
    [Arguments]    ${value}
    ${SHOWN_VALUE}=    Get Text    gbpValue
    Element Text Should Not Be    gbpValue    150000
    Value Is Lower Than    ${SHOWN_VALUE}    2500