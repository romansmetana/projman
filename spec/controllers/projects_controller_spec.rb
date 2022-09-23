# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }

  before { sign_in(user) }

  describe '|| GET /index' do
    it '# returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it '# returns http success if params[:direction]' do
      get :index, params: { column: 'position', direction: 'DESC' }
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /show' do
    it '# returns http success' do
      get :show, params: { id: project.id }
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
      { project: { title: 'Test', user_id: user.id } }
    end
    let(:invalid_params) do
      { project: { title: nil, user_id: user.id } }
    end

    it '# project was successfully created' do
      post :create, format: :turbo_stream, params: valid_params
      expect(response).to have_http_status(:success)
    end

    it '# project was not successfully created' do
      post :create, format: :turbo_stream, params: invalid_params
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /edit' do
    it '# returns http success' do
      get :edit, params: { id: project.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| PUT /update' do
    let(:params) { { project: { title: 'New title' }, id: project.id } }
    let(:invalid_params) { { project: { title: nil }, id: project.id } }

    it '# returns http success' do
      put :update, format: :turbo_stream, params: params
      expect(response).to have_http_status(:success)
    end

    it '# returns http success' do
      put :update, format: :turbo_stream, params: invalid_params
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| DELTE /destroy' do
    it '# returns http success' do
      delete :destroy, format: :turbo_stream, params: { id: project.id }
      expect(response).to have_http_status(:success)
    end
  end
end
