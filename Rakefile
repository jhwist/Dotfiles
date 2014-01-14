# Rakefile
# vim: set ft=ruby nospell :
# inspired by https://github.com/ryanb/dotfiles/blob/master/Rakefile
#

require 'fileutils'

task :default => :install

desc "Submit changed files to git"
task :submit do
  (Dir.glob("*") - ["README", "Rakefile"]).each {|file|
    source = "#{Dir.home()}/.#{file}"
    update(source, file) if File.exist?(source) and not File.directory?(file)
    handle_directory(file) if File.directory?(file)
  }
  puts "Here is what's changed:"
  #system("git diff --cached|less")
end

def update(from, to)
  if FileUtils.identical?(from, to)
    puts "'#{from}' is unchanged"
  else FileUtils.uptodate?(from, %w(to))
    copy(from, to)
    `git add #{to}`
  end
end

def handle_directory dir
  puts "Looking at #{dir}"
  Dir.glob("#{Dir.home()}/#{dir}/*").each {|file|
    puts "Checking #{file} (#{File.basename(file)})"
    update(file, File.join(dir, File.basename(file)))
  }
end

desc "Install dotfiles in user's HOME directory"
task :install do
  replace_all = false

  (Dir.glob("**/*") - ["README", "Rakefile"]).each {|file|
    dest = "#{Dir.home()}/.#{file}"
    next if File.directory?(file)
    if File.exist?(dest)
      if FileUtils.identical?(file,dest)
        puts "skipping identical '#{file}'"
        next
      end
    end
    if !File.exist?(dest)
      puts "copying #{file} to #{dest}"
      copy(file, dest)
    elsif replace_all
      replace_file(file,dest)
    else
      puts "overwrite #{dest}? [ynadq] "
      case $stdin.gets.chomp
      when 'a'
        replace_all = true
        replace_file(file, dest)
      when 'y'
        replace_file(file, dest)
      when 'd'
        diff_file(file,dest)
      when 'q'
        exit
      else
        puts "skipping #{dest}"
      end
    end
  }
end

def diff_file(file, orig)
  %x[diff -i -b -U 5 #{file} #{orig}].split("\n").each {|l| puts l}
end

def replace_file(file, dest)
  if !FileUtils.uptodate?(file, %w(dest))
    puts "Destination #{dest} is newer than source #{file}, skipping"
  else
    rm(dest)
    copy(file,dest)
  end
end
