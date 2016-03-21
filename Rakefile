require 'open3'

def run(command)
  Open3.popen2e(command) do |input, output|
    output.each do |line|
      puts line
    end
  end
end

desc "Generate zip file of docset"

task :zip do
  run %(zip -r brightscript.zip brightscript.docset)
end

desc "Fetch the SDK HTML docs"
task :fetch do
  run %(wget -k -r -p --include-directories=display --adjust-extension "https://sdkdocs.roku.com/display/sdkdoc/Index")
end

desc "Build the docset"
task :build do
  run %(dashing build)
end

desc "Install the docset"
task :install do
  run %(open brightscript.docset)
end
