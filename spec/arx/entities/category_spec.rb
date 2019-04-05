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
  end
  context '#full_name' do
    context 'cond-mat/9609089' do
      it { expect(categories[0].full_name).to eq 'Condensed Matter' }
    end
    context '1105.5379' do
      it { expect(categories[1].full_name).to eq 'Learning' }
    end
  end
end