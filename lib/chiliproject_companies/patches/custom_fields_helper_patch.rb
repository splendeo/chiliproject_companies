module ChiliprojectsCompanies
  module Patches
    module CustomFieldsHelperPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable
          alias_method_chain :custom_fields_tabs, :company_tab
        end
      end

      def custom_fields_tabs_with_company_tab
        tabs = custom_fields_tabs_without_company_tab
        tabs << { :name => 'CompanyCustomField', :partial => 'custom_fields/index', :label => :label_company_plural }
        return tabs
      end
    end
  end
end
