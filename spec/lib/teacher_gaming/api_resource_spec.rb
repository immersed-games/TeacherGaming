require 'spec_helper'

class SampleResource < TeacherGaming::APIResource
  attr_accessor :name

  def self.definition
    {
      attributes: [ 'name' ],
      methods: {
        create: {
          anonymous: 'false', params: [ 'name' ], path: 'mypath'
        }
      }
    }
  end
end

RSpec.describe TeacherGaming::APIResource do
  describe 'initialization' do
    context 'uninherited' do
      it 'raises an exception' do
        expect{
          TeacherGaming::APIResource.new
        }.to raise_exception TeacherGaming::AbstractClassError
      end
    end

    context 'inherited' do
      context 'with only defined input params' do
        let(:child){ SampleResource.new(name: 'myresource') }

        it 'stores the given params' do
          expect(child.name).to eq 'myresource'
        end
      end

      context 'with new, dynamic input params' do
        let(:child){ SampleResource.new(name: 'myresource', state: 'testing') }

        it 'generates accessors for the new params' do
          expect(child.state).to eq 'testing'
        end
      end
    end
  end

  describe '#attributes' do
    context 'with only defined input params' do
      let(:child){ SampleResource.new(name: 'myresource') }

      it 'includes them in the return hash' do
        expect(child.attributes).to eq({ name: 'myresource' })
      end

      it 'excludes nil attributes' do
        child.name = nil
        expect(child.attributes).to eq({})
      end
    end

    context 'with new, dynamic input params' do
      let(:child){ SampleResource.new(name: 'myresource', state: 'testing') }

      it 'includes the new params in the return hash' do
        expect(child.attributes).to eq({ name: 'myresource', state: 'testing' })
      end

      it 'excludes nil attributes' do
        child.name = nil
        expect(child.attributes).to eq({ state: 'testing' })
      end
    end
  end

  describe '::definition' do
    it 'must be overridden in a child class' do
      expect{
        TeacherGaming::APIResource.new
      }.to raise_exception TeacherGaming::AbstractClassError
    end
  end

  describe '::request' do
    let(:create_def){ SampleResource.definition[:methods][:create] }

    it 'includes the api key in the request params' do
      allow(TeacherGaming).to receive(:api_key).and_return test_api_key
      expect(Faraday).to receive(:get).with(String, { name: 'myresource', apikey: test_api_key }).and_return Faraday::Response.new
      SampleResource.request(create_def, { name: 'myresource' })
    end

    it 'sends an http request' do
      expect(Faraday).to receive(:get).and_return Faraday::Response.new
      SampleResource.request(create_def, { name: 'myresource' })
    end

    it 'returns a TeacherGaming::Response object' do
      response = SampleResource.request(create_def, { name: 'myresource' })
      expect(response).to be_instance_of TeacherGaming::Response
    end
  end

  describe '#request' do
    let(:create_def){ SampleResource.definition[:methods][:create] }

    it 'calls the class method equivalent' do
      expect(SampleResource).to receive(:request)
      SampleResource.new.request(create_def, { name: 'myresource' })
    end
  end
end
