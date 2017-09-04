require 'thor'

module TeacherGaming
  class CLI < Thor
    desc 'install', 'Install TeacherGaming'
    def install
      require 'teacher_gaming/cli/install'
      Install.start
    end
  end
end
