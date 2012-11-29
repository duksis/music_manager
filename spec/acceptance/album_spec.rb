require File.dirname(__FILE__) + '/acceptance_helper'

feature "Albums" do
# As a user, I can add, view, update and remove my albums
# and as a user I can search my own albums.

  scenario "Adding album" do
    # Given I'm on my homepage
    me = FactoryGirl.attributes_for(:user)
    album_details = FactoryGirl.attributes_for(:album)
    log_in me
    visit homepage

    # When I press "Add"
    click_link 'Add'

    # And I fill in the add album form
    album_details.each do |attribute, content|
      fill_in "album_#{attribute}", :with => content
    end

    # And I press "Save"
    click_button 'Save'

    # Then I should see that my album has been added
    page.should have_content(album_details.fetch(:title))
  end

  scenario "Browsing albums" do
    pending
    #   Given I have music albums
    me = FactoryGirl.create(:user) do |user|
      user.albums.create(attributes_for(:album))
    end

    #   When I go to the homepage

    #   Then I should see a list of albums
  end

# Scenario: Viewing album
#   Given I'm on my homepage
#   And I have music albums
#   When I press on a album
#   Then I should see its details

# Scenario: Updating album
#   Given I'm on the albums details page
#   When I press "Edit"
#   Then I should be able to edit albums details

# Scenario: Removing album
#   Given I'm on the albums details page
#   When I press "Remove"
#   Then I should see that my album has been removed

# scenario "Searching for albums" do
  # ...

# end

end
