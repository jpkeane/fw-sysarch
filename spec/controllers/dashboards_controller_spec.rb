require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  context 'not signed in' do
    describe 'GET #show' do
      it 'returns http found to login page' do
        get :show
        expect(response).to have_http_status(:found)
      end
    end
  end

  context 'signed in' do
    describe 'GET #show' do
      it 'returns http success' do
        user = FactoryGirl.create(:user)
        request.session[:user_id] = user.id
        get :show
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'remembered' do
    describe 'GET #show' do
      it 'returns http success' do
        user = FactoryGirl.create(:user)
        token = user.remember
        cookies.signed[:user_id] = user.id
        cookies[:remember_token] = token
        get :show
        expect(response).to have_http_status(:success)
      end
    end
  end
end
