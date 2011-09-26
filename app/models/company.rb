class Company < ActiveRecord::Base
  unloadable

  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  has_one :logo, :class_name => "Attachment", :as  => :container, :conditions => "#{Attachment.table_name}.description = 'logo'", :dependent => :destroy

  validates_presence_of :name, :identifier, :short_description
  validates_uniqueness_of :identifier
  validates_format_of :identifier, :with => /^(?!\d+$)[a-z0-9\-_]*$/

  acts_as_customizable
  acts_as_attachable :view_permission => :view_companies

  after_save :attach_logo

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

  def logo=(logo_file)
    logo.destroy if logo
    @logo_file = logo_file
  end

  def logo_file_exists?
    logo && FileTest.exists?(logo.diskfile) && logo.image?
  end

private

  def attach_logo
    Attachment.attach_files(self, "1" => {'file' => @logo_file, 'description' => 'logo'}) if @logo_file
  end

end
