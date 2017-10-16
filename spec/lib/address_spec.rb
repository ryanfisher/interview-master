RSpec.describe Address do
  let(:full_address) { '1600 Pennsylvania Avenue NW Washington, D.C. 20500 U.S.' }
  let(:lat) { 40.181306 }
  let(:lng) { -80.265949 }

  subject(:address) { described_class.new }

  describe 'geocoding' do
    let(:payload) {{  'longt' => lng, 'latt' => lat }}
    let(:result) { [ double(data: payload) ] }

    before do
      expect(Geocoder).to receive(:search).with(full_address).and_return result
    end

    it 'geocodes with Geocoder API' do
      address.full_address = full_address
    end

    it 'sets the coordinates' do
      address.full_address = full_address
      expect(address.lat).to be lat
      expect(address.lng).to be lng
    end
  end

  describe 'reverse geocoding' do
    let :payload do
      {
        'usa'=> {
          'uscity' => 'WASHINGTON',
          'usstnumber' => '1',
          'state' => 'PA',
          'zip' => '20500',
          'usstaddress' => 'Pennsylvania AVE'
        }
      }
    end

    let(:result) { [ double(data: payload) ] }

    before do
      expect(Geocoder).to receive(:search).with([lat, lng]).and_return result
    end

    it 'reverse geocodes with Geocoder API' do
      address.coords = [lat, lng]
    end

    it 'sets the full address' do
      address.coords = [lat, lng]
      expect(address.full_address)
        .to eq "1 Pennsylvania AVE WASHINGTON, PA 20500"
    end
  end

  describe 'distance finding' do
    let(:detroit) { FactoryGirl.build :address, :as_detroit }

    it 'calculates distance with the Geocoder API' do
      expect(Geocoder::Calculations).to receive(:distance_between)
        .with [address.lat, address.lng], [detroit.lat, detroit.lng]
      address.distance_between(detroit)
    end

    it 'returns the distance between two addresses' do
      address.lat = lat
      address.lng = lng
      expect(address.distance_between(detroit)).to be > 0
    end
  end
end
