# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:user){ create(:user) }
  let!(:tag){ create(:tag, user_id: user.id) }
  let!(:task){ create(:task, tag_ids: tag.id, user_id: user.id) }

  describe "|| when tag was deleted" do
    it "# the user will not be deleted" do
      Task.destroy_all
      expect(user).to have_attributes(:name => user.name, :surname => user.surname)
    end

    it "# all tasks are not deleted " do
      Task.destroy_all
      expect(tag).to have_attributes(:title => tag.title)
    end
    
    it "# all task_tags are deleted " do
      expect { Tag.destroy_all }.to change { TaskTag.count}.from(1).to(0)
    end
  end

  describe "|| when tag vilidation was passed" do
    it '# tag is valid' do
      expect(tag).to be_valid
    end
    it '# tag can exist without task_id' do
      tag.task_ids = nil
      expect(tag).to be_valid
    end
  end

  describe '|| when tag validation was failed' do
    it '# tag is not a valid without a title' do
      tag.title = nil
      expect(tag).not_to be_valid
    end
    it '# tag can not exist without user_id' do
      tag.user_id = nil
      expect(tag).not_to be_valid
    end
  end
end
