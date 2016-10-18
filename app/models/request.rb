class Request < ApplicationRecord
	enum status: [:pending, :approved, :declined]
	belongs_to :user
	validates :start_date, presence: true, date: { before_or_equal_to: :end_date, message: " of a request must be before its end."} 
	validates_presence_of :end_date
end
