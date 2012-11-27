module HelperMethods
  def log_in user_details
    User.create(user_details)
    visit login_url
    fill_in 'name', :with => user_details[:name]
    fill_in 'password', :with => user_details[:password]
    click_button 'Sign in'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
