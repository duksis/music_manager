require 'spec_helper'

describe Album do

  context "validations" do
    it 'should validate presence of title' do
      user = Album.create(attributes_for(:album).reject{|key| key == :title })
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

    context 'albums matching query' do
      let(:albums){Album.search 'Madonna'}
      it {expect(albums.count).to be(1) }
      it {expect(albums.first.artist).to eq('Madonna')}
    end

    context 'albums for specified user' do
      let(:albums){Album.search 'Eminem', @user}
      it {expect(albums.count).to be(1)}
      it {expect(albums.first.title).to eq('8 Mile')}
    end

    it 'should be case insensitive' do
      albums = Album.search 'eminem'
      expect(albums.count).to be(2)
    end

  end
end
