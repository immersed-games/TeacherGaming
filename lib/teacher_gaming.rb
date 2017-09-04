module TeacherGaming
  $LOAD_PATH << File.expand_path('../', __FILE__)
  require 'active_support/all'

  # Core
  require 'teacher_gaming/api_definitions'
  require 'teacher_gaming/endpoints'
  require 'teacher_gaming/response'
  require 'teacher_gaming/api_resource'

  # Errors
  require 'teacher_gaming/already_loaded_error'
  require 'teacher_gaming/abstract_class_error'
  require 'teacher_gaming/invalid_request_error'

  mattr_accessor :api_key

  DEFAULT_VERSION = 1.freeze

  def loaded?
    APIDefinitions.loaded?
  end
end
