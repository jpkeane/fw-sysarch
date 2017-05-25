require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:right_user) { FactoryGirl.create(:user) }
  let!(:wrong_user) { FactoryGirl.create(:user) }

  context 'not signed in' do
    describe 'GET #show' do
      it 'returns http found to login page' do
        get :show, params: { username: wrong_user.username }
        expect(response).to redirect_to login_path
      end
    end
  end

  context 'signed in as wrong user' do
    before(:each) do
      request.session[:user_id] = wrong_user.id
    end

    describe 'GET #show' do
      it 'returns http success' do
        request.session[:user_id] = wrong_user.id

        get :show, params: { username: right_user.username }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET #edit' do
      it 'returns http redirect to home page' do
        request.session[:user_id] = wrong_user.id

        get :edit, params: { username: right_user.username }
        expect(response).to have_http_status(:found)
      end
    end

    describe 'PATCH #update' do
      it 'returns http redirect to home page' do
        request.session[:user_id] = wrong_user.id

        patch :update, params: { username: right_user.username }
        expect(response).to have_http_status(:found)
      end
    end
  end

  context 'signed in as correct user' do
    before(:each) do
      request.session[:user_id] = right_user.id
    end

    describe 'GET #show' do
      it 'returns http success' do
        get :show, params: { username: right_user.username }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET #edit' do
      it 'returns http redirect to home page' do
        get :edit, params: { username: right_user.username }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PATCH #update' do
      it 'allows correct update of user' do
        patch :update, params: {
          username: right_user.username,
          user: {
            first_name: 'NewName'
          }
        }

        expect(response).to have_http_status(:found)

        right_user.reload
        expect(right_user.first_name).to eq 'NewName'
      end
    end
  end
end
