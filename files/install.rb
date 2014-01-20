#!/usr/bin/env ruby

require "find"
require "fileutils"

REPLACE_ENV = %w(HOME) # Can't reliably expect much more than this

def replace_env(target)
  REPLACE_ENV.inject(target) do |memo, var|
    value = ENV[var]
    if value
      memo.gsub(/\$\{?#{var}\}?/, value)
    else
      memo
    end
  end
rescue => e
  puts "Could not replace environment variables in: '#{target}'"
end

Find.find(ARGV[0] || Dir.pwd) do |path|
  if path =~ /^(.*?).symlink$/
    source = $1
    target = File.expand_path(replace_env(File.read(path).strip))
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
