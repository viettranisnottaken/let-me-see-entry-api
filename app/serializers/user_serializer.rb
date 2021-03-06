class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :school_name, :birthdate
  attribute :gender_before_type_cast, key: :gender

  def school_name
    object.school.name
  end
end
