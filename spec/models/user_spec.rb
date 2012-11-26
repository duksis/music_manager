require 'spec_helper'

describe User do
  describe '.encrypt' do
    let(:password) {'welcome1'}
    let(:salt) {'salty string'}
    let(:hashed_password) {'65e82b6f919141bdcc8a45180660bff9f55c6e13'}

    it 'should return hashed password' do
      User.encrypt(password,salt).should eq(hashed_password)
    end

    it 'should raise error if wrong params' do
      expect { User.encrypt(password) }.to raise_error
    end
  end

  describe '.authenticate' do
    before do
      FactoryGirl.create(:user)
    end
    let(:user){FactoryGirl.attributes_for(:user)}

    it 'with valid credentials should return user' do
      User.authenticate(user[:name], user[:password]).should be_a(User)
    end

    it 'with wrong password it should return nil' do
      User.authenticate(user[:name], user[:password].reverse).should be_nil
    end

    it 'with wrong credentials should return nil' do
      User.authenticate('Johnny','secret!').should be_nil
    end
  end

  describe 'validations' do
    valid_attributes = FactoryGirl.attributes_for(:user)

    context 'with valid attributes' do
      it 'should create user' do
        expect { User.create(valid_attributes) }.to change(User,:count).by(1)
      end
    end

    context "should fail when" do
      it 'missing name' do
        user = User.create(valid_attributes.reject{|key| key == :name })
        user.errors.messages.keys.should include(:name)
      end

      it 'missing password' do
        user = User.create(valid_attributes.reject{|key| key == :password })
        user.errors.messages.keys.should include(:password)
      end

      it 'missing password_confirmation' do
        user = User.create(valid_attributes.reject{|key| key == :password_confirmation })
        user.errors.messages.keys.should include(:password_confirmation)
      end

      it 'missmaching password_confirmation' do
        invalid_attributes = valid_attributes.dup
        invalid_attributes[:password_confirmation] = valid_attributes[:password].reverse

        user = User.create(invalid_attributes)
        user.errors.messages.keys.should include(:password)
      end
    end

  end
end
