# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:user){ create(:user) }
  let(:project){ create(:project, user_id: user.id) }

  before {sign_in(user)}

  describe 'POST /search' do
    it 'when parameters are not equal to ""' do
      post :search, format: :turbo_stream, params: {title: project.title}
      expect(response).to have_http_status(:success)
    end
    it 'when parameters - "" ' do
      post :search, format: :turbo_stream, params: {title: ''} 
      expect(response).to have_http_status(:success)
    end
  end
end
