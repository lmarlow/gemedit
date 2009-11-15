require 'rubygems/command'
require 'rubygems/version_option'

class Gem::Commands::EditCommand < Gem::Command

  OPTIONS = {
    :version => Gem::Requirement.default,
    :verbose => false,
    :dryrun => false,
    :editor => ENV['GEMEDITOR'] || ENV['VISUAL'] || ENV['EDITOR'] || 'vi'
  }

  include Gem::VersionOption

  def initialize
    super 'edit', 'Open an installed gem in your favorite editor', OPTIONS

    add_version_option

    add_option('-e', '--editor EDITOR', String,
               'The editor to use to open the gems',
               'GEMEDITOR, VISUAL and EDITOR environment variables',
               'are used to find the default',
               "Default: #{OPTIONS[:editor]}") do |editor, options|
      options[:editor] = editor
    end

    add_option('-d', '--[no-]dry-run',
               'Shows what command would be run without running it',
               'Turns on verbose logging', "Default: #{OPTIONS[:dryrun]}") do |dryrun, options|
      Gem.configuration.verbose ||= true if dryrun
      options[:dryrun] = dryrun
    end
  end

  def arguments # :nodoc:
    "GEMNAME       name of gem to open in your favorite editor"
  end

  def defaults_str # :nodoc:
    "--version '#{OPTIONS[:version]}' --editor #{OPTIONS[:editor]} --no-dry-run"
  end

  def usage # :nodoc:
    "#{program_name} [options] GEMNAME [GEMNAME ...]"
  end

  def execute
    version = options[:version] || OPTIONS[:version]

    gem_specs = get_all_gem_names.map { |gem_name|
      if spec = Gem.source_index.find_name(gem_name, version).last
        say "Found gem for '#{gem_name}' with version #{version}" if Gem.configuration.verbose
      else
        say "No gem found for '#{gem_name}' with version #{version}" if Gem.configuration.verbose
      end
      spec
    }.compact

    if gem_specs.size > 0
      say "Opening the following gems with #{options[:editor]}:" if Gem.configuration.verbose
      paths = gem_specs.map do |spec|
        say "  #{spec.full_name} #{spec.full_gem_path}" if Gem.configuration.verbose
        %Q{"#{spec.full_gem_path}"}
      end
      cmd = "#{options[:editor]} #{paths.join(' ')}"
      say "Running `#{cmd}`" if Gem.configuration.verbose
      exec cmd unless options[:dryrun]
    else
      say "No gems found for #{get_all_gem_names.join(', ')}"
      raise Gem::SystemExitException, 1
    end
  end
end
