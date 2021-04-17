require 'spec_helper'

describe Query do
  let(:default_arguments) {'sortBy=relevance&sortOrder=descending&start=0&max_results=10'}

  context '.initialize' do
    subject { Query }

    it { is_expected.to respond_to(:new).with(0..1).arguments }
    it { is_expected.to respond_to(:new).with_unlimited_arguments }

    context 'with no arguments' do
      it { expect(subject.new.to_s).to eq default_arguments }
    end
    context 'with IDs' do
      context '1105.5379' do
        it { expect(subject.new('1105.5379').to_s).to eq "#{default_arguments}&id_list=1105.5379" }
      end
      context 'cond-mat/9609089' do
        it { expect(subject.new('cond-mat/9609089').to_s).to eq "#{default_arguments}&id_list=cond-mat/9609089" }
      end
      context '1105.5379, cond-mat/9609089 and cs/0003044' do
        it { expect(subject.new(*%w[1105.5379 cond-mat/9609089 cs/0003044]).to_s).to eq "#{default_arguments}&id_list=1105.5379,cond-mat/9609089,cs/0003044" }
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
        context :start do
          it { expect { subject.new(start: 'zero') }.to raise_error TypeError }
          it { expect { subject.new(start: :zero) }.to raise_error TypeError }
          it { expect { subject.new(start: [3,78]) }.to raise_error TypeError }
        end
        context :max_results do
          it { expect { subject.new(max_results: 'zero') }.to raise_error TypeError }
          it { expect { subject.new(max_results: :zero) }.to raise_error TypeError }
          it { expect { subject.new(max_results: [3,78]) }.to raise_error TypeError }
        end
      end
      context '(valid)' do
        context :sort_by do
          Arx::Query::SORT_BY.each do |key, field|
            it { expect(subject.new(sort_by: key).to_s).to eq "sortBy=#{field}&sortOrder=descending&start=0&max_results=10" }
          end
        end
        context :sort_order do
          Arx::Query::SORT_ORDER.each do |key, field|
            it { expect(subject.new(sort_order: key).to_s).to eq "sortBy=relevance&sortOrder=#{field}&start=0&max_results=10" }
          end
        end
        context :start do
          it { expect(subject.new(start: 23).to_s).to eq "sortBy=relevance&sortOrder=descending&start=23&max_results=10" }
        end
        context :max_results do
          it { expect(subject.new(max_results: 10000).to_s).to eq "sortBy=relevance&sortOrder=descending&start=0&max_results=10000" }
        end
        context "start and max_results" do
          it { expect(subject.new(start: 33, max_results: 500).to_s).to eq "sortBy=relevance&sortOrder=descending&start=33&max_results=500" }
        end
        context "sort_by and sort_order" do
          Arx::Query::SORT_BY.each do |sort_by_key, sort_by_field|
            Arx::Query::SORT_ORDER.each do |sort_order_key, sort_order_field|
              it { expect(subject.new(sort_by: sort_by_key, sort_order: sort_order_key).to_s).to eq "sortBy=#{sort_by_field}&sortOrder=#{sort_order_field}&start=0&max_results=10" }
            end
          end
        end
        context "all" do
          Arx::Query::SORT_BY.each do |sort_by_key, sort_by_field|
            Arx::Query::SORT_ORDER.each do |sort_order_key, sort_order_field|
              it { expect(subject.new(sort_by: sort_by_key, sort_order: sort_order_key, start: 13, max_results: 2).to_s).to eq "sortBy=#{sort_by_field}&sortOrder=#{sort_order_field}&start=13&max_results=2" }
            end
          end
        end
      end
    end
    context 'with IDs and key-word arguments' do
      it { expect(subject.new('1105.5379', 'cond-mat/9609089', sort_by: :submitted_at, sort_order: :ascending).to_s).to eq 'sortBy=submittedDate&sortOrder=ascending&start=0&max_results=10&id_list=1105.5379,cond-mat/9609089' }
    end
  end

  Query::CONNECTIVES.keys.each do |connective|
    context "##{connective}" do
      let(:query) { Query.new }

      context 'without a query string' do
        it do
          before = query.to_s
          expect(query.send(connective).to_s).to eq before
        end
      end
      context 'with a query string' do
        it { expect(query.title('Test').send(connective).to_s).to eq "sortBy=relevance&sortOrder=descending&start=0&max_results=10&search_query=ti:%22Test%22+#{Query::CONNECTIVES[connective]}" }
      end
      context 'with connective already present' do
        Query::CONNECTIVES.keys.each do |existing|
          it { expect(query.title('Test').send(existing).send(connective).to_s).to eq "sortBy=relevance&sortOrder=descending&start=0&max_results=10&search_query=ti:%22Test%22+#{Query::CONNECTIVES[existing]}" }
        end
      end
    end
  end

  Query::FIELDS.keys.each do |field|
    context "##{field}" do
      let(:query) { Query.new }

      context 'without a query string' do
        it { expect(query.send(field, 'cs.AI').to_s).to eq "#{default_arguments}&search_query=#{Query::FIELDS[field]}:%22cs.AI%22" }
      end
      context 'without a prior connective' do
        it { expect(query.title('test').send(field, 'cs.AI').to_s).to eq "#{default_arguments}&search_query=ti:%22test%22+AND+#{Query::FIELDS[field]}:%22cs.AI%22" }
      end
      context 'with a prior connective' do
        Query::CONNECTIVES.keys.each do |connective|
          it { expect(query.title('test').send(connective).send(field, 'cs.AI').to_s).to eq "#{default_arguments}&search_query=ti:%22test%22+#{Query::CONNECTIVES[connective]}+#{Query::FIELDS[field]}:%22cs.AI%22" }
        end
      end
      context 'exact: false' do
        it { expect(query.send(field, 'cs.AI', exact: false).to_s).to eq "#{default_arguments}&search_query=#{Query::FIELDS[field]}:cs.AI" }
      end
      context 'with multiple values' do
        it { expect(query.title('test').send(field, 'cs.AI', 'cs.LG').to_s).to eq "#{default_arguments}&search_query=ti:%22test%22+AND+%28#{Query::FIELDS[field]}:%22cs.AI%22+AND+#{Query::FIELDS[field]}:%22cs.LG%22%29" }

        context 'exact: false' do
          it { expect(query.title('test').send(field, 'cs.AI', 'cs.LG', exact: false).to_s).to eq "#{default_arguments}&search_query=ti:%22test%22+AND+%28#{Query::FIELDS[field]}:cs.AI+AND+#{Query::FIELDS[field]}:cs.LG%29" }
        end

        Query::CONNECTIVES.keys.each do |connective|
          context "connective: #{connective}" do
            it { expect(query.title('test').send(field, 'cs.AI', 'cs.LG', connective: connective).to_s).to eq "#{default_arguments}&search_query=ti:%22test%22+AND+%28#{Query::FIELDS[field]}:%22cs.AI%22+#{Query::CONNECTIVES[connective]}+#{Query::FIELDS[field]}:%22cs.LG%22%29" }
          end
        end
      end
    end
  end

  context '#group' do
    subject { Query }

    context 'with no search query' do
      it { expect(subject.new.group {}.to_s).to eq "#{default_arguments}&search_query=%28%29" }
      it do
        query = subject.new.tap do |q|
          q.group { q.title 'Buchi automata' }
        end
        expect(query.to_s).to eq "#{default_arguments}&search_query=%28ti:%22Buchi+automata%22%29"
      end
      it do
        query = subject.new.tap do |q|
          q.group { q.group { q.group {} } }
        end
        expect(query.to_s).to eq "#{default_arguments}&search_query=%28+%28+%28%29%29%29"
      end
    end
    context 'with no block' do
      it { expect{ subject.new.title('').group }.to raise_error LocalJumpError }
    end
    context 'with no search query and no block' do
      it { expect{ subject.new.group }.to raise_error LocalJumpError }
    end
    context 'with a search query and block' do
      it do
        query = subject.new.tap do |q|
          q.title 'Buchi automata'
          q.group do
            q.category 'cs.FL'
            q.and_not
            q.author 'Tomáš Babiak'
          end
        end
        expect(query.to_s).to eq "#{default_arguments}&search_query=ti:%22Buchi+automata%22+AND+%28cat:%22cs.FL%22+ANDNOT+au:%22Tom%C3%A1%C5%A1+Babiak%22%29"
      end
      it do
        query = subject.new.tap do |q|
          q.title 'Buchi automata'
          q.group do
            q.category 'cs.FL', 'cs.CC', connective: :or
            q.and_not
            q.author 'Tomáš Babiak'
          end
        end
        expect(query.to_s).to eq "#{default_arguments}&search_query=ti:%22Buchi+automata%22+AND+%28%28cat:%22cs.FL%22+OR+cat:%22cs.CC%22%29+ANDNOT+au:%22Tom%C3%A1%C5%A1+Babiak%22%29"
      end
      it do
        query = subject.new.tap do |q|
          q.title 'Buchi automata'
          q.group do
            q.author 'Tomáš Babiak'
            q.or
            q.category 'cs.FL', 'cs.CC', connective: :or
          end
        end
        expect(query.to_s).to eq "#{default_arguments}&search_query=ti:%22Buchi+automata%22+AND+%28au:%22Tom%C3%A1%C5%A1+Babiak%22+OR+%28cat:%22cs.FL%22+OR+cat:%22cs.CC%22%29%29"
      end
      it do
        query = subject.new.tap do |q|
          q.title 'Buchi automata'
          q.group do
            q.category 'cs.FL', 'cs.CC', connective: :and_not
          end
        end
        expect(query.to_s).to eq "#{default_arguments}&search_query=ti:%22Buchi+automata%22+AND+%28%28cat:%22cs.FL%22+ANDNOT+cat:%22cs.CC%22%29%29"
      end
    end
  end
  context '#search_query?' do
    subject { Query }

    context 'with no search query' do
      it { expect(subject.new.send :search_query?).to be false }
    end
    context 'with a search query' do
      it { expect(subject.new.title('').send :search_query?).to be true }
    end
  end
  context '#end_with_connective?' do
    subject { Query }

    context 'with no connective' do
      it { expect(subject.new.send :end_with_connective?).to be false }
      it { expect(subject.new.title('').send :end_with_connective?).to be false }
    end
    context 'with connective' do
      Query::CONNECTIVES.keys.each do |connective|
        context connective.to_s do
          it { expect(subject.new.title('').send(connective).send :end_with_connective?).to be true }
        end
      end
    end
  end
  context '#start_of_group?' do
    subject { Query }

    context 'with no start-of-group' do
      it { expect(subject.new.send :start_of_group?).to be false }
      it { expect(subject.new.title('a', 'b').send :start_of_group?).to be false }
    end
    context 'with a start-of-group' do
      it do
        query = subject.new.title('')
        query.instance_variable_set "@query", query.to_s << "+#{CGI.escape '('}"
        expect(query.send :start_of_group?).to be true
      end
    end
  end
  context '#parenthesize' do
    subject { Query }

    it { expect(subject.new.send :parenthesize, 'test').to eq '%28test%29' }
    it { expect(subject.new.send :parenthesize, '(test)').to eq '%28(test)%29' }
  end
  context '#enquote' do
    subject { Query }

    it { expect(subject.new.send :enquote, 'test').to eq '%22test%22' }
    it { expect(subject.new.send :enquote, '"test"').to eq '%22"test"%22' }
  end
end