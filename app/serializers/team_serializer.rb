class TeamSerializer < ActiveModel::Serializer
  attributes :id, :team_name, :manager_id
end
