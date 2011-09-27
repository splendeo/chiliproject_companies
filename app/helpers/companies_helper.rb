module CompaniesHelper

  def logo_of(company)
    if company.logo_file_exists?
      url = logo_url(company.logo)
      link_to(image_tag(url), url)
    end
  end

  def members_check_box_tags(name, members)
    s = []
    members.sort.each do |member|
      s << "<label>#{ check_box_tag name, member.id, false } #{h member}</label>\n"
    end
    s.join
  end

  private

  def logo_url(logo)
    url_for( :only_path => false, :controller => 'attachments', :action => 'download', :id => logo, :filename => logo.filename )
  end


end
