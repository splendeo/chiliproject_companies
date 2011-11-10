module ChiliprojectsCompanies
  module Patches
    module ProjectPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable

          has_and_belongs_to_many :companies

          named_scope :like, lambda {|q|
            s = "%#{q.to_s.strip.downcase}%"
            { :conditions => ["LOWER(identifier) LIKE :s OR LOWER(name) LIKE :s", {:s => s}] }
          }

          named_scope :sorted_alphabetically, :order => 'name'

        end
      end
    end
  end
end
