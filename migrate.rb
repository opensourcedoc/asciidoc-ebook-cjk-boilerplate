# Update the parameters of the ebook in the project.

require 'fileutils'
require 'rbconfig'
require 'yaml'


def file_fallback (file)
    _file = file

    dirname = File.dirname(_file)
    basename = File.basename(_file, ".*")
    extension = File.extname(_file)
    unless File.exist?(_file)
        _file = File.join(dirname, "#{basename}.template#{extension}")
    end

    return _file
end

def read_file (file)
    file = File.open(file)
    data = file.read
    file.close

    return data
end

def write_file (file, content)
    file = File.open(file, "w") do |f|
        f.write content;
    end
end


cwd = File.dirname(__FILE__)
root = cwd

parameter_file = file_fallback(File.join(root, "parameters.yml"))
File.exist?(parameter_file) or abort "No parameter configuration available '#{$parameter_file}': #{$!}"

parameters = YAML.load_file(parameter_file)

file = parameters["file"]
title = parameters["title"]
author = parameters["author"]
date = parameters["date"]
lang = parameters["lang"]
toc = parameters["toc"]


books = [
    file_fallback(File.join(root, "epub.adoc")),
    file_fallback(File.join(root, "pdf.adoc")),
    file_fallback(File.join(root, "print.adoc"))
]

is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin/)

if is_windows then
scripts = [
    file_fallback(File.join(root, "epub.bat")),
    file_fallback(File.join(root, "mobi.bat")),
    file_fallback(File.join(root, "pdf.bat"))
]

scripts_print = [
    file_fallback(File.join(root, "print.bat"))
]
else
scripts = [
    file_fallback(File.join(root, "epub")),
    file_fallback(File.join(root, "mobi")),
    file_fallback(File.join(root, "pdf"))
]

scripts_print = [
    file_fallback(File.join(root, "print"))
]
end

books.each do |book|
    content = read_file book

    content = content
        .gsub(/= .*/,"= #{title}")
        .gsub(/:author: .*/, ":author: #{author}")
        .gsub(/:docdate: .*/, ":docdate: #{date}")
        .gsub(/:lang: .*/, ":lang: #{lang}")
        .gsub(/:toc-title: .*/, ":toc-title: #{toc}")

    write_file book, content
end

scripts.each do |script|
    content = read_file script

    content = content
        .gsub(/[\w_-]+\.epub/, "#{file}.epub")
        .gsub(/[\w_-]+\.mobi/, "#{file}.mobi")
        .gsub(/[\w_-]+\.pdf/, "#{file}.pdf")

    write_file script, content
end

FileUtils.chmod("+x", file_fallback(File.join(root, "epub")))
FileUtils.chmod("+x", file_fallback(File.join(root, "mobi")))
FileUtils.chmod("+x", file_fallback(File.join(root, "pdf")))

scripts_print.each do |script|
    content = read_file script

    content = content
        .gsub(/[\w_-]+\.pdf/, "#{file}-print.pdf")

    write_file script, content
end

FileUtils.chmod("+x", file_fallback(File.join(root, "print")))
