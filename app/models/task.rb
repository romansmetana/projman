class Task < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :project, optional: true
    
    has_many :task_tags
    has_many :tags, through: :task_tags

    validates :title, :is_done, presence: true
    validates :description, length: {minimum: 1, maximum: 300}
end
