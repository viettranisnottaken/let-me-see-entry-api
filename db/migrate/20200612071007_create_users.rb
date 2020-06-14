class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :gender
      t.datetime :birthdate
      t.integer :school_id

      t.timestamps
    end
  end
end
