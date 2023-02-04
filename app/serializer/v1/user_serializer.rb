class V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :gender,
             :dob, :phone, :address, :avatar,
             :is_active, :is_admin, :created_at
end
