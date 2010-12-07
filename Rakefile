# Rakefile
# inspired by https://github.com/ryanb/dotfiles/blob/master/Rakefile
#

require 'fileutils'

desc "Install dotfiles in user's HOME directory"
task :install do
  replace_all = false

  (Dir.glob("*") - ["README", "Rakefile"]).each {|file|
    home = ENV['HOME']
    if home.nil?
      puts "Unable to determine HOME directory. Forgot to export $HOME?"
    else
      dest = "#{home}/.#{file}"
      if !File.exist?(dest) 
        puts "Copying #{file} to #{dest}"
        copy(file, dest)
      elsif replace_all
        replace_file(file,dest)
      else
        puts "overwrite #{dest}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file, dest)
        when 'y'
          replace_file(file, dest)
        when 'q'
          exit
        else
          puts "skipping #{dest}"
        end
      end
    end
  }
end

def replace_file(file, dest)
  puts "Nuking #{dest}"
end
