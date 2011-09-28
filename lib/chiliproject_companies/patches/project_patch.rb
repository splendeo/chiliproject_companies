require_dependency 'project'

# Patches Chiliproject's Projects dynamically.  Adds a relationship
# Project +has_and_belongs_to_many+ to Companies
module ChiliprojectsCompanies
  module Patches
    module ProjectPatch
      def self.included(base) # :nodoc:
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)

        # Same as typing in the class
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          has_and_belongs_to_many :companies

          named_scope :like, lambda {|q|
            s = "%#{q.to_s.strip.downcase}%"
            { :conditions => ["LOWER(identifier) LIKE :s OR LOWER(name) LIKE :s", {:s => s}] }
          }

          named_scope :sorted_alphabetically, :order => 'name'

        end
      end

      module ClassMethods

      end

      module InstanceMethods

      end
    end
  end
end

# Add module to Project
Project.send(:include, ChiliprojectsCompanies::Patches::ProjectPatch)
