module Gemedit #:nodoc:
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 0
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  def Version
    VERSION::STRING
  end
  module_function :Version
end
