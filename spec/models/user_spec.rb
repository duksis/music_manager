require 'spec_helper'

describe User do
  let(:attributes) {attributes_for(:user)}

  describe '.encrypt' do
    let(:password) {'welcome1'}

    it 'should return hashed password' do
      hashed_password = '65e82b6f919141bdcc8a45180660bff9f55c6e13'
      salt = 'salty string'
      expect( User.encrypt(password,salt) ).to eq(hashed_password)
    end

    it 'should raise error if wrong params' do
      expect{ User.encrypt(password) }.to raise_error
    end
  end

  describe '.authenticate' do
    before {create(:user)}

    it 'with valid credentials should return user' do
      expect( User.authenticate(attributes[:name], attributes[:password]) ).to be_a(User)
    end

    it 'with wrong password it should return nil' do
      expect( User.authenticate(attributes[:name], attributes[:password].reverse) ).to be_nil
    end

    it 'with wrong credentials should return nil' do
      expect( User.authenticate('Johnny','secret!') ).to be_nil
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'should create user' do
        expect{ User.create(attributes) }.to change(User,:count).by(1)
      end
    end

    it { should validate_presence_of :name }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
    it { should validate_confirmation_of :password }
    it { should validate_uniqueness_of :name }

    it 'should validate length of password' do
      short_password = attributes
      short_password[:password_confirmation]='?'
      short_password[:password]='?'
      user = User.create(short_password)
      expect( user.errors.messages.keys ).to include(:password)
    end

  end
end
