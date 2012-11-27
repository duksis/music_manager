require File.dirname(__FILE__) + '/acceptance_helper'

feature "Users" do
  # As a person I can create a user account, sign in and out

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

  scenario "Signing in" do
    # Given I have a user account
    FactoryGirl.create(:user)
    me = FactoryGirl.attributes_for(:user)

    # And I'm on the application home page
    visit login_url

    # When I fill in my credentials
    fill_in 'name', :with => me[:name]
    fill_in 'password', :with => me[:password]

    # And I press "Sign in"
    click_button 'Sign in'

    # Then I should be loggend in as me
    page.should have_content("Welcome #{me[:name]}!")
  end

  scenario "Sigging out" do
    # Given I'm logged in
    me = FactoryGirl.attributes_for(:user)
    log_in me

    # When I press "Sign out"
    click_link "Sign out"

    # Then I should be logged out
    page.should have_content("successfully signed out!")
  end

end
