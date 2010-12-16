# vim: ft=ruby
require 'rubygems'
require 'win32/Console/ANSI'
require 'irb/completion'
require 'irb/ext/save-history'

ARGV.concat [ "--prompt-mode", "simple" ]
IRB.conf[:USE_READLINE] = true
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

def cls
  system('cls')
end

def reload
  load File.expand_path("~/.irbrc")
end

if ENV['TERM'].nil?
  ENV['TERM']='ansi'
end

begin
  require "ap"
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
  AwesomePrint.defaults = {
    :indent => -2,
  }
rescue LoadError => e
  puts "ap gem not found.  Try typing 'gem install awesome_print' to get super-fancy output."
end

