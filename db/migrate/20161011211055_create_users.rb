class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :role
      t.string :position
      t.string :team_name

      t.timestamps
    end
  end
end
