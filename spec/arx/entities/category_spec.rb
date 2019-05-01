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
      subject { Arx.get('cond-mat/9609089').primary_category.to_h }

      it { is_expected.to be_a Hash }
      it { expect(subject.keys).to all be_a Symbol }
      it { expect(subject).to eq({full_name: "Condensed Matter", name: "cond-mat"}) }
    end
    context '1105.5379' do
      subject { Arx.get('1105.5379').primary_category.to_h }
      it { expect(subject).to eq({full_name: "Learning", name: "cs.LG"}) }
    end
    context '1710.02185' do
      subject { Arx.get('1710.02185').primary_category.to_h }
      it { expect(subject).to eq({full_name: "General Relativity and Quantum Cosmology", name: "gr-qc"}) }
    end
  end
end