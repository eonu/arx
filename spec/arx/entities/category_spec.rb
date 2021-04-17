require 'spec_helper'

describe Category do
  subject { Category }

  let :categories do
    Arx.get('cond-mat/9609089', '1105.5379').map {|paper| paper.categories.first}
  end

  context '#name' do
    context 'cond-mat/9609089' do
      it { expect(categories[0].name).to eq 'cond-mat' }
    end
    context '1105.5379' do
      it { expect(categories[1].name).to eq 'cs.LG' }
    end
    context '1703.04834' do
      subject { Arx.get('1703.04834').categories }
      it { expect(subject[1].name).to eq '03D05' } # MSC class
      it { expect(subject[2].name).to eq 'F.1.1; F.4.1' } # ACM classes
    end
  end
  context '#full_name' do
    context 'cond-mat/9609089' do
      it { expect(categories[0].full_name).to eq 'Condensed Matter' }
    end
    context '1105.5379' do
      it { expect(categories[1].full_name).to eq 'Learning' }
    end
    context '1703.04834' do
      subject { Arx.get('1703.04834').categories }
      it { expect(subject[1].full_name).to be_nil } # MSC class
      it { expect(subject[2].full_name).to be_nil } # ACM classes
    end
  end
  context '#to_h' do
    context 'cond-mat/9609089' do
      subject { categories[0].to_h }
      it { is_expected.to eq({full_name: "Condensed Matter", name: "cond-mat"}) }
    end
    context '1105.5379' do
      subject { categories[1].to_h }
      it { is_expected.to eq({full_name: "Learning", name: "cs.LG"}) }
    end
    context '1710.02185' do
      subject { Arx.get('1710.02185').primary_category.to_h }
      it { is_expected.to eq({full_name: "General Relativity and Quantum Cosmology", name: "gr-qc"}) }
    end
  end
  context '#as_json' do
    context 'cond-mat/9609089' do
      subject { categories[0].as_json }
      it { is_expected.to eq({"full_name"=>"Condensed Matter", "name"=>"cond-mat"}) }
    end
    context '1105.5379' do
      subject { categories[1].as_json }
      it { is_expected.to eq({"full_name"=>"Learning", "name"=>"cs.LG"}) }
    end
    context '1703.04834' do
      context 'MSC' do
        subject { Arx.get('1703.04834').categories[1].as_json }
        it { is_expected.to eq({"full_name"=>nil, "name"=>"03D05"}) }
      end
      context 'ACM' do
        subject { Arx.get('1703.04834').categories[2].as_json }
        it { is_expected.to eq({"full_name"=>nil, "name"=>"F.1.1; F.4.1"}) }
      end
    end
  end
  context '#to_json' do
    context 'cond-mat/9609089' do
      subject { categories[0].to_json }
      it { is_expected.to eq("{\"name\":\"cond-mat\",\"full_name\":\"Condensed Matter\"}") }
    end
    context '1105.5379' do
      subject { categories[1].to_json }
      it { is_expected.to eq("{\"name\":\"cs.LG\",\"full_name\":\"Learning\"}") }
    end
    context '1703.04834' do
      context 'MSC' do
        subject { Arx.get('1703.04834').categories[1].to_json }
        it { is_expected.to eq("{\"name\":\"03D05\",\"full_name\":null}") }
      end
      context 'ACM' do
        subject { Arx.get('1703.04834').categories[2].to_json }
        it { is_expected.to eq("{\"name\":\"F.1.1; F.4.1\",\"full_name\":null}") }
      end
    end
  end
  context '#==' do
    context 'with an Arx::Category' do
      context 'with equal names' do
        it do
          category1 = categories[1]
          category2 = Arx.get('1904.12901').primary_category
          expect(category1).to eq category2
        end
      end
      context 'with different names' do
        it { expect(categories[0]).not_to eq categories[1] }
      end
    end
    context 'with other objects' do
      subject { categories[1] }

      it { is_expected.not_to eq 'cs.LG' }
      it { is_expected.not_to eq :'cs.LG' }
      it { is_expected.not_to eq 1 }
    end
  end
  context '#to_s' do
    context 'cond-mat/9609089' do
      subject { categories[0].to_s }
      it { puts subject; is_expected.to eq('Arx::Category(name: cond-mat, full_name: Condensed Matter)') }
    end
    context '1105.5379' do
      subject { categories[1].to_s }
      it { is_expected.to eq('Arx::Category(name: cs.LG, full_name: Learning)') }
    end
    context '1703.04834' do
      context 'MSC' do
        subject { Arx.get('1703.04834').categories[1].to_s }
        it { is_expected.to eq('Arx::Category(name: 03D05, full_name: nil)') }
      end
      context 'ACM' do
        subject { Arx.get('1703.04834').categories[2].to_s }
        it { is_expected.to eq('Arx::Category(name: F.1.1; F.4.1, full_name: nil)') }
      end
    end
  end
end