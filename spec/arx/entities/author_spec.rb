require 'spec_helper'

describe Author do
  subject { Author }

  let :authors do
    Arx.get('cond-mat/9609089', '1105.5379').map {|paper| paper.authors[1]}
  end

  context '#name' do
    context 'cond-mat/9609089' do
      it { expect(authors[0].name).to eq 'K. Bott' }
    end
    context '1105.5379' do
      it { expect(authors[1].name).to eq 'Aapo Kyrola' }
    end
  end
  context '#affiliated?' do
    context 'cond-mat/9609089' do
      it { expect(authors[0].affiliated?).to be true }
    end
    context '1105.5379' do
      it { expect(authors[1].affiliated?).to be false }
    end
  end
  context '#affiliations' do
    context 'cond-mat/9609089' do
      it { expect(authors[0].affiliations).to eq ["Philipps University Marburg, Germany"] }
    end
    context '1105.5379' do
      it { expect(authors[1].affiliations).to be_empty }
    end
  end
end