# frozen_string_literal: true

class Tag < ApplicationRecord
  belongs_to :user

  has_many :task_tags, dependent: :destroy
  has_many :tasks, through: :task_tags

  validates :title, presence: true
end
