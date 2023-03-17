*** Settings ***
Library    SeleniumLibrary
Resource   amazon_resources.robot

*** Test Cases ***
Test Case 01 - Search book, add to the cart and remove.
    [Documentation]  This test search a book, add him to the cart, see if goes well
    ...              if he is on the cart go to the cart and remove the book.
    [Tags]           book    cart
    Given the user is on the Amazon website
    When the user searches for "The Lord of the Rings" book
    And selects the first search result
    And adds the book to the shopping cart
    And goes to the shopping cart page
    Then the shopping cart should contain the "The Lord of the Rings" book
    When the user removes the book from the shopping cart
    Then the shopping cart should be empty
