class Task < ApplicationRecord
  has_many :issues, dependent: :destroy
  enum status: { not_started: 0, in_progress: 1, completed: 2}
end
