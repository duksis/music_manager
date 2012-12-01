require 'spec_helper'

describe Album do
  let(:valid_attributes){attributes_for(:album)}

  context "validations" do
    it 'should validate presence of title' do
      user = Album.create(valid_attributes.reject{|key| key == :title })
      expect(user.errors.messages.keys).to include(:title)
    end
  end

  describe '.search' do
    before do
      @user = create(:user) do |user|
        user.albums.create attributes_for(:album, :artist=> 'Eminem', :title=>'8 Mile')
        user.albums.create attributes_for(:album, :artist=> 'Madonna', :title=>'American Life')
      end
      create(:album, :artist=>'Eminem')
    end

    it 'should return albums matching query' do
      albums = Album.search 'Madonna'
      expect(albums.count).to be(1)
      expect(albums.first.artist).to eq('Madonna')
    end

    it 'should return albums for specified user' do
      albums = Album.search 'Eminem', @user
      expect(albums.count).to be(1)
      expect(albums.first.title).to eq('8 Mile')
    end

    it 'should be case insensitive' do
      albums = Album.search 'eminem'
      expect(albums.count).to be(2)
    end

  end
end
