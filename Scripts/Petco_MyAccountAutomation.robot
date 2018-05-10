*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           Selenium2Library
Library           String

*** Variables ***
${LOGIN URL}        https://cmswcappt01.petc.com/shop/en/petcostore
${BROWSER}          chrome
${HomePageTitle}    Pet Supplies, Pet Food, and Pet Products from petco.com
${AcctPageTitle}    My Account
${Username}         bopustester@petco.com
${Password}         Petco123
${petType}          Dog
${petName}          Hachikee
${prefStoreZip}     92025

*** Test Cases ***
Verify whether the Registered user is able to navigate to My Account sections successfully
    Open Browser and launch the application
    Sign in to the application
    My Account Validation
    Removing all Pets from Pet Profile Page
    My Pet Profile Validation
    PALS Rewards Validation
    Order History Validation
    Change My Store Validation
    [Teardown]    Close Browser

*** Keywords ***
Open Browser and launch the application
    Open Browser    ${LOGIN URL}    ${BROWSER}
    maximize browser window
    log to console  Navigated to the Website successfully and is maximized

Sign in to the application
    Title Should Be   ${HomePageTitle}
    log to console  Title of the Home page is verified successfully
    Wait Until Element Is Visible   xpath=//div[@class='account']/a/i      10
    Click Element    xpath=//div[@class='account']/a/i
    log to console  Account icon is clicked successfully
    Wait Until Element Is Visible   xpath=//button[text()='Sign In']      10
    input text       xpath=//input[@name='logonId']   ${Username}
    input text       xpath=//input[@name='logonPassword']   ${Password}
    Click Element    xpath=//button[text()='Sign In']
    log to console  SignIn button is clicked successfully
    Wait Until Element Is Visible   xpath=//h1[text()='My Account']      10
    log to console  User is signed into the application successfully

My Account Validation
    Title Should Be   ${AcctPageTitle}
    log to console  Title of the Account page is verified successfully
    Wait Until Element Is Visible   xpath=//h3[text()='Pals Rewards Contact Info']      10
    log to console  Pals Rewards Contact Info Header is found successfully
    Wait Until Element Is Visible   xpath=//h3[text()='Online Profile']      10
    log to console  Online Profile Header is found successfully
    Wait Until Element Is Visible   xpath=//h3[text()=' My Store']      10
    log to console  My Store Header is found successfully

Removing all Pets from Pet Profile Page
    Wait Until Element Is Visible   xpath=//A[text()='My Pet Profile']      10
    Click Element    xpath=//A[text()='My Pet Profile']
    log to console  My Pet Profile link is clicked successfully
    Wait Until Element Is Visible   xpath=//A[text()='Add a New Pet']       10
    log to console  Navigated to My Pet Profile page successfully
    ${count}=    Get Matching Xpath Count    xpath=//a[text()='Remove']
