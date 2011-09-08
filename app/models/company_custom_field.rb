class CompanyCustomField < CustomField
  unloadable
  
  def type_name
    :label_company
  end
end