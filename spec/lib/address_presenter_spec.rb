RSpec.describe AddressPresenter do
  subject(:presenter) { AddressPresenter.new(address) }

  let(:address) { instance_double('Address') }

  describe '#distance_from_white_house' do
    it 'compares the distance_between address and white_house' do
      expect(described_class::Collection).to receive(:white_house)
      expect(address).to receive(:distance_between)
      presenter.distance_from_white_house
    end
  end
end
