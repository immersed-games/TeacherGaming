module TeacherGaming
  class Response
    def initialize(response)
      raise InvalidRequestError.new(response) if response.status.to_s.match /[4,5]\d{2}/
      @response = response
    end

    def body
      @body ||= JSON.parse(@response.body).deep_symbolize_keys
    end

    def success?
      body[:success] == 1
    end
  end
end
