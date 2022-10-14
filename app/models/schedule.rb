class Schedule < ApplicationRecord
  validates :availability, :location, :gender, presence: true

  belongs_to :user
end
