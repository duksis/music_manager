require 'spec_helper'

describe Album do
  let(:valid_attributes){FactoryGirl.attributes_for(:album)}

  context "validations" do
    it 'should validate presence of title' do
      user = Album.create(valid_attributes.reject{|key| key == :title })
      expect(user.errors.messages.keys).to include(:title)
    end
  end
end
