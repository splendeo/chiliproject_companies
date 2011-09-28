module CompaniesHelper

  def logo_of(company)
    if company.logo_file_exists?
      url = logo_url(company.logo)
      link_to(image_tag(url), url)
    end
  end

  def companies_check_box_tags(name, items)
    s = []
    items.each do |item|
      s << "<label>#{ check_box_tag name, item.id, false } #{h item.name}</label><br/>\n"
    end
    s.join
  end

  private

  def logo_url(logo)
    url_for( :only_path => false, :controller => 'attachments', :action => 'download', :id => logo, :filename => logo.filename )
  end


end
