require 'spec_helper'

RSpec.describe TeacherGaming::AlreadyLoadedError do
  # The only reason this is here is to make sure the class got included properly
  # in the root TeacherGaming module.
  it 'can be raised' do
    expect{
      raise TeacherGaming::AlreadyLoadedError
    }.to raise_exception TeacherGaming::AlreadyLoadedError
  end
end
