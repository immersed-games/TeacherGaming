module CredentialHelper
  def test_api_key
    Rails.application.secrets[:teacher_gaming_api_key]
  end

  def test_student_id
    Rails.application.secrets[:sample_student_id]
  end

  def test_class_id
    Rails.application.secrets[:sample_class_id]
  end
end
