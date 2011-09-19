class CompanyCustomField < CustomField
  unloadable
  
  def type_name
    :label_company_plural
  end
end