require 'spec_helper'

describe Paper do
  subject { Paper }

  let :papers do
    Arx.get 'cond-mat/9609089', '1105.5379', '1710.02185', '1703.04834'
  end

  context '#id' do
    context 'without version' do
      context 'cond-mat/9609089' do
        it { expect(papers[0].id).to eq 'cond-mat/9609089' }
      end
      context '1105.5379' do
        it { expect(papers[1].id).to eq '1105.5379' }
      end
      context '1710.02185' do
        it { expect(papers[2].id).to eq '1710.02185' }
      end
      context '1703.04834' do
        it { expect(papers[3].id).to eq '1703.04834' }
      end
    end
    context 'with version' do
      context 'cond-mat/9609089' do
        it { expect(papers[0].id version: true).to eq 'cond-mat/9609089v1' }
      end
      context '1105.5379' do
        it { expect(papers[1].id version: true).to eq '1105.5379v1' }
      end
      context '1710.02185' do
        it { expect(papers[2].id version: true).to eq '1710.02185v3' }
      end
      context '1703.04834' do
        it { expect(papers[3].id version: true).to eq '1703.04834v1' }
      end
    end
  end
  context '#url' do
    context 'without version' do
      context 'cond-mat/9609089' do
        it { expect(papers[0].url).to eq 'http://arxiv.org/abs/cond-mat/9609089' }
      end
      context '1105.5379' do
        it { expect(papers[1].url).to eq 'http://arxiv.org/abs/1105.5379' }
      end
      context '1710.02185' do
        it { expect(papers[2].url).to eq 'http://arxiv.org/abs/1710.02185' }
      end
      context '1703.04834' do
        it { expect(papers[3].url).to eq 'http://arxiv.org/abs/1703.04834' }
      end
    end
    context 'with version' do
      context 'cond-mat/9609089' do
        it { expect(papers[0].url version: true).to eq 'http://arxiv.org/abs/cond-mat/9609089v1' }
      end
      context '1105.5379' do
        it { expect(papers[1].url version: true).to eq 'http://arxiv.org/abs/1105.5379v1' }
      end
      context '1710.02185' do
        it { expect(papers[2].url version: true).to eq 'http://arxiv.org/abs/1710.02185v3' }
      end
      context '1703.04834' do
        it { expect(papers[3].url version: true).to eq 'http://arxiv.org/abs/1703.04834v1' }
      end
    end
  end
  context '#version' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].version).to eq 1 }
    end
    context '1105.5379' do
      it { expect(papers[1].version).to eq 1 }
    end
    context '1710.02185' do
      it { expect(papers[2].version).to eq 3 }
    end
    context '1703.04834' do
      it { expect(papers[3].version).to eq 1 }
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
    context '1703.04834' do
      it { expect(papers[3].title).to eq 'A Quasi-Linear Time Algorithm Deciding Whether Weak Büchi Automata Reading Vectors of Reals Recognize Saturated Languages' }
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
    context '1703.04834' do
      it { expect(papers[3].summary).to eq "This work considers weak deterministic B\\\"uchi automata reading encodings of non-negative $d$-vectors of reals in a fixed base. A saturated language is a language which contains all encoding of elements belonging to a set of $d$-vectors of reals. A Real Vector Automaton is an automaton which recognizes a saturated language. It is explained how to decide in quasi-linear time whether a minimal weak deterministic B\\\"uchi automaton is a Real Vector Automaton. The problem is solved both for the two standard encodings of vectors of numbers: the sequential encoding and the parallel encoding. This algorithm runs in linear time for minimal weak B\\\"uchi automata accepting set of reals. Finally, the same problem is also solved for parallel encoding of automata reading vectors of relative reals." }
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
    context '1703.04834' do
      subject { papers[3].authors }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Author }
      it { expect(subject.map &:name).to eq ['Arthur Milchior'] }
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
    context '1703.04834' do
      subject { papers[3].primary_category }

      it { is_expected.to be_a Category }
      it { expect(subject.name).to eq 'cs.FL' }
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
    context '1703.04834' do
      subject { papers[3].categories }

      it { is_expected.to be_an Array }
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq ['cs.FL', '03D05', 'F.1.1; F.4.1'] }
      it { expect(subject[1...2].map &:full_name).to all be_nil } # MSC or ACM classes
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
    context '1703.04834' do
      subject { papers[3].published_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '2017-03-14T23:41:24+00:00' }
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
    context '1703.04834' do
      subject { papers[3].updated_at }

      it { is_expected.to be_a DateTime }
      it { expect(subject.to_s).to eq '2017-03-14T23:41:24+00:00' }
    end
  end
  context '#revision?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].revision?).to be false }
    end
    context '1105.5379' do
      it { expect(papers[1].revision?).to be false }
    end
    context '1710.02185' do
      it { expect(papers[2].revision?).to be true }
    end
    context '1703.04834' do
      it { expect(papers[3].revision?).to be false }
    end
  end
  context '#comment?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].comment?).to be true }
    end
    context '1105.5379' do
      it { expect(papers[1].comment?).to be false }
    end
    context '1710.02185' do
      it { expect(papers[2].comment?).to be true }
    end
    context '1703.04834' do
      it { expect(papers[3].comment?).to be false }
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
    context '1703.04834' do
      it { expect { papers[3].comment }.to raise_error Error::MissingField }
    end
  end
  context '#journal?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].journal?).to be true }
    end
    context '1105.5379' do
      it { expect(papers[1].journal?).to be true }
    end
    context '1710.02185' do
      it { expect(papers[2].journal?).to be false }
    end
    context '1703.04834' do
      it { expect(papers[3].journal?).to be false }
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
    context '1703.04834' do
      it { expect { papers[3].journal }.to raise_error Error::MissingField }
    end
  end
  context '#pdf?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].pdf?).to be true }
    end
    context '1105.5379' do
      it { expect(papers[1].pdf?).to be true }
    end
    context '1710.02185' do
      it { expect(papers[2].pdf?).to be true }
    end
    context '1703.04834' do
      it { expect(papers[3].pdf?).to be true }
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
    context '1703.04834' do
      it { expect(papers[3].pdf_url).to eq 'http://arxiv.org/pdf/1703.04834v1' }
    end
  end
  context '#doi?' do
    context 'cond-mat/9609089' do
      it { expect(papers[0].doi?).to be true }
    end
    context '1105.5379' do
      it { expect(papers[1].doi?).to be false }
    end
    context '1710.02185' do
      it { expect(papers[2].doi?).to be true }
    end
    context '1703.04834' do
      it { expect(papers[3].doi?).to be false }
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
    context '1703.04834' do
      it { expect { papers[3].doi_url }.to raise_error Error::MissingLink }
    end
  end
end