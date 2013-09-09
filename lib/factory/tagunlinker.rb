

module Factory
  class Tagunlinker
    
    VERSION = "0.0.1"
       
    require 'nokogiri'

    class EndsWithFilter
      def ends_with set, ends
        set.map { |x| x.to_s }.join.end_with? ends
      end
    end

    attr_accessor :file_name, :text, :tags, :wrap_tag, :doc

    # Initialize with the file name, and the list of tags to check for (splat array).
    def initialize(*tags)
      @tags = tags.map{|tag| "/tag/#{tag}" }
      @wrap_tag = "html"
    end

    # Strip out HREFs which contain a given tag and return the 
    def unlink!
      parse   
      @tags.each do |tag|
        @doc.xpath("//a[ends_with(@href,'#{tag}')]", EndsWithFilter.new).each do |element|
          element.swap(element.children)
        end
      end
      @doc.xpath("/#{@wrap_tag}/body/p").inner_html
    end

    def errors
      @doc.errors
    end

    # Open the file from the filename and parse it with Nokogiri into an XML document
    # Rescue parser exceptions and log them, then close the file
    def parse
      return parse_text unless @text.nil?
      return parse_file unless @file.nil? && @file_name.nil?
      return false
    end

    private

    # Parse a text string if that was defined
    def parse_text
      @doc = Nokogiri::HTML(wrap(@text)) do |config|
        #config.strict
      end
    rescue Exception => e
      log("Error parsing text, couldn't continue. #{e}")
    end

    # Parse a file from file or filename if that was defined.
    def parse_file
      @file ||= File.open(@file_name) unless @file_name.nil?
      @text = @file.readlines
      @file.close unless @file.nil?
      parse_text
    end



    # Need to wrap the text in an outer tag so that Nokogiri will read it
    def wrap(content)
      ["<#{@wrap_tag}>", content, "</#{@wrap_tag}>"].join
    end

    # Log to somewhere
    def log(message)
      puts message
    end
  end
end
