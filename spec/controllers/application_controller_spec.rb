require 'spec_helper'

describe ApplicationController do

  describe 'login_required' do
    controller do
      before_filter :login_required
      def index; end
    end

    context 'unauthenticated user' do
      it 'should request to log in' do
        get :index
        expect( response ).to redirect_to(login_path)
      end

      it 'should save targer path' do
        request.env['PATH_INFO']='/test'
        get :index
        expect( session[:return_to] ).to eq('/test')
      end

      it 'should warn' do
        get :index
        expect(flash[:warning]).to eq("Please log in to continue")
      end
    end

    context 'authenticated user' do
      it 'should try to render view' do
        session[:user_id]=1
        expect{ get :index }.to raise_error(ActionView::MissingTemplate, /anonymous\/index/)
      end
    end

  end

end
