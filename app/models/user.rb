class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	# devise :database_authenticatable, :registerable,
	#      :recoverable, :rememberable, :trackable, :validatable
	# enum role: [:admin, :dept_head, :manager, :employee]
	# has_many :requests, dependent: :destroy
	# belongs_to :team

  	ADMINS = User.admin
    DEPT_HEADS = User.admin | User.dept_head
    EMPLOYEE = User.employee

	def full_name 
		"#{first_name} " + "#{last_name}"
	end

	def managed_users
		managed_users = []
		case role
			when "admin"
				managed_users << User.all
			when "dept_head"
				departments = Department.where(dept_head_id: self.id)
				departments.each do |department|
					department.users.each do |user|	
						managed_users << user
					end	
				end	
				teams = Team.where(manager_id: self.id)
				teams.each do |team|
					team.users.each do |user|	
						managed_users << user
					end	
				end			
			when "manager"
				teams = Team.where(manager_id: self.id)
				teams.each do |team|
					team.users.each do |user|	
						managed_users << user
					end	
				end
		end
		if managed_users.include? self
			return managed_users.uniq.delete(self)
		else
			return managed_users.uniq
		end
	end

	def managed_teams
		managed_teams = []
		if dept_head?
			departments = Department.joins(:teams).where("manager_id = ?", id).uniq
			departments.each do |department|
				department.teams.each do |team|	
					managed_teams << team
				end	
			end
		else
			unless employee?
				managed_teams = Team.where(manager_id: self.id)
			end
		end	
		return managed_teams
	end

	def total_approved_pto
	end

	def total_pending_pto
	end

	def total_declined_pto
	end		

end



