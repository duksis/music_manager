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
    expect( page ).to have_content(album_details.fetch(:title))
  end

  scenario "Browsing albums" do
    # Given I have music albums
    user = log_in
    user.albums.create(FactoryGirl.attributes_for(:album))

    # When I go to the albums page
    visit albums_path

    # Then I should see a list of albums
    user.albums.each do |album|
      [:title,:artist,:genre].each do |attribute|
        expect( page ).to have_content(album[attribute])
      end
    end

  end

  scenario 'Viewing album' do
    # Given I have music albums
    user = log_in
    album_details = FactoryGirl.attributes_for(:album)
    album = user.albums.create(album_details)

    # And I'm on my albums page
    visit albums_path

    # When I press on a album
    click_link album.title

    # Then I should see its details
    album_details.keys.each do |attribute|
      expect( page ).to have_content(
        Album.human_attribute_name(attribute)
      )
      expect( page ).to have_content(album[attribute])
    end
  end

  scenario 'Updating album'
    # Given I'm on the albums details page
    # When I press "Edit"
    # Then I should be able to edit albums details

  scenario 'Removing album'
    # Given I'm on the albums details page
    # When I press "Remove"
    # Then I should see that my album has been removed

  scenario 'Searching for albums'
    # ...

end