#    Wait Until Element Is Visible   xpath=(//a[text()='Remove'])[1]       10
#    Click Element    xpath=(//a[text()='Remove'])[1]
#    alert should be present   text=Are you sure you want to remove this pet from your account?
#    Sleep   3s


    :FOR    ${index}    IN RANGE    ${count}
    \    Log    ${index}
    \    Wait Until Element Is Visible   xpath=(//a[text()='Remove'])[1]       10
    \    Click Element    xpath=(//a[text()='Remove'])[1]
    \    alert should be present   text=Are you sure you want to remove this pet from your account?
    \    Sleep   3s
    \    log to console  Number of Remove buttons ${index}

My Pet Profile Validation
    Wait Until Element Is Visible   xpath=//A[text()='My Pet Profile']      10
    Click Element    xpath=//A[text()='My Pet Profile']
    log to console  My Pet Profile link is clicked successfully
    Sleep   2s
    Wait Until Element Is Visible   xpath=//A[text()='Add a New Pet']       10
    log to console  Navigated to My Pet Profile page successfully
    Click Element    xpath=//A[text()='Add a New Pet']
    Wait Until Element Is Visible   xpath=//H1[text()='Add a New Pet']       10
    log to console  Navigated to Add a New Pet page successfully
    input text       xpath=//input[@name='petName']   ${petName}
    click element   xpath=//select[@id="new-pet-petType"]
    wait until element is visible   xpath=//option[contains(text(),'Dog')]    10
    click element   xpath=//option[contains(text(),'Dog')]
    Sleep    2s
    click element   xpath=//select[@id="new-pet-petBreed"]
    wait until element is visible   xpath=//option[contains(text(),'Akita')]   10
    click element   xpath=//option[contains(text(),'Akita')]
    click element   xpath=//select[@name="petDobMonth"]
    wait until element is visible   xpath=//option[contains(text(),'6')]        10
    click element   xpath=//option[contains(text(),'6')]
    click element   xpath=//select[@name="petDobDay"]
    wait until element is visible   xpath=//option[contains(text(),'24')]       10
    click element   xpath=//option[contains(text(),'24')]
    click element   xpath=//select[@name="petDobYear"]
    wait until element is visible   xpath=//option[contains(text(),'2013')]     10
    click element   xpath=//option[contains(text(),'2013')]
    Click Element   xpath=//button[text()='save']
    wait until element is visible   xpath=//h5/div[text()='${petName}']         10
    #Deleting the Pet that is added already

PALS Rewards Validation
    Wait Until Element Is Visible   xpath=//ul[@id='local-nav']/li/a[text()='Pals Rewards']     10
    Click Element    xpath=//ul[@id='local-nav']/li/a[text()='Pals Rewards']
    log to console  Pals Rewards link is clicked successfully
    Wait Until Element Is Visible   xpath=//A/strong[text()='View Pals Rewards Transaction History']       10
    log to console  Navigated to PALS Rewards page successfully
    ${palsId}=    Get Text    xpath=//li[@class='user-pals-number']/strong
    log to console  Pals Id in the Console ${palsId}
    #Load Rewards button is not available

Order History Validation
    Wait Until Element Is Visible   xpath=//A[text()='Order History']     10
    Click Element    xpath=//A[text()='Order History']
    log to console  Order History link is clicked successfully
    Sleep   2s
    Wait Until Element Is Visible   xpath=//h3[text()='My Orders']      10
    log to console  Navigated to the My Orders successfully
    Click Element    xpath=(//A/strong[text()='view details'])[1]
    log to console  The most recent Order's link is opened to view the details
    Wait Until Element Is Visible   xpath=//p[text()='Order Placed']      10
    log to console  Order details page is displayed successfully
    ${orderNo}=    Get text    xpath=//strong[text()='Order Number']/parent::DIV
    @{words} =  split string from right  ${orderNo}       ,Order Number
    log to console  Split functionality: @{words}[0]

    log to console  The Order Number fetched: ${orderNo.strip()}

Change My Store Validation
    Wait Until Element Is Visible   xpath=//ul[@id='local-nav']/li/a[text()='My Account']     10
    Click Element    xpath=//ul[@id='local-nav']/li/a[text()='My Account']
    log to console  My Account link is clicked successfully
    Wait Until Element Is Visible   xpath=//A[text()='Change My Store']      10
    Click Element    xpath=//A[text()='Change My Store']
    log to console  "Change My Store" link is clicked
    Wait Until Element Is Visible   xpath=//h1[text()='Store Locator']      10
    log to console  Navigated to Store Locator Page successfully
    input text       xpath=//input[@id='stlocZipCode']   ${prefStoreZip}
    Click Element    xpath=//A[text()='Find Stores']
    Wait Until Element Is Visible  xpath=//*[text()[contains(.,'${prefStoreZip}')]]/ancestor::div[@class='store']    10
    log to console  Searched Zip is found successfully
    Click Element    xpath=//*[text()[contains(.,'${prefStoreZip}')]]/ancestor::div[@class='store']/descendant::span[text()='Make My Store']
    wait until element is enabled  //*[text()[contains(.,'${prefStoreZip}')]]/ancestor::div[@class='store']/descendant::small[text()='My Store']
    log to console  The Selected Store is Set As My Store in Store Locator page successfully
    Wait Until Element Is Visible   xpath=//div[@class='account']/a/i      10
    Click Element    xpath=//div[@class='account']/a/i
    Wait Until Element Is Visible   xpath=//h1[text()='My Account']      10
    log to console  Navigated back to the My account page successfully
    Wait Until Element Is Visible   xpath=//*[text()[contains(.,'${prefStoreZip}')]]/ancestor::section[@id='my_preferred_store']      10
    log to console  The Selected Store is Set As My Store in My Account page successfully
