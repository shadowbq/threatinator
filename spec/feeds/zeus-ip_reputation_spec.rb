require 'spec_helper'

describe 'feeds/zeus-ip_reputation.feed', :feed do
  let(:provider) { 'abuse_ch' }
  let(:name) { 'zeus_ip_reputation' }
  let(:event_types) { [:scanning]}


  it_fetches_url 'https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist'

  describe_parsing_the_file feed_data('zeus-ip_reputation.txt') do
    it "should have parsed 10 records" do
      expect(num_records_parsed).to eq(279)
    end
    it "should have filtered 8 records" do
      expect(num_records_filtered).to eq(6)
    end
  end

  describe_parsing_a_record '109.229.210.250' do
    it "should have parsed" do
      expect(status).to eq(:parsed)
    end
    it "should have parsed 1 event" do
      expect(events.count).to eq(1)
    end
    describe 'event 0' do
      subject { events[0] }
      its(:type) { is_expected.to be(:c2) }
      its(:ipv4s) { is_expected.to eq(build(:ipv4s, values: ['109.229.210.250'])) }
    end
  end

  describe_parsing_a_record '141.105.67.94' do
    it "should have parsed" do
      expect(status).to eq(:parsed)
    end
    it "should have parsed 1 event" do
      expect(events.count).to eq(1)
    end
    describe 'event 0' do
      subject { events[0] }
      its(:type) { is_expected.to be(:c2) }
      its(:ipv4s) { is_expected.to eq(build(:ipv4s, values: ['141.105.67.94'])) }
    end
  end
end
