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

    def initialize
      @collection = COORDS.map do |coords|
        address = Address.new
        address.coords = coords
        AddressPresenter.new(address)
      end
    end

    def each
      @collection.each do |presenter|
        yield presenter
      end
    end
  end
end