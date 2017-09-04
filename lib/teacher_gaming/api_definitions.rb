module TeacherGaming
  module APIDefinitions
    mattr_reader :current_version

    def self.load_version(version)
      raise AlreadyLoadedError if loaded?
      @@current_version = version

      path = File.expand_path("../api_definitions/v#{version}.json", __FILE__)
      object_definitions = JSON.parse(File.read(path)).deep_symbolize_keys
      object_definitions.each{ |obj_name, obj_def| instantiate_class(obj_name, obj_def) }

      loaded!
    end

    def self.available_versions
      Dir[File.expand_path('../api_definitions/v*.json', __FILE__)].map do |path|
        path.match(/v(\d)+\.json/).captures.first.to_i
      end
    end

    def self.loaded?
      @@loaded ||= false
    end

    private

    def self.instantiate_class(name, definition)
      class_name = "TeacherGaming::#{name.to_s.titleize.delete(' ')}"

      eval <<-RUBY
        class #{class_name} < APIResource
          attr_accessor #{definition[:attributes].to_s[1..-2]}

          def self.definition
            #{definition}
          end
        end
      RUBY

      class_name.constantize.class_eval do
        definition[:methods].each do |method_name, method_def|
          define_method method_name do |**args|
            request(method_def, attributes.merge(args))
          end
          define_singleton_method method_name do |**args|
            request(method_def, args)
          end
        end
      end
    end

    def self.loaded!
      @@loaded = true
    end
  end
end
