require 'spec_helper'

RSpec.describe TeacherGaming::APIDefinitions do
  describe 'loading' do
    it 'can load API resource classes from json' do
      expect{ TeacherGaming::Session }.to_not raise_exception
    end

    it 'marks the module as loaded' do
      expect(TeacherGaming::APIDefinitions.loaded?).to be true
    end

    it 'raises an exception if loaded again' do
      expect{
        TeacherGaming::APIDefinitions.load_version 1
      }.to raise_exception TeacherGaming::AlreadyLoadedError
    end
  end

  describe 'versions' do
    it 'can return the currently loaded version' do
      expect(TeacherGaming::APIDefinitions.current_version).to eq 1
    end

    it 'can return a list of available versions' do
      expect(TeacherGaming::APIDefinitions.available_versions).to eq [1]
    end
  end

  describe 'class instantiation' do
    it 'saves the definition in ::definition' do
      expect(TeacherGaming::Session.definition).to be_instance_of Hash
    end

    it 'creats instance methods for each method in the json' do
      expect(TeacherGaming::Session.new.respond_to? :create).to be true
    end

    it 'creats class methods for each method in the json' do
      expect(TeacherGaming::Session.respond_to? :create).to be true
    end
  end
end
