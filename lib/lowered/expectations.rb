require 'rubygems/dependency'
require 'open3'
require 'shellwords'
require 'pty'

class LoweredExpectations
  VERSION = '1.0.2'.freeze

  class VersionPatternError < StandardError
  end

  class IncompatibleVersionError < StandardError
  end

  class CommandExecutionError < StandardError
  end

  class MissingExecutableError < StandardError
  end

  def self.expect(executable, version, vopt: '--version', vpattern: '(\d+\.\d+\.\d+)')
    vstring = run! which(executable), vopt, quiet: true
    vmatch = /#{vpattern}/.match(vstring)
    raise(VersionPatternError.new("unable to match #{vpattern} in version output #{vstring} from #{executable}")) unless vmatch
    verify_version(vmatch[0], version) || raise(VersionPatternError.new("unable to match #{vpattern} in version output #{vstring} from #{executable}"))
  end

  def self.which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      exts.each do |ext|
        exe = File.join(path, "#{cmd}#{ext}")
        return exe if File.executable?(exe) && !File.directory?(exe)
      end
    end
    raise MissingExecutableError.new("#{cmd} not found in #{ENV['PATH']}")
  end

  def self.verify_version(version, pattern)
    Gem::Dependency.new('', pattern).match?('', version) || raise(IncompatibleVersionError.new("#{version} does not match version pattern #{pattern}"))
  end

  def self.run!(*args, quiet: false)
    cmd = Shellwords.shelljoin(args.flatten)
    status = 0
    stdout = ''
    stderr = ''
    if quiet
      # Run without streaming std* to any screen
      stdout, stderr, status = Open3.capture3(cmd)
      status = status.exitstatus
    else
      # Run but stream as well as capture stdout to the screen
      status = pty(cmd) do |r,w,pid|
        while !r.eof?
          c = r.getc
          stdout << c
          $stdout.write c.to_s
        end
        Process.wait(pid)
      end
    end
    raise CommandExecutionError.new(stderr) unless status.zero?
    stdout
  end
  private_class_method :run!

  def self.exec!(*args)
    cmd = Shellwords.shelljoin(args.flatten)
    logger.debug "Exec'ing: #{cmd}, in: #{Dir.pwd}"
    Kernel.exec cmd
  end
  private_class_method :exec!

  def self.pty(cmd, &block)
    PTY.spawn(cmd, &block)
    $?.exitstatus
  end
  private_class_method :pty
end
