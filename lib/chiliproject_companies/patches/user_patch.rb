require_dependency 'principal'
require_dependency 'user'

# Patches Chiliproject's Users dynamically.  Adds a relationship
# User +has_and_belongs_to_many+ to Companies
module ChiliprojectsCompanies
  module Patches
    module UserPatch
      def self.included(base) # :nodoc:
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)

        # Same as typing in the class
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          has_and_belongs_to_many :companies

          named_scope :like, lambda {|q| 
            s = "%#{q.to_s.strip.downcase}%"
            { :conditions => ["LOWER(login) LIKE :s OR LOWER(firstname) LIKE :s OR LOWER(lastname) LIKE :s OR LOWER(mail) LIKE :s", {:s => s}] }
          }

          named_scope :sorted_alphabetically, :order => 'login, lastname, firstname, mail'
        end
      end

      module ClassMethods

      end

      module InstanceMethods

      end
    end
  end
end

# Add module to User
User.send(:include, ChiliprojectsCompanies::Patches::UserPatch)
