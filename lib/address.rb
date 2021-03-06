require_relative 'geocoding'

class Address
  attr_accessor :lat, :lng, :full_address

  def coords=(coords)
    @lat, @lng = coords
    reverse_geocode

    coords
  end

  def full_address=(full_address)
    @full_address = full_address
    geocode

    @full_address
  end

  def distance_between(address)
    Geocoder::Calculations.distance_between(
      [@lat, @lng],
      [address.lat, address.lng]
    )
  end

  private

  def geocode
    data = Geocoder.search(@full_address)[0].data
    @lat = data.fetch('latt')
    @lng = data.fetch('longt')
  end

  def reverse_geocode
    address = Geocoder.search([@lat, @lng])[0].data['usa']
    return unless address
    @full_address = [
      address['usstnumber'],
      address['usstaddress'],
      "#{address['uscity']},",
      address['state'],
      address['zip']
    ].join(' ')
  end
end
