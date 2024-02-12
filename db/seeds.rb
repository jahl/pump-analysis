# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'


pump = Pump.find_or_create_by({name: 'demo_t_afm16'})

unless OperatingLoad.any?
  csv = CSV.parse(File.read('tmp/pump_data.csv'), headers: true)
  operating_load_records = csv.map do |row|
    metrics =  JSON.parse(row["metrics"])
    timestamp = Time.at(row["fromts"].to_i / 1000)
    {
      pump_id: pump.id,
      reading: metrics["Psum"]["avgvalue"],
      timestamp: timestamp
    }
  end

  OperatingLoad.insert_all(operating_load_records)
end