require 'spec_helper'

RSpec.describe TeacherGaming::InvalidRequestError do
  let(:faraday_response){ Faraday.get('http://www.example.com') }

  it 'can be raised' do
    expect{
      raise TeacherGaming::InvalidRequestError.new(faraday_response)
    }.to raise_exception TeacherGaming::InvalidRequestError
  end
end
