class CreateOperatingLoads < ActiveRecord::Migration[7.1]
  def change
    create_table :operating_loads do |t|
      t.decimal :reading, null: false
      t.datetime :timestamp, default: -> { "CURRENT_TIMESTAMP" }, null: false
      t.references :pump, null: false, foreign_key: true

      t.timestamps

      t.index ["pump_id", "timestamp"], name: "index_operating_loads_on_pump_id_and_timestamp"
    end
  end
end
