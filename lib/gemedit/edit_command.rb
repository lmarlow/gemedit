require 'rubygems/command'
require 'rubygems/version_option'

class Gem::Commands::EditCommand < Gem::Command
  EDITOR_ENV_VARS = %w( GEMEDITOR BUNDLER_EDITOR VISUAL EDITOR )

  OPTIONS = {
    :version => Gem::Requirement.default,
    :verbose => false,
    :dryrun => false,
    :editor => EDITOR_ENV_VARS.map { |var| ENV[var] }.compact.first || 'vi'
  }

  include Gem::VersionOption

  def initialize
    super 'edit', 'Open an installed gem in your favorite editor', OPTIONS

    add_version_option

    add_option('-e', '--editor EDITOR', String,
               'The editor to use to open the gems',
               'GEMEDITOR, BUNDLER_EDITOR, VISUAL and EDITOR',
               'environment variables are used to find the default',
               "Default: #{OPTIONS[:editor]}") do |editor, options|
      options[:editor] = editor
    end

    add_option('-d', '--[no-]dry-run',
               'Shows what command would be run without running it',
               'Turns on verbose logging', "Default: #{OPTIONS[:dryrun]}") do |dryrun, options|
      Gem.configuration.verbose = true if dryrun
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
    begin
      # Gem -v >= 1.8
      if Gem::VERSION.to_f < "1.8".to_f
        # Old Gem find_by_name syntax
        spec = Gem.source_index.find_name(get_one_gem_name, version).last
        raise "Gem not found Error." unless spec
      else
        # New Gem find_by_name syntax
        spec = Gem::Specification.find_by_name(get_one_gem_name, version)
      end
      say "Opening the #{spec.name} gem, version #{spec.version}, with #{options[:editor]} from #{spec.full_gem_path}" if Gem.configuration.verbose
      cmd = "#{options[:editor]} ."
      Dir.chdir(spec.full_gem_path) do
        exec cmd
      end unless options[:dryrun]
    rescue Exception => e
      raise Gem::CommandLineError, "No gems found for #{options[:args].join(', ')}. #{e.message}"
    end
  end
end
