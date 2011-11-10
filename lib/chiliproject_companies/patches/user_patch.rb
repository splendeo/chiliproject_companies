module ChiliprojectsCompanies
  module Patches
    module UserPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable
          has_and_belongs_to_many :companies

          named_scope :like, lambda {|q| 
            s = "%#{q.to_s.strip.downcase}%"
            { :conditions => ["LOWER(login) LIKE :s OR LOWER(firstname) LIKE :s OR LOWER(lastname) LIKE :s OR LOWER(mail) LIKE :s", {:s => s}] }
          }

          named_scope :sorted_alphabetically, :order => 'login, lastname, firstname, mail'
        end
      end
    end
  end
end
