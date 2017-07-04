require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  SITE = 'http://phrogz.net/programmingruby/builtins.html'
  @doc = Nokogiri::HTML(open(SITE))
  @klasses = []
  @ins_methods = []

  def self.scrape_klass
    @doc.css("div.reference_overview code.class").each_with_index do |klass, i|
      category = "#{klass.text}; #{i.next}"
      @klasses.push category
    end
    puts @klasses
  end

  def self.scrape_instance_methods
    @doc.css("div table tbody tr td code a").each_with_index do |method, i|
      ins_method = "#{method.text}; #{i.next}"
      if ins_method.include? "="
        ins_method = "'#{method.text}'; #{i.next}"
      else
        ins_method = "#{method.text}; #{i.next}"
      end
      @ins_methods.push ins_method
    end
    puts @ins_methods
  end

end
