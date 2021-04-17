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
        it { expect(papers[0].id true).to eq 'cond-mat/9609089v1' }
      end
      context '1105.5379' do
        it { expect(papers[1].id true).to eq '1105.5379v1' }
      end
      context '1710.02185' do
        it { expect(papers[2].id true).to eq '1710.02185v4' }
      end
      context '1703.04834' do
        it { expect(papers[3].id true).to eq '1703.04834v1' }
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
        it { expect(papers[0].url true).to eq 'http://arxiv.org/abs/cond-mat/9609089v1' }
      end
      context '1105.5379' do
        it { expect(papers[1].url true).to eq 'http://arxiv.org/abs/1105.5379v1' }
      end
      context '1710.02185' do
        it { expect(papers[2].url true).to eq 'http://arxiv.org/abs/1710.02185v4' }
      end
      context '1703.04834' do
        it { expect(papers[3].url true).to eq 'http://arxiv.org/abs/1703.04834v1' }
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
      it { expect(papers[2].version).to eq 4 }
    end
    context '1703.04834' do
      it { expect(papers[3].version).to eq 1 }
    end
    context '1807.06918v1' do
      subject { Arx.get('1807.06918v1').version }
      it { is_expected.to eq 1 }
    end
    context '1807.06918v2' do
      subject { Arx.get('1807.06918v2').version }
      it { is_expected.to eq 2 }
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
      it { is_expected.to all be_an Author }
      it { expect(subject.map &:name).to eq ['F. Gebhard', 'K. Bott', 'M. Scheidler', 'P. Thomas', 'S. W. Koch'] }
    end
    context '1105.5379' do
      subject { papers[1].authors }
      it { is_expected.to all be_an Author }
      it { expect(subject.map &:name).to eq ['Joseph K. Bradley', 'Aapo Kyrola', 'Danny Bickson', 'Carlos Guestrin'] }
    end
    context '1710.02185' do
      subject { papers[2].authors }
      it { is_expected.to all be_an Author }
      it { expect(subject.size).to eq 960 } # 960 authors, no way I'm listing all of them!
    end
    context '1703.04834' do
      subject { papers[3].authors }
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
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq %w[cond-mat chem-ph] }
    end
    context '1105.5379' do
      subject { papers[1].categories }
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq %w[cs.LG cs.IT math.IT] }
    end
    context '1710.02185' do
      subject { papers[2].categories }
      it { is_expected.to all be_an Category }
      it { expect(subject.map &:name).to eq %w[gr-qc astro-ph.IM] }
    end
    context '1703.04834' do
      subject { papers[3].categories }
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
      it { expect(subject.to_s).to eq '2019-10-08T13:29:33+00:00' }
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
      it { expect(papers[2].comment).to eq '27 pages, 13 figures, published version' }
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
      it { expect(papers[2].journal?).to be true }
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
      it { expect(papers[2].journal).to eq 'Class. Quantum Grav. 35 065010 (2018)' }
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
      it { expect(papers[2].pdf_url).to eq 'http://arxiv.org/pdf/1710.02185v4' }
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
  context '#to_h' do
    context 'cond-mat/9609089' do
      context 'deep: true' do
        subject { papers[0].to_h(true) }
        it do
          is_expected.to eq({
            id: "cond-mat/9609089",
            url: "http://arxiv.org/abs/cond-mat/9609089",
            version: 1,
            revision?: false,
            title: "Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling",
            summary: "In this first of three articles on the optical absorption of electrons in half-filled Peierls-distorted chains we present analytical results for non-interacting tight-binding electrons. We carefully derive explicit expressions for the current operator, the dipole transition matrix elements, and the optical absorption for electrons with a cosine dispersion relation of band width $W$ and dimerization parameter $\\delta$. New correction (``$\\eta$''-)terms to the current operator are identified. A broad band-to-band transition is found in the frequency range $W\\delta < \\omega < W$ whose shape is determined by the joint density of states for the upper and lower Peierls subbands and the strong momentum dependence of the transition matrix elements.",
            authors: [
              {name: "F. Gebhard", affiliated?: true, affiliations: ["ILL Grenoble, France"]},
              {name: "K. Bott", affiliated?: true, affiliations: ["Philipps University Marburg, Germany"]},
              {name: "M. Scheidler", affiliated?: true, affiliations: ["Philipps University Marburg, Germany"]},
              {name: "P. Thomas", affiliated?: true, affiliations: ["Philipps University Marburg, Germany"]},
              {name: "S. W. Koch", affiliated?: true, affiliations: ["Philipps University Marburg, Germany"]}
            ],
            primary_category: {name: "cond-mat", full_name: "Condensed Matter"},
            categories: [
              {name: "cond-mat", full_name: "Condensed Matter"},
              {name: "chem-ph", full_name: "Chemical Physics"}
            ],
            published_at: DateTime.parse('1996-09-10T13:52:54+00:00'),
            updated_at: DateTime.parse('1996-09-10T13:52:54+00:00'),
            comment?: true,
            comment: "17 pages REVTEX 3.0, 2 postscript figures; hardcopy versions before May 96 are obsolete; accepted for publication in The Philosophical Magazine B",
            journal?: true,
            journal: "Phil. Mag. B 75, pp. 1-12 (1997)",
            pdf?: true,
            pdf_url: "http://arxiv.org/pdf/cond-mat/9609089v1",
            doi?: true,
            doi_url: "http://dx.doi.org/10.1080/13642819708205700"
          })
        end
      end
      context 'deep: false' do
        subject { papers[0].to_h(false) }
        it { expect(subject[:authors]).to all be_an Author }
        it { expect(subject[:categories]).to all be_a Category }
        it { expect(subject[:primary_category]).to be_a Category }
        it do
          is_expected.to include({
            id: "cond-mat/9609089",
            url: "http://arxiv.org/abs/cond-mat/9609089",
            version: 1,
            revision?: false,
            title: "Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling",
            summary: "In this first of three articles on the optical absorption of electrons in half-filled Peierls-distorted chains we present analytical results for non-interacting tight-binding electrons. We carefully derive explicit expressions for the current operator, the dipole transition matrix elements, and the optical absorption for electrons with a cosine dispersion relation of band width $W$ and dimerization parameter $\\delta$. New correction (``$\\eta$''-)terms to the current operator are identified. A broad band-to-band transition is found in the frequency range $W\\delta < \\omega < W$ whose shape is determined by the joint density of states for the upper and lower Peierls subbands and the strong momentum dependence of the transition matrix elements.",
            published_at: DateTime.parse('1996-09-10T13:52:54+00:00'),
            updated_at: DateTime.parse('1996-09-10T13:52:54+00:00'),
            comment?: true,
            comment: "17 pages REVTEX 3.0, 2 postscript figures; hardcopy versions before May 96 are obsolete; accepted for publication in The Philosophical Magazine B",
            journal?: true,
            journal: "Phil. Mag. B 75, pp. 1-12 (1997)",
            pdf?: true,
            pdf_url: "http://arxiv.org/pdf/cond-mat/9609089v1",
            doi?: true,
            doi_url: "http://dx.doi.org/10.1080/13642819708205700"
          })
        end
      end
    end
    context '1105.5379' do
      context 'deep: true' do
        subject { papers[1].to_h(true) }
        it do
          is_expected.to eq({
            id: "1105.5379",
            url: "http://arxiv.org/abs/1105.5379",
            version: 1,
            revision?: false,
            title: "Parallel Coordinate Descent for L1-Regularized Loss Minimization",
            summary: "We propose Shotgun, a parallel coordinate descent algorithm for minimizing L1-regularized losses. Though coordinate descent seems inherently sequential, we prove convergence bounds for Shotgun which predict linear speedups, up to a problem-dependent limit. We present a comprehensive empirical study of Shotgun for Lasso and sparse logistic regression. Our theoretical predictions on the potential for parallelism closely match behavior on real data. Shotgun outperforms other published solvers on a range of large problems, proving to be one of the most scalable algorithms for L1.",
            authors: [
              {name: "Joseph K. Bradley", affiliated?: false, affiliations: []},
              {name: "Aapo Kyrola", affiliated?: false, affiliations: []},
              {name: "Danny Bickson", affiliated?: false, affiliations: []},
              {name: "Carlos Guestrin", affiliated?: false, affiliations: []}
            ],
            primary_category: {name: "cs.LG", full_name: "Learning"},
            categories: [
              {name: "cs.LG", full_name: "Learning"},
              {name: "cs.IT", full_name: "Information Theory"},
              {name: "math.IT", full_name: "Information Theory"}
            ],
            published_at: DateTime.parse('2011-05-26T19:19:30+00:00'),
            updated_at: DateTime.parse('2011-05-26T19:19:30+00:00'),
            comment?: false,
            journal?: true,
            journal: "In the 28th International Conference on Machine Learning, July 2011, Washington, USA",
            pdf?: true,
            pdf_url: "http://arxiv.org/pdf/1105.5379v1",
            doi?: false
          })
        end
      end
      context 'deep: false' do
        subject { papers[1].to_h(false) }
        it { expect(subject[:authors]).to all be_an Author }
        it { expect(subject[:categories]).to all be_a Category }
        it { expect(subject[:primary_category]).to be_a Category }
        it do
          is_expected.to include({
            id: "1105.5379",
            url: "http://arxiv.org/abs/1105.5379",
            version: 1,
            revision?: false,
            title: "Parallel Coordinate Descent for L1-Regularized Loss Minimization",
            summary: "We propose Shotgun, a parallel coordinate descent algorithm for minimizing L1-regularized losses. Though coordinate descent seems inherently sequential, we prove convergence bounds for Shotgun which predict linear speedups, up to a problem-dependent limit. We present a comprehensive empirical study of Shotgun for Lasso and sparse logistic regression. Our theoretical predictions on the potential for parallelism closely match behavior on real data. Shotgun outperforms other published solvers on a range of large problems, proving to be one of the most scalable algorithms for L1.",
            published_at: DateTime.parse('2011-05-26T19:19:30+00:00'),
            updated_at: DateTime.parse('2011-05-26T19:19:30+00:00'),
            comment?: false,
            journal?: true,
            journal: "In the 28th International Conference on Machine Learning, July 2011, Washington, USA",
            pdf?: true,
            pdf_url: "http://arxiv.org/pdf/1105.5379v1",
            doi?: false
          })
        end
      end
    end
  end
  context '#as_json' do
    context 'cond-mat/9609089' do
      subject { papers[0].as_json }
      it do
        is_expected.to eq({
          "id"=>"cond-mat/9609089",
          "url"=>"http://arxiv.org/abs/cond-mat/9609089",
          "version"=>1,
          "revision?"=>false,
          "title"=>"Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling",
          "summary"=>"In this first of three articles on the optical absorption of electrons in half-filled Peierls-distorted chains we present analytical results for non-interacting tight-binding electrons. We carefully derive explicit expressions for the current operator, the dipole transition matrix elements, and the optical absorption for electrons with a cosine dispersion relation of band width $W$ and dimerization parameter $\\delta$. New correction (``$\\eta$''-)terms to the current operator are identified. A broad band-to-band transition is found in the frequency range $W\\delta < \\omega < W$ whose shape is determined by the joint density of states for the upper and lower Peierls subbands and the strong momentum dependence of the transition matrix elements.",
          "authors"=>[
            {"name"=>"F. Gebhard", "affiliated?"=>true, "affiliations"=>["ILL Grenoble, France"]},
            {"name"=>"K. Bott", "affiliated?"=>true, "affiliations"=>["Philipps University Marburg, Germany"]},
            {"name"=>"M. Scheidler", "affiliated?"=>true, "affiliations"=>["Philipps University Marburg, Germany"]},
            {"name"=>"P. Thomas", "affiliated?"=>true, "affiliations"=>["Philipps University Marburg, Germany"]},
            {"name"=>"S. W. Koch", "affiliated?"=>true, "affiliations"=>["Philipps University Marburg, Germany"]}
          ],
          "primary_category"=>{"name"=>"cond-mat", "full_name"=>"Condensed Matter"},
          "categories"=>[
            {"name"=>"cond-mat", "full_name"=>"Condensed Matter"},
            {"name"=>"chem-ph", "full_name"=>"Chemical Physics"}
          ],
          "published_at"=>"1996-09-10T13:52:54+00:00",
          "updated_at"=>"1996-09-10T13:52:54+00:00",
          "comment?"=>true,
          "comment"=>"17 pages REVTEX 3.0, 2 postscript figures; hardcopy versions before May 96 are obsolete; accepted for publication in The Philosophical Magazine B",
          "journal?"=>true,
          "journal"=>"Phil. Mag. B 75, pp. 1-12 (1997)",
          "pdf?"=>true,
          "pdf_url"=>"http://arxiv.org/pdf/cond-mat/9609089v1",
          "doi?"=>true,
          "doi_url"=>"http://dx.doi.org/10.1080/13642819708205700"
        })
      end
    end
    context '1703.04834' do
      subject { papers[3].as_json }
      it do
        is_expected.to eq({
          "id"=>"1703.04834",
          "url"=>"http://arxiv.org/abs/1703.04834",
          "version"=>1,
          "revision?"=>false,
          "title"=>"A Quasi-Linear Time Algorithm Deciding Whether Weak Büchi Automata Reading Vectors of Reals Recognize Saturated Languages",
          "summary"=>"This work considers weak deterministic B\\\"uchi automata reading encodings of non-negative $d$-vectors of reals in a fixed base. A saturated language is a language which contains all encoding of elements belonging to a set of $d$-vectors of reals. A Real Vector Automaton is an automaton which recognizes a saturated language. It is explained how to decide in quasi-linear time whether a minimal weak deterministic B\\\"uchi automaton is a Real Vector Automaton. The problem is solved both for the two standard encodings of vectors of numbers: the sequential encoding and the parallel encoding. This algorithm runs in linear time for minimal weak B\\\"uchi automata accepting set of reals. Finally, the same problem is also solved for parallel encoding of automata reading vectors of relative reals.",
          "authors"=>[
            {"name"=>"Arthur Milchior", "affiliated?"=>false, "affiliations"=>[]}
          ],
          "primary_category"=>{"name"=>"cs.FL", "full_name"=>"Formal Languages and Automata Theory"},
          "categories"=>[
            {"name"=>"cs.FL", "full_name"=>"Formal Languages and Automata Theory"},
            {"name"=>"03D05", "full_name"=>nil},
            {"name"=>"F.1.1; F.4.1", "full_name"=>nil}
          ],
          "published_at"=>"2017-03-14T23:41:24+00:00",
          "updated_at"=>"2017-03-14T23:41:24+00:00",
          "comment?"=>false,
          "journal?"=>false,
          "pdf?"=>true,
          "pdf_url"=>"http://arxiv.org/pdf/1703.04834v1",
          "doi?"=>false
        })
      end
    end
  end
  context '#to_json' do
    context 'cond-mat/9609089' do
      subject { papers[0].to_json }
      it { is_expected.to eq("{\"id\":\"cond-mat/9609089\",\"url\":\"http://arxiv.org/abs/cond-mat/9609089\",\"version\":1,\"revision?\":false,\"title\":\"Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling\",\"summary\":\"In this first of three articles on the optical absorption of electrons in half-filled Peierls-distorted chains we present analytical results for non-interacting tight-binding electrons. We carefully derive explicit expressions for the current operator, the dipole transition matrix elements, and the optical absorption for electrons with a cosine dispersion relation of band width $W$ and dimerization parameter $\\\\delta$. New correction (``$\\\\eta$''-)terms to the current operator are identified. A broad band-to-band transition is found in the frequency range $W\\\\delta < \\\\omega < W$ whose shape is determined by the joint density of states for the upper and lower Peierls subbands and the strong momentum dependence of the transition matrix elements.\",\"authors\":[{\"name\":\"F. Gebhard\",\"affiliated?\":true,\"affiliations\":[\"ILL Grenoble, France\"]},{\"name\":\"K. Bott\",\"affiliated?\":true,\"affiliations\":[\"Philipps University Marburg, Germany\"]},{\"name\":\"M. Scheidler\",\"affiliated?\":true,\"affiliations\":[\"Philipps University Marburg, Germany\"]},{\"name\":\"P. Thomas\",\"affiliated?\":true,\"affiliations\":[\"Philipps University Marburg, Germany\"]},{\"name\":\"S. W. Koch\",\"affiliated?\":true,\"affiliations\":[\"Philipps University Marburg, Germany\"]}],\"primary_category\":{\"name\":\"cond-mat\",\"full_name\":\"Condensed Matter\"},\"categories\":[{\"name\":\"cond-mat\",\"full_name\":\"Condensed Matter\"},{\"name\":\"chem-ph\",\"full_name\":\"Chemical Physics\"}],\"published_at\":\"1996-09-10T13:52:54+00:00\",\"updated_at\":\"1996-09-10T13:52:54+00:00\",\"comment?\":true,\"comment\":\"17 pages REVTEX 3.0, 2 postscript figures; hardcopy versions before May 96 are obsolete; accepted for publication in The Philosophical Magazine B\",\"journal?\":true,\"journal\":\"Phil. Mag. B 75, pp. 1-12 (1997)\",\"pdf?\":true,\"pdf_url\":\"http://arxiv.org/pdf/cond-mat/9609089v1\",\"doi?\":true,\"doi_url\":\"http://dx.doi.org/10.1080/13642819708205700\"}") }
    end
    context '1703.04834' do
      subject { papers[3].to_json }
      it { is_expected.to eq("{\"id\":\"1703.04834\",\"url\":\"http://arxiv.org/abs/1703.04834\",\"version\":1,\"revision?\":false,\"title\":\"A Quasi-Linear Time Algorithm Deciding Whether Weak Büchi Automata Reading Vectors of Reals Recognize Saturated Languages\",\"summary\":\"This work considers weak deterministic B\\\\\\\"uchi automata reading encodings of non-negative $d$-vectors of reals in a fixed base. A saturated language is a language which contains all encoding of elements belonging to a set of $d$-vectors of reals. A Real Vector Automaton is an automaton which recognizes a saturated language. It is explained how to decide in quasi-linear time whether a minimal weak deterministic B\\\\\\\"uchi automaton is a Real Vector Automaton. The problem is solved both for the two standard encodings of vectors of numbers: the sequential encoding and the parallel encoding. This algorithm runs in linear time for minimal weak B\\\\\\\"uchi automata accepting set of reals. Finally, the same problem is also solved for parallel encoding of automata reading vectors of relative reals.\",\"authors\":[{\"name\":\"Arthur Milchior\",\"affiliated?\":false,\"affiliations\":[]}],\"primary_category\":{\"name\":\"cs.FL\",\"full_name\":\"Formal Languages and Automata Theory\"},\"categories\":[{\"name\":\"cs.FL\",\"full_name\":\"Formal Languages and Automata Theory\"},{\"name\":\"03D05\",\"full_name\":null},{\"name\":\"F.1.1; F.4.1\",\"full_name\":null}],\"published_at\":\"2017-03-14T23:41:24+00:00\",\"updated_at\":\"2017-03-14T23:41:24+00:00\",\"comment?\":false,\"journal?\":false,\"pdf?\":true,\"pdf_url\":\"http://arxiv.org/pdf/1703.04834v1\",\"doi?\":false}") }
    end
  end
  context '#==' do
    context 'with an Arx::Paper' do
      context 'with equal IDs' do
        subject { papers[0] }
        it { is_expected.to eq papers[0] }
      end
      context 'with different IDs' do
        subject { papers[0] }
        it { is_expected.not_to eq papers[1] }
      end
      context 'with equal IDs and different versions' do
        it do
          version1 = Arx.get('1807.06918v1')
          version2 = Arx.get('1807.06918v2')
          expect(version1).to eq version2
        end
      end
    end
    context 'with other objects' do
      subject { papers[0] }
      it { is_expected.not_to eq 'cond-mat/9609089' }
      it { is_expected.not_to eq :'cond-mat/9609089' }
      it { is_expected.not_to eq 1 }
    end
  end
  context '#save' do
    context 'with an existing directory' do
      # TODO
    end
    context 'with a non-existing directory' do
      # TODO
    end
    context 'with an existing file path' do
      # TODO
    end
    context 'with a non-existing file path' do
      # TODO
    end
    context 'with an invalid file path type' do
      # TODO
    end
  end
  context '#to_s' do
    context 'cond-mat/9609089' do
      subject { papers[0].to_s }
      it { is_expected.to eq('Arx::Paper(id: cond-mat/9609089v1, published_at: 1996-09-10, authors: [F. Gebhard, K. Bott, ...], title: Optical absorption of non-interacting tight-binding electrons in a Peierls-distorted chain at half band-filling)') }
    end
    context '1703.04834' do
      subject { papers[3].to_s }
      it { is_expected.to eq('Arx::Paper(id: 1703.04834v1, published_at: 2017-03-14, authors: [Arthur Milchior], title: A Quasi-Linear Time Algorithm Deciding Whether Weak Büchi Automata Reading Vectors of Reals Recognize Saturated Languages)') }
    end
  end
end