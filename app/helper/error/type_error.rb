module Error::TypeError
  UNAUTHENTICATION = { message: 'UNAUTHENTICATION', code: 401 }.freeze
  FORBIDDEN = { message: 'FORBIDDEN', code: 403 }.freeze
  BAD_REQUEST = { message: 'BAD_REQUEST', code: 400 }.freeze
  NOT_FOUND_RESOURCE = { message: 'NOT_FOUND_RESOURCE', code: 404 }.freeze
  INVALID_TOKEN = { message: 'INVALID_TOKEN', code: 403 }.freeze

end
