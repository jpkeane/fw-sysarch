require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'not signed in' do
    describe 'GET #show' do
      it 'returns http found to login page' do
        user = FactoryGirl.create(:user)
        get :show, params: { username: user.username }
        expect(response).to redirect_to login_path
      end
    end
  end

  context 'signed in as wrong user' do
    describe 'GET #show' do
      it 'returns http success' do
        right_user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user)

        request.session[:user_id] = wrong_user.id

        get :show, params: { username: right_user.username }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET #edit' do
      it 'returns http redirect to home page' do
        right_user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user)

        request.session[:user_id] = wrong_user.id

        get :edit, params: { username: right_user.username }
        expect(response).to have_http_status(:found)
      end
    end

    describe 'PATCH #update' do
      it 'returns http redirect to home page' do
        right_user = FactoryGirl.create(:user)
        wrong_user = FactoryGirl.create(:user)

        request.session[:user_id] = wrong_user.id

        patch :update, params: { username: right_user.username }
        expect(response).to have_http_status(:found)
      end
    end
  end
end
