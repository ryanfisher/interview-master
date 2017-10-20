require_relative "../address_presenter"

class AddressPresenter
  class Collection
    include Enumerable

    COORDS = [
      [61.582195, -149.443512],
      [44.775211, -68.774184],
      [25.891297, -97.393349],
      [45.787839, -108.502110],
      [35.109937, -89.959983]
    ]

    class << self
      WHITE_HOUSE_ADDRESS =
        "1600 Pennsylvania Avenue NW Washington, D.C. 20500"

      def white_house
        @_white_house ||= begin
          address = Address.new
          address.full_address = WHITE_HOUSE_ADDRESS

          address
        end
      end
    end

    def initialize
      @collection = COORDS.map do |coords|
        address = Address.new
        address.coords = coords
        AddressPresenter.new(address)
      end.sort_by(&:distance_from_white_house)
    end

    def each
      @collection.each do |presenter|
        yield presenter
      end
    end
  end
end
