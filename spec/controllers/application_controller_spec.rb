require 'spec_helper'

describe ApplicationController do

  describe 'login_required' do
    controller do
      before_filter :login_required
      def index; end
    end

    context 'unauthenticated user' do
      before do
        request.env['PATH_INFO']='/test'
        get :index
      end
      it { expect( response ).to redirect_to(login_path) }

      it 'should save targer path' do
        expect( session[:return_to] ).to eq('/test')
      end

      it 'should warn' do
        expect(flash[:warning]).to eq("Please log in to continue")
      end
    end

    context 'authenticated user' do
      it 'should try to render view' do
        expect{ get :index, {}, user_id:1 }.to raise_error(ActionView::MissingTemplate, /anonymous\/index/)
      end
    end

  end

end
