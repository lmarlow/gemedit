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

    if gem_specs.size == 1
      say "Opening the following gem with #{options[:editor]}:" if Gem.configuration.verbose
      spec = gem_specs.first
      say "  #{spec.full_name} #{spec.full_gem_path}" if Gem.configuration.verbose
      path = spec.full_gem_path
      cmd = "#{options[:editor]} ."
      say %Q(Running `#{cmd}` from "#{spec.full_gem_path}") if Gem.configuration.verbose
      Dir.chdir(spec.full_gem_path) do
        exec cmd
      end unless options[:dryrun]
    elsif gem_spec.size > 1
      say "Please be more specific, more than one gem found for #{get_all_gem_names.join(', ')}"
      raise Gem::SystemExitException, 2
    else
      say "No gems found for #{get_all_gem_names.join(', ')}"
      raise Gem::SystemExitException, 1
    end
  end
end
