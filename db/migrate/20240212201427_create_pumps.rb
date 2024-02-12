class CreatePumps < ActiveRecord::Migration[7.1]
  def change
    create_table :pumps do |t|
      t.string :name

      t.timestamps
    end
  end
end
