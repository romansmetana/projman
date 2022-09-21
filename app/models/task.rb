# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project, optional: true

  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  validates :title, presence: true
  validates :description, length: { minimum: 1, maximum: 300 }

  def self.filter(params, current_user)
    tasks = current_user.tasks.all
    tasks = tasks.where(project_id: current_user.projects.find(params[:project])) if params[:project] && params[:project] != ''
    tasks = tasks.where(is_done: params[:is_done]) if params[:is_done] && params[:is_done] != 'all'
    tasks
  end
end
