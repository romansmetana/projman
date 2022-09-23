# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let(:task) { create(:task, user_id: user.id) }

  before { sign_in(user) }

  describe '|| GET /index' do
    it '# returns http success' do
      get :index, params: { project: project.id, is_done: false }
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /show' do
    it '# returns http success' do
      get :show, params: { id: task.id }
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
      { task: { title: 'Tester', description: 'The best movie!',
                user_id: user.id } }
    end
    let(:invalid_params) do
      { task: { title: nil, description: 'The best movie!',
                user_id: user.id } }
    end

    it '# task was successfully created' do
      post :create, format: :turbo_stream, params: valid_params
      expect(response).to have_http_status(:success)
    end

    it '# task was not successfully created' do
      post :create, format: :turbo_stream, params: invalid_params
      expect(response).to have_http_status(:success)
    end
  end

  describe '|| GET /edit' do
    it '# returns http success' do
      get :edit, params: { id: task.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    let(:params) { { task: { title: 'New title' }, id: task.id } }
    let(:invalid_params) { { task: { title: nil }, id: task.id } }

    it '# task was successfully updeted' do
      put :update, format: :turbo_stream, params: params
      expect(response).to have_http_status(:success)
    end

    it '# task was not successfully updeted' do
      put :update, format: :turbo_stream, params: invalid_params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /destroy' do
    it '# returns http success' do
      delete :destroy, format: :turbo_stream, params: { id: task.id }
      expect(response).to have_http_status(:success)
    end
  end
end
