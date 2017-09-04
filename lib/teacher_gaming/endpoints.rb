module TeacherGaming
  module Endpoints
    BASE_ENDPOINT = 'https://analyticsdata.teachergaming.com/api'.freeze
    ANON_ENDPOINT = 'https://analyticsanon.teachergaming.com/api'.freeze

    def endpoint(method_def)
      is_anonymous = method_def[:anonymous] == 'true'
      (is_anonymous ? ANON_ENDPOINT : BASE_ENDPOINT) + endpoint_path(method_def)
    end

    private

    def endpoint_path(method_def)
      method_def[:path].match(/^\//) ? method_def[:path] : '/'+method_def[:path]
    end
  end
end
