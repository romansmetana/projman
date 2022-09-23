# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:user) { create(:user) }
  let(:tag) { create(:tag, user_id: user.id) }

  before { sign_in(user) }

  describe '|| GET /index' do
    it '# returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /index' do
    it '# returns http success' do
      get :show, params: { id: tag.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /new' do
    it '# returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| POST /create' do
    let(:valid_params) do
      { tag: { title: 'Test', user_id: user.id } }
    end
    let(:invalid_params) do
      { tag: { title: nil, user_id: user.id } }
    end

    it '# tag was successfully created' do
      post :create, format: :turbo_stream, params: valid_params
      expect(response).to have_http_status(:success)
    end

    it '# tag was not successfully created' do
      post :create, format: :turbo_stream, params: invalid_params
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /edit' do
    it 'returns http success' do
      get :edit, params: { id: tag.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| PUT /update' do
    let(:params) { { tag: { title: 'New title' }, id: tag.id } }
    let(:invalid_params) { { tag: { title: nil }, id: tag.id } }

    it '# tag was successfully updeted' do
      put :update, format: :turbo_stream, params: params
      expect(response).to have_http_status(:success)
    end

    it '# tag was not successfully updeted' do
      put :update, format: :turbo_stream, params: invalid_params
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| DELETE /destroy' do
    it '# returns http success' do
      delete :destroy, format: :turbo_stream, params: { id: tag.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
