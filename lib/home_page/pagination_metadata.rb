module HomePage
  class PaginationMetadata
    attr_accessor :current_page, :per_page, :total_entries, :total_pages
    
    def initialize(attributes)
      attributes.each{|k,v| self.send("#{k}=", v) if self.respond_to?("#{k}=") }
    end
  end
end