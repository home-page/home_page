module HomePage
  class PaginationMetadata
    attr_accessor :current_page, :per_page, :total_entries
    alias_method :total_pages, :total_entries
    
    def initialize(attributes)
      attributes.each{|k,v| self.send("#{k}=", v) if self.respond_to?("#{k}=") }
    end
  end
end