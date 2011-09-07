class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :short_description
      t.string :url
      t.text :description
      t.string :identifier
      t.boolean :hardware_development
      t.boolean :hardware_production
      t.boolean :firmware_development
      t.boolean :driver
    end
  end

  def self.down
    drop_table :companies
  end
end
