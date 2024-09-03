class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :race, :realm, :created_at, :is_imported

  def created_at
    object.created_at.strftime('%Y.%m.%d')
  end
end
