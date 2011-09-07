class Company < ActiveRecord::Base
  unloadable
  
  acts_as_attachable :delete_permission => :edit_companies, :view_permission => :view_companies
  
  validates_presence_of :name, :description, :identifier
  validates_uniqueness_of :identifier
  validates_format_of :identifier, :with => /^(?!\d+$)[a-z0-9\-_]*$/
  
  def to_param
    @to_param ||= identifier.to_s
  end
  
  def attachments_deletable?(usr=User.current)
    true
  end
end
