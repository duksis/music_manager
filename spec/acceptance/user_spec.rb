require File.dirname(__FILE__) + '/acceptance_helper'

feature "Users" do
  # As a person I can create a user account, sign in and out
  # and as a user to search your own albums.

  scenario "Creating user account" do
    # Given I'm on the application homepage
    visit homepage

    # When I press "Sign up"
    click_link "Sign up"

    # And I fill in my details
    my_details = FactoryGirl.attributes_for(:user)
    my_details.each do |attribute, content|
      fill_in "user_#{attribute}", :with => content
    end

    # And I press "Create user"
    click_button "Create User"

    # Then I should see that my account has been created
    page.should have_content("Account successfully created!")
  end

  # scenario "Signing in" do
  #   # Given I have a user account
  #   # And I'm on the application home page
  #   # When I fill in my credentials
  #   # And I press "Login"
  #   # Then I should be loggend in as me
  # end

  # scenario "Logging out" do
  #   # Given I'm logged in
  #   # When I press "Log out"
  #   # Then I should be logged out
  # end

  # scenario "Searching for albums" do
    # ...

  # end
end
