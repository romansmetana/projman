# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let!(:task) { create(:task, project_id: project.id, user_id: user.id) }

  describe '|| when project was deleted' do
    it '# the user will not be deleted' do
      described_class.destroy_all
      expect(user).to have_attributes(name: user.name, surname: user.surname)
    end

    it '# all project tasks are deleted' do
      expect { described_class.destroy_all }.to change(Task, :count).from(1).to(0)
    end
  end

  describe '|| project set_position method' do
    it '# when set_position return true' do
      expect { project.set_position }.to change(project, :position).from(0).to(1)
    end

    it '# when set_position return false' do
      described_class.destroy_all
      project = build(:project, user_id: user.id)
      project.set_position
      expect(project.position).to eq(0)
    end
  end

  describe '|| when project vilidation was passed' do
    it '# project is valid' do
      expect(project).to be_valid
    end
  end

  describe '|| when tag validation was failed' do
    it '# project is not a valid without a title' do
      project.title = nil
      expect(project).not_to be_valid
    end

    it '# project can not exist without user_id' do
      project.user_id = nil
      expect(project).not_to be_valid
    end
  end
end
