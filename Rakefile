# Rakefile
# vim: set ft=ruby nospell :
# inspired by https://github.com/ryanb/dotfiles/blob/master/Rakefile
#

require 'fileutils'

task :default => :install

desc "Submit changed files to git"
task :submit do
  (Dir.glob("*") - ["README", "Rakefile"]).each {|file|
    home = ENV['HOME']
    if home.nil?
      puts "Unable to determine HOME directory. Forgot to export $HOME?"
    else
      source = "#{home}/.#{file}"
      if File.exist?(source) and not Dir.exist?(source)
        if FileUtils.identical?(source,file)
          puts "'#{file}' is unchanged"
          next
        end
        if FileUtils.uptodate?(source, %w(file))
          puts "copying '#{source}' to '#{file}'"
          copy(source, file)
          `git add #{file}`
        end
      end
    end
  }
  puts "Done."
  puts "Here is what's changed:"
  system("git diff --cached")
end

desc "Install dotfiles in user's HOME directory"
task :install do
  replace_all = false

  (Dir.glob("*") - ["README", "Rakefile"]).each {|file|
    home = ENV['HOME']
    if home.nil?
      puts "Unable to determine HOME directory. Forgot to export $HOME?"
    else
      dest = "#{home}/.#{file}"
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
