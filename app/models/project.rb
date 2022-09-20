# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: { only_integer: true }

  def set_position
    if Project.first
      update(position: Project.last.position + 1)
    else
      self
    end
  end
end
