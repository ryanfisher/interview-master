RSpec.describe AddressPresenter::Collection do
  subject(:collection) { described_class.new }

  let(:payload) { { 'latt' => '', 'longt' => '' } }
  let(:result) { [double(data: payload)] }

  before do
    allow(Geocoder).to receive(:search) { result }
  end

  describe '#white_house' do
    it 'returns an Address' do
      expect(described_class.white_house).to be_instance_of Address
    end
  end
end
