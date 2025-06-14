class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :zip_code
end