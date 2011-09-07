class CreateCompaniesProjects < ActiveRecord::Migration
  def self.up
    create_table :companies_projects, :id => false do |t|
      t.references :company
      t.references :project
    end
    
    add_index "companies_projects", "company_id"
    add_index "companies_projects", "project_id"
  end

  def self.down
    drop_table :companies_projects
  end
end
