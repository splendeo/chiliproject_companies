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
