require 'nokogiri'
require 'cgi'

nodes_to_delete = [
  "#footer",
  ".aui-header-secondary",
  "#navigation",
  ".plugin_pagetree",
]

Dir.glob("sdkdocs.roku.com/**/*.html") do |filename|
  puts "Processing #{filename}..."
  file = File.read(filename)
  doc = Nokogiri::HTML(file)

  doc.search("script").each do |node|
    if node.attr('type') != "syntaxhighlighter"
      if node.attr("src") === "" || node.attr("src").nil?
        node.remove
      end
    # else
    #   content = node.text().sub("<![CDATA[", "").sub("]]>", "")
    #   content = CGI.unescapeHTML(content)
    #   new_node = doc.create_element "pre"
    #   new_node["style"] = "padding:10px"
    #   new_node.inner_html = content
    #   node.swap new_node
    end
  end

  nodes_to_delete.each do |selector|
    node = doc.at_css(selector)
    node.remove if node
  end

  File.write(filename, doc.to_html)
end
