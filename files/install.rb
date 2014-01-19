#!/usr/bin/env ruby

require "find"
require "fileutils"

REPLACE_ENV = %w(HOME USER)

def replace_env(target)
  REPLACE_ENV.inject(target) do |memo, var|
    memo.gsub(/\$\{?#{var}\}?/, ENV[var])
  end
end

Find.find(File.dirname(__FILE__)) do |path|
  if path =~ /^(.*?).symlink$/
    source = $1
    target = replace_env(File.read(path).strip)
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
