# frozen_string_literal: true

class Task < ApplicationRecord
  mount_uploader :file, FileUploader
  belongs_to :user
  belongs_to :project, optional: true

  has_many :task_tags, dependent: :delete_all
  has_many :tags, through: :task_tags

  validates :title, :user_id, presence: true
  validates :description, length: { minimum: 1, maximum: 300 }

  def self.filter(params, current_user)
    tasks = current_user.tasks
    tasks = tasks.includes(:project)
    tasks = tasks.includes(:tags)
    tasks = tasks.includes(:task_tags)
    if params[:project] && params[:project] != ''
      tasks = tasks.where(project_id: current_user.projects.find(params[:project]))
    end
    tasks = tasks.where(is_done: params[:is_done]) if params[:is_done] && params[:is_done] != 'all'
    tasks
  end
end
