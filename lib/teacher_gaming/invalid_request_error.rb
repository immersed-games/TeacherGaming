module TeacherGaming
  class InvalidRequestError < StandardError
    def initialize(response)
      message = "#{response.status} #{response.body}\n====\nThis error occured while trying to access #{response.env.url.to_s}"
      super(message)
    end
  end
end
