require 'zip'
require 'gitignore/parser'

include :fileutils
include :bundler
include :terminal

desc "Package up the cloud function files for export"

optional_arg :path,
  default: "build/selfdestruct.zip",
  desc: "Path to the output file"

def run
  Dir.chdir context_directory do
    mkdir_p 'build'
    files_to_zip = Gitignore::Parser::Scanner.new(
      directory: "src",
      filename: ".gcloudignore"
    ).list_files
    rm path, force: true
    Zip::File.open(path, Zip::File::CREATE) do |zipfile|
      files_to_zip.each do |file|
        zipfile.add(File.basename(file), file)
      end
    end
  end

  puts "Successfully generated a zip file at #{path}", :green
end
