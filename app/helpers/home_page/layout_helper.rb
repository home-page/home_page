module HomePage
  module LayoutHelper
    def breadcrumbs
      result = render_navigation context: :main, renderer: :breadcrumbs_without_method_links, join_with: ' &gt; '
      result = result && result.scan('<a').length > 1 ? result : ''
      
      if respond_to?(:resource) && resource.respond_to?(:ancestors)
        breadcrumbs_with_ancestors(result)
      else
        result
      end
    end
    
    def breadcrumbs_with_ancestors(links)
      links = links.split(' &gt; ')
      current_resource_link = links.pop
      links += resource.ancestors.map {|ancestor| link_to ancestor.name, ancestor }
      links << current_resource_link
      raw links.join(' &gt; ')    
    end
    
    def sidenav(links_count = 2)
      links_count ||= 2
      result = render_navigation context: :main, renderer: :twitter_sidenav, level: @twitter_sidenav_level
      
      result && result.scan('<a').length >= links_count ? result : ''
    end
    
    def footer_navigation
      links = []
      page_slugs = Setting['home_page.general.footer_navigation.items']
      pages = page_slugs.any? ? Page.where(slug: page_slugs) : []
      
      pages.each do |page|
        text = page.title
        path = page_path(page)
        links << (current_page?(path) ? text : link_to(text, path))
      end
      
      raw links.join(' | ')
    end
  end
end