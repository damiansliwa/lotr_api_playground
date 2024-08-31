class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :race, :realm, :created_at

  def created_at
    object.created_at.strftime('%Y.%m.%d')
  end
end
