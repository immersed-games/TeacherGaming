require 'spec_helper'

RSpec.describe TeacherGaming::AbstractClassError do
  it 'can be raised' do
    expect{
      raise TeacherGaming::AbstractClassError.new('myclass', 'mymethod')
    }.to raise_exception TeacherGaming::AbstractClassError
  end
end
