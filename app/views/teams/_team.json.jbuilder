json.extract! team, :id, :team_name, :manager_id, :created_at, :updated_at
json.url team_url(team, format: :json)