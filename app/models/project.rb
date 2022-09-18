class Project < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy

    validates :title, presence: true
    validates :position, numericality: { only_integer: true }
end
