require_relative 'geocoding'

class Address
  attr_accessor :lat, :lng, :full_address

  def coords=(coords)
    @lat, @lng = coords
    reverse_geocode_if_possible
  end

  private

  def reverse_geocode_if_possible
    return unless @lat && @lng
    address = Geocoder.search([@lat, @lng])[0].data['usa']
    @full_address = [
      address['usstnumber'],
      address['usstaddress'],
      "#{address['uscity']},",
      address['state'],
      address['zip']
    ].join(' ')
  end
end
