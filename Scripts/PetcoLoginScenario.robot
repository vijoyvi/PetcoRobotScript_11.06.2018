*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           Selenium2Library
Variables         ../Variables/file_variables.py
Variables         ../Locators/file_variables.py

*** Variables ***
${LOGIN URL}       https://cmswcappt01.petc.com/shop/en/petcostore
${BROWSER}         Chrome
${HomePageTitle}   Pet Supplies, Pet Food, and Pet Products from petco.com
${Username}   bopustester@petco.com
${Password}   Petco123

*** Test Cases ***
Verify whether the Login Functionality of Petco is working properly
    Open Browser To Login Page
    Verify the Home Page Title
    Click on the Account icon
    Sign in to the application
    #Adding an extra comment
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    maximize browser window
    log to console  Navigated to the Website successfully and is maximized

Verify the Home Page Title
    Title Should Be   ${HomePageTitle}
    log to console  Title of the Home page is verified successfully

Click on the Account icon
    Wait Until Element Is Visible   xpath=//div[@class='account']/a/i      10
    Click Element    xpath=//div[@class='account']/a/i
    log to console  Account icon is clicked successfully

Sign in to the application
    Wait Until Element Is Visible   xpath=//button[text()='Sign In']      10
    input text       xpath=//input[@name='logonId']   ${Username}
    input text       xpath=//input[@name='logonPassword']   ${Password}
    Click Element    xpath=//button[text()='Sign In']
    log to console  SignIn button is clicked successfully
    Wait Until Element Is Visible   xpath=//h1[text()='My Account']      10
    log to console  User is signed into the application successfully





