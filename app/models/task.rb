class Task < ApplicationRecord
  belongs_to :users, optional: true
  validates :name,        presence: true,
                          length: { minimum: 2 }
  validates :priority,    presence: true, numericality: { only_integer: true }
  validates :due,         presence: true
end
