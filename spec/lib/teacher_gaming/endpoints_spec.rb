require 'spec_helper'

class ClassWithEndpoints
  include TeacherGaming::Endpoints
  def initialize; end
end

RSpec.describe TeacherGaming::Endpoints do
  let(:sample_def){ { anonymous: 'false', path: '/my_path' } }
  let(:anon_sample_def){ { anonymous: 'true', path: '/my_path' } }
  let(:sample_def_no_slash){ { anonymous: 'false', path: 'my_path' } }
  let(:base_endpoint){ TeacherGaming::Endpoints::BASE_ENDPOINT }
  let(:anon_endpoint){ TeacherGaming::Endpoints::ANON_ENDPOINT }
  subject{ ClassWithEndpoints.new }

  describe 'endpoint building' do
    context 'with a non-anonymous method' do
      it 'uses the base endpoint' do
        expect(subject.endpoint(sample_def)).to match base_endpoint
      end
    end

    context 'with an anonymous method' do
      it 'uses the anonymous endpoint' do
        expect(subject.endpoint(anon_sample_def)).to match anon_endpoint
      end
    end

    context 'with a slash in the path definition' do
      it 'builds the path with a single slash' do
        expect(subject.endpoint(sample_def)).to match /api\/my_path/
      end
    end

    context 'withOUT a slash in the path definition' do
      it 'builds the path with a single slash' do
        expect(subject.endpoint(sample_def_no_slash)).to match /api\/my_path/
      end
    end
  end
end
