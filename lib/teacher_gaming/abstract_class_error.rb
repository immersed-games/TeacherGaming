module TeacherGaming
  class AbstractClassError < StandardError
    def initialize(class_name, method_name)
      super("#{class_name} is an abstract class. ##{method_name} must be called from a child class.")
    end
  end
end
