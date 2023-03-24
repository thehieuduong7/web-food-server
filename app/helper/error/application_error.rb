module Error
  class ApplicationError < StandardError
    attr_reader :code
    def initialize(code, message)
      @code = code
      super(message)
    end
  end

  class Unauthorized < ApplicationError
    def initialize(message = 'Unauthorized')
      super(401, message)
    end
  end

  class Forbidden < ApplicationError
    def initialize(message = 'Forbidden')
      super(403, message)
    end
  end

  class NotFound < ApplicationError
    def initialize(message = 'NotFound')
      super(404, message)
    end
  end

  class BadRequest < ApplicationError
    def initialize(message = 'BadRequest')
      super(400, message)
    end
  end

end
