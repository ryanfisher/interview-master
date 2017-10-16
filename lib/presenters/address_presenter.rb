class AddressPresenter < SimpleDelegator
  def distance_from_white_house
    distance_between(Collection.white_house)
  end
end
