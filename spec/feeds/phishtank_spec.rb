require 'spec_helper'

describe 'feeds/phishtank.feed', :feed do
  let(:provider) { 'phishtank' }
  let(:name) { 'phishtank' }
  let(:event_types) { [:scanning]}


  it_fetches_url 'http://data.phishtank.com/data/online-valid.json.gz'

  describe_parsing_the_file feed_data('phishtank-sample.json.gz') do
    it "should have parsed 10 records" do
      expect(num_records_parsed).to eq(10)
    end
    it "should have filtered 0 records" do
      expect(num_records_filtered).to eq(0)
    end

    describe "the records" do
      it "should total 10" do
        expect(num_records).to eq(10)
      end

      it "each record should have generated exactly one event" do
        counts = events.map { |event_array| event_array.count }
        expect(counts).to eq([1,1,1,1,1,1,1,1,1,1])
      end

      describe "the event for record 0" do
        let(:record) { records[0] }
        let(:event) { events[0].first }
        subject { event }

        its(:type) { is_expected.to be(:phishing) }
        its(:ipv4s) { is_expected.to  eq(build(:ipv4s, values: ['31.14.23.213'])) }
        its(:urls) { is_expected.to eq(build(:urls, values: ['http://poste.it-postepay4.phpblack.com/'])) }
      end
    end
  end

end
