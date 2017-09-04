require 'faraday'

module TeacherGaming
  class APIResource
    include Endpoints
    extend Endpoints

    def initialize(**args)
      if instance_of? TeacherGaming::APIResource
        raise AbstractClassError.new(self.class, __method__)
      end
      args.each{ |key, value| send("#{key}=", value) }
    end

    def attributes
      hash_list = accessors.map{ |attr| send(attr).nil? ? {} : { attr => send(attr) } }
      hash_list.reduce(:merge).deep_symbolize_keys
    end

    def request(method_name, params)
      self.class.request(method_name, params)
    end

    def self.request(method_def, params)
      url = endpoint(method_def)
      data = params.merge(apikey: TeacherGaming.api_key)
      TeacherGaming::Response.new(Faraday.get(url, data))
    end

    def self.definition
      raise AbstractClassError.new(self.class, __method__)
    end

    private

    def accessors
      self.class.definition[:attributes] + dynamic_accessors
    end

    def dynamic_accessors
      @dynamic_accessors ||= []
    end

    def method_missing(name, *args)
      if name.to_s.match(/=$/)
        var_name = name.to_s[0..-2]
        singleton_class.class_eval{ attr_accessor var_name }
        instance_variable_set("@#{var_name}", args.first)
        dynamic_accessors << var_name.to_sym
      else
        super
      end
    end
  end
end
