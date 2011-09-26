module CompaniesHelper

  def render_projects_sentence(company)
    projects = company.projects.visible.all(:order => 'name ASC')
    links = projects.collect{ |project| link_to_project project }

    return links.to_sentence(:last_word_connector => ' and ')
  end

  def logo_of(company)
    if company.logo_file_exists?
      url = logo_url(company.logo)
      link_to(image_tag(url), url)
    end
  end

  private

  def logo_url(logo)
    url_for( :only_path => false, :controller => 'attachments', :action => 'download', :id => logo, :filename => logo.filename )
  end


end
