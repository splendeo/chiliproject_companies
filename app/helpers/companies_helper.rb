module CompaniesHelper
  
  def render_projects_sentence(company)
    projects = company.projects.visible.all(:order => 'name ASC')
    links = projects.collect{ |project| link_to_project project }

    return links.to_sentence(:last_word_connector => ' and ')
  end
  
end
