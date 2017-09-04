require 'thor/group'

module TeacherGaming
  class CLI < Thor
    class Install < Thor::Group
      include Thor::Actions

      def self.source_root
        File.expand_path("../install", __FILE__)
      end

      def create_configuration
        copy_file("teacher_gaming.rb", 'config/initializers/teacher_gaming.rb')
      end
    end
  end
end
