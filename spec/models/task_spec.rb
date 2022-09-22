# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user){ create(:user) }
  let!(:tag){ create(:tag, user_id: user.id) }
  let!(:project){ create(:project, user_id: user.id) }
  let!(:task){ create(:task, project_id: project.id, tag_ids: tag.id, user_id: user.id) }

  describe "|| when task was deleted" do
    it "# the user will not be deleted" do
      expect(user).to have_attributes(:name => user.name, :surname => user.surname)
    end
    it "# all projects are not deleted " do
      Task.destroy_all
      expect(project).to have_attributes(:title => project.title)
    end

    it "# all tags are not deleted " do
      Task.destroy_all
      expect(tag).to have_attributes(:title => tag.title)
    end
    
    it "# all task_tags are deleted " do
      expect { Task.destroy_all }.to change { TaskTag.count}.from(1).to(0)
    end
  end

  describe "|| when task vilidation was passed" do
    it '# task is valid' do
      expect(task).to be_valid
    end
    it '# task can exist without tag_ids' do
      task.tag_ids = nil
      expect(task).to be_valid
    end
    it '# task can not exist without project_id' do
      task.project_id = nil
      expect(task).to be_valid
    end
  end

  describe '|| when task validation was failed' do
    it '# task is not a valid without a title' do
      task.title = nil
      expect(task).not_to be_valid
    end
    it '# task can not exist without user_id' do
      task.user_id = nil
      expect(task).not_to be_valid
    end
    it "# when the description is longer than 300 characters" do
      task.description = "test" * 80
      expect(task).not_to be_valid
    end
  end
end
