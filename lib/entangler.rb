require 'entangler/version'
require 'entangler/entangled_file'

module Entangler
  class << self
    attr_accessor :executor

    def run(base_dir, opts = {})
      opts = {mode: 'master'}.merge(opts)

      require 'entangler/executor/base'
      if opts[:mode] == 'master'
        require 'entangler/executor/master'
        self.executor = Entangler::Executor::Master.new(base_dir, opts)
      elsif opts[:mode] == 'slave'
        require 'entangler/executor/slave'
        self.executor = Entangler::Executor::Slave.new(base_dir, opts)
      end

      self.executor.run
    end
  end
end