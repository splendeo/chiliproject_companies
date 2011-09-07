class Company < ActiveRecord::Base
  unloadable
  
  has_and_belongs_to_many :users
  
  validates_presence_of :name, :description, :identifier
  validates_uniqueness_of :identifier
  validates_format_of :identifier, :with => /^(?!\d+$)[a-z0-9\-_]*$/
  
  acts_as_attachable
  
  def linked_with_user(user)
    users.include?(user)
  end
  
  def to_param
    @to_param ||= identifier.to_s
  end
  
  def attachments_deletable?(usr=User.current)
    true
  end
end
