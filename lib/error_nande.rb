require "error_nande/version"

module ErrorNande
  def self.nande(error)
    summary = "#{error.inspect} at #{compact_backtrace(error)}"
    while error = error.cause
      summary << " (cause #{error.inspect} at #{compact_backtrace(error)})"
    end
    summary
  end

  class << self
    alias_method :summary, :nande
  end

  def self.compact_backtrace(error)
    return "(toplevel)" unless error.backtrace
    self.backtrace_cleaner.clean(error.backtrace, :no_silencers).first
  end

  class NullBacktraceCleaner
    def clean(backtrace, *rest)
      backtrace
    end
  end

  def self.backtrace_cleaner
    if defined?(::Rails) && ::Rails.backtrace_cleaner
      ::Rails.backtrace_cleaner
    else
      NullBacktraceCleaner.new
    end
  end
end
