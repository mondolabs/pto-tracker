class AddNoteToRequests < ActiveRecord::Migration[5.0]
  def change
  	add_column :requests, :note, :text
  end
end
