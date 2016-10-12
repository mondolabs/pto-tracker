class Department < ApplicationRecord
	has_many :teams
	has_many :users, through: :teams
	
	def department_head
		User.find dept_head_id
	end
	
end
