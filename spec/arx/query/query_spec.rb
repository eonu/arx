require 'spec_helper'

describe Query do
  context '.initialize' do
    subject { Query }

    it { is_expected.to respond_to(:new).with(0..1).arguments }
    it { is_expected.to respond_to(:new).with_unlimited_arguments }

    context 'with no arguments' do
      it { expect(subject.new.to_s).to eq 'sortBy=relevance&sortOrder=descending' }
    end
    context 'with IDs' do
      context '1105.5379' do
        it { expect(subject.new('1105.5379').to_s).to eq 'sortBy=relevance&sortOrder=descending&id_list=1105.5379' }
      end
      context 'cond-mat/9609089' do
        it { expect(subject.new('cond-mat/9609089').to_s).to eq 'sortBy=relevance&sortOrder=descending&id_list=cond-mat/9609089' }
      end
      context '1105.5379, cond-mat/9609089 and cs/0003044' do
        it { expect(subject.new(*%w[1105.5379 cond-mat/9609089 cs/0003044]).to_s).to eq 'sortBy=relevance&sortOrder=descending&id_list=1105.5379,cond-mat/9609089,cs/0003044' }
      end
    end
    context 'with key-word arguments' do
      context '(invalid)' do
        context :sort_by do
          it { expect { subject.new(sort_by: 'invalid') }.to raise_error TypeError }
          it { expect { subject.new(sort_by: :invalid) }.to raise_error ArgumentError }
        end
        context :sort_order do
          it { expect { subject.new(sort_order: 'invalid') }.to raise_error TypeError }
          it { expect { subject.new(sort_order: :invalid) }.to raise_error ArgumentError }
        end
      end
      context '(valid)' do
        context :sort_by do
          Arx::Query::SORT_BY.each do |key, field|
            it { expect(subject.new(sort_by: key).to_s).to eq "sortBy=#{field}&sortOrder=descending" }
          end
        end
        context :sort_order do
          Arx::Query::SORT_ORDER.each do |key, field|
            it { expect(subject.new(sort_order: key).to_s).to eq "sortBy=relevance&sortOrder=#{field}" }
          end
        end
        context "sort_by and sort_order" do
          Arx::Query::SORT_BY.each do |sort_by_key, sort_by_field|
            Arx::Query::SORT_ORDER.each do |sort_order_key, sort_order_field|
              it { expect(subject.new(sort_by: sort_by_key, sort_order: sort_order_key).to_s).to eq "sortBy=#{sort_by_field}&sortOrder=#{sort_order_field}" }
            end
          end
        end
      end
    end
    context 'with IDs and key-word arguments' do
      it { expect(subject.new('1105.5379', 'cond-mat/9609089', sort_by: :date_submitted, sort_order: :ascending).to_s).to eq 'sortBy=submittedDate&sortOrder=ascending&id_list=1105.5379,cond-mat/9609089' }
    end
  end

  %i[and or and_not].each do |connective|
    context "##{connective}" do
      let(:query) { Query.new }

      it {  }
    end
  end
end