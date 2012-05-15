Feature: Category Management
  As a Admin i should be able to create and new Category which contains name and description.I should also be able to view list of all
  Categories,edit and delete the Category already created.
   
   
   Scenario: Create a new Category with valid data
     Given There is an admin
     And I am on login page
     When I fill in "email" with "admin@vincomm.com"
     And I fill in "password" with "pass123"
     And I press "Log in"
     Then I should be on categories list page
      
  # Scenario: Create a new Category with valid data
  #     Given I am logged in as Admin
  #     And I am on new category page
  #     When I fill in "category_name" with "Category name"
  #     And I fill in "category_description" with "Category description"
  #     And I press "category_submit"
  #     Then I should be on categories list page
  #     And I should see "Category name"