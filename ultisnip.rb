require 'fileutils'

Dir["snippets/*"].each do |dir|

  file_type = dir.split("/").last
  File.open("UltiSnips/#{file_type}.snippets", "w") do |file|
    Dir[dir+"/*"].sort.each do |file_name|
      begin
        snippet_name = file_name.split("/").last
        snippet_name = snippet_name.split(".").first
        definition = File.read(file_name)
        snippet_text = <<-T
snippet #{snippet_name} "#{snippet_name}"
#{definition}endsnippet
T
        file.write(snippet_text)
      rescue Errno::EISDIR
      end
    end
  end
end
