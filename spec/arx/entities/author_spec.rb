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
  #Arx.get('cond-mat/9609089', '1105.5379', '1710.02185', '1703.04834', '1809.09415', 'hep-th/9711200').each do |paper|
  context '#to_h' do
    context 'cond-mat/9609089' do
      subject { Arx.get('cond-mat/9609089').authors.first.to_h }

      it { is_expected.to be_a Hash }
      it { expect(subject.keys).to all be_a Symbol }
      it { expect(subject).to eq({affiliated?: true, affiliations: ["ILL Grenoble, France"], name: "F. Gebhard"}) }
    end
    context '1105.5379' do
      subject { Arx.get('1105.5379').authors.first.to_h }
      it { expect(subject).to eq({ name: "Joseph K. Bradley", affiliated?: false, affiliations: []}) }
    end
    context '1710.02185' do
      subject { Arx.get('1710.02185').authors.first.to_h }
      it { expect(subject).to eq({name: "The LIGO Scientific Collaboration", affiliated?: false, affiliations: []}) }
    end
  end
end