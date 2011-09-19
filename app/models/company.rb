class Company < ActiveRecord::Base
  unloadable
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  
  validates_presence_of :name, :identifier, :short_description
  validates_uniqueness_of :identifier
  validates_format_of :identifier, :with => /^(?!\d+$)[a-z0-9\-_]*$/
  
  acts_as_customizable
  
  acts_as_attachable :view_permission => :view_companies
  
  def linked_with_user(user)
    users.include?(user)
  end
  
  def linked_with_project(project)
    projects.include?(project)
  end
  
  def to_param
    @to_param ||= identifier.to_s
  end
  
  def has_custom_values?
    custom_values.any?{ |c| c.value.present? }
  end
  
  def attachments_deletable?(user = User.current)
    return user.admin?
  end
  
  def attachments_visible?(user = User.current)
    true
  end
  
  def project
    nil
  end
  
end
