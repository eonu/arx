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
  context '#to_h' do
    context 'cond-mat/9609089' do
      subject { authors[0].to_h }

      it { is_expected.to be_a Hash }
      it { expect(subject.keys).to all be_a Symbol }
      it { is_expected.to eq({affiliated?: true, affiliations: ["Philipps University Marburg, Germany"], name: "K. Bott"}) }
    end
    context '1105.5379' do
      subject { authors[1].to_h }

      it { is_expected.to eq({name: "Aapo Kyrola", affiliated?: false, affiliations: []}) }
    end
    context '1710.02185' do
      subject { Arx.get('1710.02185').authors.first.to_h }

      it { is_expected.to eq({name: "The LIGO Scientific Collaboration", affiliated?: false, affiliations: []}) }
    end
  end
  context '#as_json' do
    context 'cond-mat/9609089' do
      subject { authors[0].as_json }

      it { is_expected.to be_a Hash }
      it { expect(subject.keys).to all be_a String }
      it { is_expected.to eq({'affiliated?'=>true, 'affiliations'=>["Philipps University Marburg, Germany"], 'name'=>"K. Bott"}) }
    end
    context '1105.5379' do
      subject { authors[1].as_json }

      it { is_expected.to be_a Hash }
      it { expect(subject.keys).to all be_a String }
      it { is_expected.to eq({'name'=>"Aapo Kyrola", 'affiliated?'=>false, 'affiliations'=>[]}) }
    end
  end
  context '#to_json' do
    context 'cond-mat/9609089' do
      subject { authors[0].to_json }

      it { is_expected.to be_a String }
      it { is_expected.to eq "{\"name\":\"K. Bott\",\"affiliated?\":true,\"affiliations\":[\"Philipps University Marburg, Germany\"]}" }
    end
    context '1105.5379' do
      subject { authors[1].to_json }

      it { is_expected.to be_a String }
      it { is_expected.to eq "{\"name\":\"Aapo Kyrola\",\"affiliated?\":false,\"affiliations\":[]}" }
    end
  end
  context '#==' do
    context 'with an Arx::Author' do
      context 'with equal names' do
        it do
          author1 = Arx.get('1903.12015').authors[2]
          author2 = Arx.get('1903.08844').authors[2]
          expect(author1).to eq author2
        end
      end
      context 'with different names' do
        it do
          author1 = Arx.get('1903.12015').authors[2]
          author2 = Arx.get('1903.08844').authors[3]
          expect(author1).not_to eq author2
        end
      end
      context 'with equal affiliations' do
        it do
          author1 = Arx.get('1903.12015').authors[2]
          author2 = Arx.get('1903.08844').authors[3]
          expect(author1).not_to eq author2
        end
      end
    end
    context 'with other objects' do
      subject { authors[1] }

      it { is_expected.not_to eq 'Aapo Kyrola' }
      it { is_expected.not_to eq :'Aapo Kyrola' }
      it { is_expected.not_to eq 1 }
    end
  end
end