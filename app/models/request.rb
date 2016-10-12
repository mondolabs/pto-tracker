class Request < ApplicationRecord
	enum status: [:pending, :approved, :declined]
	belongs_to :user
end
