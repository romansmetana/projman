# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  before_save :set_position

  validates :title, presence: true
  validates :position, numericality: { only_integer: true }

  def set_position
    if Project.first
      self.position = Project.last.position + 1
    else
      self
    end
  end
end
