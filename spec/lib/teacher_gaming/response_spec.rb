require 'spec_helper'

RSpec.describe TeacherGaming::Response do
  let(:faraday_response){ Faraday.get('http://www.example.com') }

  describe 'initialization' do
    context 'with a successful response' do
      it 'can be initialized' do
        expect(TeacherGaming::Response.new(faraday_response)).to be_instance_of TeacherGaming::Response
      end
    end

    context 'with a 4xx or 5xx response' do
      before :each do
        allow_any_instance_of(Faraday::Response).to receive(:status).and_return 400
      end

      it 'raises an exception' do
        expect{
          TeacherGaming::Response.new(faraday_response)
        }.to raise_exception TeacherGaming::InvalidRequestError
      end
    end
  end

  describe '#success?' do
    before :each do
      allow_any_instance_of(Faraday::Response).to receive(:body).and_return({ "success": 1 }.to_json)
    end

    it 'returns the "success" key from the response body as a boolean' do
      expect(TeacherGaming::Response.new(faraday_response).success?).to be true
    end
  end

  describe '#body' do
    before :each do
      allow_any_instance_of(Faraday::Response).to receive(:body).and_return({ "success": 1 }.to_json)
    end

    it 'returns the body as a symbolized hash' do
      data = TeacherGaming::Response.new(faraday_response).body
      expect(data[:success]).to eq 1
    end
  end
end
