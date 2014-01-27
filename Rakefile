# Rakefile
# vim: set ft=ruby nospell :
# inspired by https://github.com/ryanb/dotfiles/blob/master/Rakefile
#

require 'fileutils'

task :default => :install

desc "Submit changed files to git"
task :submit do
  (Dir.glob("{*,.*}") - ["README", "Rakefile", ".git", "..", "."]).each {|file|
    puts "Checking for updates to #{file}"
    source = "#{Dir.home()}/.#{file}"
    update(source, file) if File.exist?(source) and not File.directory?(file)
    handle_directory(file) if File.directory?(file)
  }
end

def update(from, to)
  if FileUtils.uptodate?(to, %w(from)) or not File.exist?(to)
    copy(from, to)
    `git add #{to}`
  elsif FileUtils.identical?(from, to)
    puts "'#{from}' is unchanged"
  end
end

def handle_directory dir
  Dir.glob("#{Dir.home()}/#{dir}/*").each {|file|
    dest = File.join(dir, File.basename(file))
    if File.directory?(file)
      handle_directory(file)
      next
    end
    update(file, dest)
  }
end

def update_directory dir
  Dir.glob(File.join(dir, "*")).each {|file|
    if File.directory?(file)
      update_directory(file)
      next
    end
    from = file
    to = File.join(Dir.home, file)
    if File.identical?(from, to)
      puts "'#{from}' is unchanged"
    else FileUtils.uptodate?(from, %w(to))
      FileUtils.mkdir_p(File.dirname(to))
      copy(from, to)
    end
  }
end

desc "Install dotfiles in user's HOME directory"
task :install do
  @replace_all = false

  (Dir.glob("{*,.*}") - ["README", "Rakefile", ".git", "..", "."]).each {|file|
    puts "Looking at #{file}"
    if File.directory?(file)
      update_directory(file)
      next
    end
    dest = "#{Dir.home()}/.#{file}"
    ask_and_replace(dest, file)
  }
end

def ask_and_replace(dest, src)
  if File.exist?(dest)
    if FileUtils.identical?(src,dest)
      puts "skipping identical '#{src}'"
      return
    end
  end
  if !File.exist?(dest)
    puts "copying #{src} to #{dest}"
    copy(src, dest)
  elsif @replace_all
    replace_file(src,dest)
  else
    puts "overwrite #{dest}? [ynadq] "
    case $stdin.gets.chomp
    when 'a'
      @replace_all = true
      replace_file(src, dest)
    when 'y'
      replace_file(src, dest)
    when 'd'
      diff_file(src,dest)
    when 'q'
      exit
    else
      puts "skipping #{dest}"
    end
  end
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
