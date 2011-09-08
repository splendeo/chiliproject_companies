require_dependency 'acts_as_customizable'
require_dependency 'custom_fields_helper'

# Patches Chiliproject's Projects dynamically.  Adds a relationship 
# Project +has_and_belongs_to_many+ to Companies
module ChiliprojectsCompanies
  module Patches
    module CustomFieldsHelperPatch
      def self.included(base) # :nodoc:
        base.extend(ClassMethods)
    
        base.send(:include, InstanceMethods)
    
        # Same as typing in the class 
        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development
          alias_method_chain :custom_fields_tabs, :company_tab
        end
      end
  
      module ClassMethods
        
      end
  
      module InstanceMethods
        def custom_fields_tabs_with_company_tab
          tabs = custom_fields_tabs_without_company_tab
          tabs << { :name => 'CompanyCustomField', :partial => 'custom_fields/index', :label => :label_company_plural }
          
          return tabs
        end
      end    
    end
  end
end

# Add module to Project
CustomFieldsHelper.send(:include, ChiliprojectsCompanies::Patches::CustomFieldsHelperPatch)
