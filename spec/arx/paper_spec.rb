require 'spec_helper'
require 'matchers/paper'

describe Paper do
  subject { Paper }
  let(:papers) { Arx.get 'cond-mat/9609089', '1105.5379', '1710.02185' }

  context '#id' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].id).to eq 'cond-mat/9609089v1' }
    end
    context '1105.5379' do
      it { expect(papers[1].id).to eq '1105.5379v1' }
    end
    context '1710.02185' do
      it { expect(papers[2].id).to eq '1710.02185v3' }
    end
  end
  context '#url' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].url).to eq 'http://arxiv.org/abs/cond-mat/9609089v1' }
    end
    context '1105.5379' do
      it { expect(papers[1].url).to eq 'http://arxiv.org/abs/1105.5379v1' }
    end
    context '1710.02185' do
      it { expect(papers[2].url).to eq 'http://arxiv.org/abs/1710.02185v3' }
    end
  end
  context '#title' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].title).to eq 'Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling' }
    end
    context '1105.5379' do
      it { expect(papers[1].title).to eq 'Parallel Coordinate Descent for L1-Regularized Loss Minimization' }
    end
    context '1710.02185' do
      it { expect(papers[2].title).to eq "Effects of Data Quality Vetoes on a Search for Compact Binary Coalescences in Advanced LIGO's First Observing Run" }
    end
  end
  context '#summary' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].summary).to eq "In this first of three articles on the optical absorption of electrons in half-filled Peierls-distorted chains we present analytical results for non-interacting tight-binding electrons. We carefully derive explicit expressions for the current operator, the dipole transition matrix elements, and the optical absorption for electrons with a cosine dispersion relation of band width $W$ and dimerization parameter $\\delta$. New correction (``$\\eta$''-)terms to the current operator are identified. A broad band-to-band transition is found in the frequency range $W\\delta < \\omega < W$ whose shape is determined by the joint density of states for the upper and lower Peierls subbands and the strong momentum dependence of the transition matrix elements." }
    end
    context '1105.5379' do
      it { expect(papers[1].summary).to eq "We propose Shotgun, a parallel coordinate descent algorithm for minimizing L1-regularized losses. Though coordinate descent seems inherently sequential, we prove convergence bounds for Shotgun which predict linear speedups, up to a problem-dependent limit. We present a comprehensive empirical study of Shotgun for Lasso and sparse logistic regression. Our theoretical predictions on the potential for parallelism closely match behavior on real data. Shotgun outperforms other published solvers on a range of large problems, proving to be one of the most scalable algorithms for L1." }
    end
    context '1710.02185' do
      it { expect(papers[2].summary).to eq "The first observing run of Advanced LIGO spanned 4 months, from September 12, 2015 to January 19, 2016, during which gravitational waves were directly detected from two binary black hole systems, namely GW150914 and GW151226. Confident detection of gravitational waves requires an understanding of instrumental transients and artifacts that can reduce the sensitivity of a search. Studies of the quality of the detector data yield insights into the cause of instrumental artifacts and data quality vetoes specific to a search are produced to mitigate the effects of problematic data. In this paper, the systematic removal of noisy data from analysis time is shown to improve the sensitivity of searches for compact binary coalescences. The output of the PyCBC pipeline, which is a python-based code package used to search for gravitational wave signals from compact binary coalescences, is used as a metric for improvement. GW150914 was a loud enough signal that removing noisy data did not improve its significance. However, the removal of data with excess noise decreased the false alarm rate of GW151226 by more than two orders of magnitude, from 1 in 770 years to less than 1 in 186000 years." }
    end
  end
  context '#abstract' do
    it "should alias #summary" do
      expect(subject.instance_method(:abstract).original_name).to eq :summary
    end
  end
  context '#authors' do
    context 'cond-mat/9609089' do
      subject { papers[0].authors }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Author }
      it { expect(subject.map &:name).to eq ['F. Gebhard', 'K. Bott', 'M. Scheidler', 'P. Thomas', 'S. W. Koch'] }
    end
    context '1105.5379' do
      subject { papers[1].authors }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Author }
      it { expect(subject.map &:name).to eq ['Joseph K. Bradley', 'Aapo Kyrola', 'Danny Bickson', 'Carlos Guestrin'] }
    end
    context '1710.02185' do
      subject { papers[2].authors }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Author }
      it { expect(subject.size).to eq 960 } # 960 authors, no way I'm listing all of them!
    end
  end
  context '#primary_category' do
    context 'cond-mat/9609089' do
      subject { papers[0].primary_category }

      it { is_expected.to be_a Category }
      it { expect(subject.name).to eq 'cond-mat' }
    end
    context '1105.5379' do
      subject { papers[1].primary_category }

      it { is_expected.to be_a Category }
      it { expect(subject.name).to eq 'cs.LG' }
    end
    context '1710.02185' do
      subject { papers[2].primary_category }

      it { is_expected.to be_a Category }
      it { expect(subject.name).to eq 'gr-qc' }
    end
  end
  context '#category' do
    it "should alias #primary_category" do
      expect(subject.instance_method(:category).original_name).to eq :primary_category
    end
  end
  context '#categories' do
    context 'cond-mat/9609089' do
      subject { papers[0].categories }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq %w[cond-mat chem-ph] }
    end
    context '1105.5379' do
      subject { papers[1].categories }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq %w[cs.LG cs.IT math.IT] }
    end
    context '1710.02185' do
      subject { papers[2].categories }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq %w[gr-qc astro-ph.IM] }
    end
  end
  context '#published_at' do
    context 'cond-mat/9609089' do
      subject { papers[0].published_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '1996-09-10T13:52:54+00:00' }
    end
    context '1105.5379' do
      subject { papers[1].published_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '2011-05-26T19:19:30+00:00' }
    end
    context '1710.02185' do
      subject { papers[2].published_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '2017-10-05T19:18:51+00:00' }
    end
  end
  context '#updated_at' do
    context 'cond-mat/9609089' do
      subject { papers[0].updated_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '1996-09-10T13:52:54+00:00' }
    end
    context '1105.5379' do
      subject { papers[1].updated_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '2011-05-26T19:19:30+00:00' }
    end
    context '1710.02185' do
      subject { papers[2].updated_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '2017-11-07T22:45:22+00:00' }
    end
  end
  context '#revision?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].revision?).to eq false }
    end
    context '1105.5379' do
      it { expect(papers[1].revision?).to eq false }
    end
    context '1710.02185' do
      it { expect(papers[2].revision?).to eq true }
    end
  end
  context '#comment?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].comment?).to eq true }
    end
    context '1105.5379' do
      it { expect(papers[1].comment?).to eq false }
    end
    context '1710.02185' do
      it { expect(papers[2].comment?).to eq true }
    end
  end
  context '#comment' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].comment).to eq '17 pages REVTEX 3.0, 2 postscript figures; hardcopy versions before May 96 are obsolete; accepted for publication in The Philosophical Magazine B' }
    end
    context '1105.5379' do
      it { expect { papers[1].comment }.to raise_error Error::MissingField }
    end
    context '1710.02185' do
      it { expect(papers[2].comment).to eq '31 pages, 17 figures; corrected author list' }
    end
  end
  context '#journal?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].journal?).to eq true }
    end
    context '1105.5379' do
      it { expect(papers[1].journal?).to eq true }
    end
    context '1710.02185' do
      it { expect(papers[2].journal?).to eq false }
    end
  end
  context '#journal' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].journal).to eq 'Phil. Mag. B 75, pp. 1-12 (1997)' }
    end
    context '1105.5379' do
      it { expect(papers[1].journal).to eq 'In the 28th International Conference on Machine Learning, July 2011, Washington, USA' }
    end
    context '1710.02185' do
      it { expect { papers[2].journal }.to raise_error Error::MissingField }
    end
  end
  context '#pdf?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].pdf?).to eq true }
    end
    context '1105.5379' do
      it { expect(papers[1].pdf?).to eq true }
    end
    context '1710.02185' do
      it { expect(papers[2].pdf?).to eq true }
    end
  end
  context '#pdf_url' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].pdf_url).to eq 'http://arxiv.org/pdf/cond-mat/9609089v1' }
    end
    context '1105.5379' do
      it { expect(papers[1].pdf_url).to eq 'http://arxiv.org/pdf/1105.5379v1' }
    end
    context '1710.02185' do
      it { expect(papers[2].pdf_url).to eq 'http://arxiv.org/pdf/1710.02185v3' }
    end
  end
  context '#doi?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].doi?).to eq true }
    end
    context '1105.5379' do
      it { expect(papers[1].doi?).to eq false }
    end
    context '1710.02185' do
      it { expect(papers[2].doi?).to eq true }
    end
  end
  context '#doi_url' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].doi_url).to eq 'http://dx.doi.org/10.1080/13642819708205700' }
    end
    context '1105.5379' do
      it { expect { papers[1].doi_url }.to raise_error Error::MissingLink }
    end
    context '1710.02185' do
      it { expect(papers[2].doi_url).to eq 'http://dx.doi.org/10.1088/1361-6382/aaaafa' }
    end
  end
end