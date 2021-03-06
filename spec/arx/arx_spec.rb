require 'spec_helper'
require 'matchers/paper'

describe Arx do
  context '.search' do
    let :papers do
      [
        'Parallel Coordinate Descent for L1-Regularized Loss Minimization',
        'Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling'
      ]
    end

    it { is_expected.to respond_to(:search).with(0..1).arguments }
    it { is_expected.to respond_to(:search).with_unlimited_arguments }
    it { is_expected.to respond_to(:search).with_keywords(:query) }
    it { is_expected.to respond_to(:search).with_keywords(:sort_by) }
    it { is_expected.to respond_to(:search).with_keywords(:sort_order) }
    it { is_expected.to respond_to(:search).with_keywords(:query, :sort_by) }
    it { is_expected.to respond_to(:search).with_keywords(:query, :sort_order) }
    it { is_expected.to respond_to(:search).with_keywords(:sort_by, :sort_order) }
    it { is_expected.to respond_to(:search).with_keywords(:query, :sort_by, :sort_order) }

    context 'with a block' do
      it { expect {|b| Arx.search &b}.to yield_control.once }
      it { expect {|b| Arx.search &b}.to yield_with_args Query }
    end
    context 'with one ID' do
      context '(valid)' do
        subject { Arx.search '1105.5379' }

        it { is_expected.to be_a Paper }
        it { is_expected.to get_paper papers.first }
      end
      context '(valid restricted)' do
        it { expect { Arx.search('1809.09415') {|q| q.title 'bob'} }.to raise_error Error::MissingPaper }
      end
      context '(valid URL)' do
        subject { Arx.search 'https://arxiv.org/abs/1105.5379' }

        it { is_expected.to be_a Paper }
        it { is_expected.to get_paper papers.first }
      end
      context '(invalid)' do
        it { expect { Arx.search '1234.1234' }.to raise_error Error::MissingPaper }
        it { expect { Arx.search '1809.0000' }.to raise_error Error::MissingPaper }
        it { expect { Arx.search '1809.00000' }.to raise_error Error::MissingPaper }
      end
      context '(invalid format)' do
        it { expect { Arx.search 'abc' }.to raise_error ArgumentError }
      end
    end
    context 'with multiple IDs' do
      context '(valid)' do
        subject { Arx.search '1105.5379', 'cond-mat/9609089' }

        it { is_expected.to be_an Array }
        it { is_expected.to all be_a Paper }
        it { is_expected.to get_papers papers }
      end
      context '(valid restricted)' do
        it { expect(Arx.search('1809.09415', 'cond-mat/9609089') {|q| q.title 'bob'}).to eq [] }
      end
      context '(invalid)' do
        it { expect { Arx.search '1234.1234', 'invalid-category/1234567' }.to raise_error ArgumentError }
      end
      context '(invalid format)' do
        it { expect { Arx.search '1105.5379', 'cond-mat/9609089', 'a' }.to raise_error ArgumentError }
      end
    end
    context 'with a predefined query' do
      context '(valid)' do
        subject { Query.new('1105.5379') }

        context 'with a block' do
          it { expect {|b| Arx.search(query: subject, &b)}.to yield_with_args subject }
          it { expect(Arx.search(query: subject) {}).to get_papers papers.first }
        end
        context 'without a block' do
          it { expect(Arx.search(query: subject)).to get_papers papers.first }
        end
      end
      context '(invalid)' do
        it { expect { Arx.search(query: String.new) }.to raise_error TypeError }
      end
    end
  end

  context ".get" do
    it "should alias .search" do
      expect(subject.method(:get).original_name).to eq :search
    end
  end
end