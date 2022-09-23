# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:task) { create(:task, user_id: user.id) }
  let!(:tag) { create(:tag, user_id: user.id) }

  before { user }

  describe '|| when user was deleted' do
    it '# User.count = 0' do
      expect { described_class.destroy_all }.to change(described_class, :count).from(1).to(0)
    end

    it '# all projects are deleted' do
      expect { described_class.destroy_all }.to change { user.projects.count }.from(1).to(0)
    end

    it '# all tasks are deleted' do
      expect { described_class.destroy_all }.to change { user.tasks.count }.from(1).to(0)
    end

    it '# all tags are deleted' do
      expect { described_class.destroy_all }.to change { user.tags.count }.from(1).to(0)
    end
  end

  describe '|| when user vilidation was passed' do
    it '# user is valid' do
      expect(user).to be_valid
    end
  end

  describe '|| when user validation was failed' do
    it '# user is not a valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it '# user is not a valid without a surname' do
      user.surname = nil
      expect(user).not_to be_valid
    end

    it '# user is not valid without a email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    context '** email is already been taken' do
      it '# validation will be fail' do
        user = build(:user)
        expect(user).not_to be_valid
      end
    end
  end
end
