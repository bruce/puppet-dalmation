#!/usr/bin/env ruby

require "find"
require "fileutils"

def replace_home(target)
  target.gsub(/\$\{?HOME\}?/, ENV["HOME"])
end

Find.find(File.dirname(__FILE__)) do |path|
  if path =~ /^(.*?).symlink$/
    source = $1
    target = replace_home(File.read(path).strip)
    begin
      if ENV["DRYRUN"]
        $stderr.puts "ln -s #{source} #{target}"
      else
        FileUtils.ln_s(source, target, force: true)
      end
    rescue Errno::ENOENT => e
      $stderr.puts "Could not create #{target} (probably a missing directory)"
    end
  end
end
