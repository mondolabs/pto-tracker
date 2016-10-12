class RequestSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :status
end
