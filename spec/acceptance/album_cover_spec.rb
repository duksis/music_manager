# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/acceptance_helper'

require 'spec_helper'

feature "AlbumCovers", %q{
    For the albums users can upload covers
    which can be displayed in different sizes.
  } do

  background do
    @user = log_in
    cover = fixture_file_upload("#{Rails.root}/spec/support/covers/rocket_man.jpg", 'image/png')
    @album = @user.albums.create attributes_for(:album,:cover=>cover)
  end

  scenario 'Uploading cover' do
    # Given I'm on album edit page
    visit edit_album_path(@album)

    # And I specify the target file
    attach_file 'album_cover', "#{Rails.root}/spec/support/covers/rocket_man.jpg"

    # And I press 'Save'
    click_on 'Save'

    # And I visit album details
    visit album_path(@album)

    # Then I should see the cover
    expect( page ).to have_selector('img')
  end

  scenario 'Changing size' do
    # Given I'm on album details page
    visit album_path(@album)

    # And cover size is large
    expect( page ).to have_css('.large_cover')

    # When I press 'small'
    click_on 'small'

    # Then I should see a small cover
    expect( page ).to have_css('.small_cover')
  end

end
