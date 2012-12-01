require 'spec_helper'

describe "routing" do
  it "routes / to albums#index" do
    expect(:get => "/").to route_to(
      :controller => "albums",
      :action => "index"
    )
  end
  it "routes login to sessions#new" do
    expect(:get => "/login").to route_to(
      :controller => 'sessions',
      :action => 'new'
    )
  end
  it "routes put login to sessions#create" do
    expect(:post => "/login").to route_to(
      :controller => 'sessions',
      :action => 'create'
    )
  end
  it "routes logout to sessions#new" do
    expect(:get => "/logout").to route_to(
      :controller => 'sessions',
      :action => 'destroy'
    )
  end
  it "routes search to albums#search" do
    expect(:get => "/search").to route_to(
      :controller => 'albums',
      :action => 'search'
    )
  end
end
