require File.dirname(__FILE__) + '/acceptance_helper'

feature "Users", %q{
    As an person
    I can create a user account, log in and out
  } do

  scenario "Creating user account" do
    # Given I'm on the application homepage
    visit homepage

    # When I press "Sign up"
    click_link "Sign up"

    # And I fill in my details
    my_details = attributes_for(:user)
    my_details.each do |attribute, content|
      fill_in "user_#{attribute}", :with => content
    end

    # And I press "Create user"
    click_button "Create User"

    # Then I should see that my account has been created
    expect( page ).to have_content("Account successfully created!")
  end

  scenario "Logging in" do
    # Given I have a user account
    create(:user)
    me = attributes_for(:user)

    # And I'm on the application home page
    visit login_url

    # When I fill in my credentials
    fill_in 'name', :with => me[:name]
    fill_in 'password', :with => me[:password]

    # And I press "Log in"
    click_button 'Log in'

    # Then I should be loggend in as me
    expect( page ).to have_content("Welcome #{me[:name]}!")
  end

  scenario "Logging out" do
    # Given I'm logged in
    me = attributes_for(:user)
    log_in me

    # When I press "Log out"
    click_link "Log out"

    # Then I should be logged out
    expect( page ).to have_content("successfully logged out!")
  end

end
