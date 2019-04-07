require 'spec_helper'

def urls
  {
    old: %w[
      https://www.arxiv.org/abs/cond-mat/9609089/
      https://www.arxiv.org/abs/cond-mat/9609089v1/
      https://www.arxiv.org/abs/cond-mat/9609089
      https://www.arxiv.org/abs/cond-mat/9609089v1
      https://arxiv.org/abs/cond-mat/9609089/
      https://arxiv.org/abs/cond-mat/9609089v1/
      https://arxiv.org/abs/cond-mat/9609089
      https://arxiv.org/abs/cond-mat/9609089v1
      http://www.arxiv.org/abs/cond-mat/9609089/
      http://www.arxiv.org/abs/cond-mat/9609089v1/
      http://www.arxiv.org/abs/cond-mat/9609089
      http://www.arxiv.org/abs/cond-mat/9609089v1
      http://arxiv.org/abs/cond-mat/9609089/
      http://arxiv.org/abs/cond-mat/9609089v1/
      http://arxiv.org/abs/cond-mat/9609089
      http://arxiv.org/abs/cond-mat/9609089v1
      www.arxiv.org/abs/cond-mat/9609089/
      www.arxiv.org/abs/cond-mat/9609089v1/
      www.arxiv.org/abs/cond-mat/9609089
      www.arxiv.org/abs/cond-mat/9609089v1
      arxiv.org/abs/cond-mat/9609089/
      arxiv.org/abs/cond-mat/9609089v1/
      arxiv.org/abs/cond-mat/9609089
      arxiv.org/abs/cond-mat/9609089v1
    ],
    new: %w[
      https://www.arxiv.org/abs/1105.5379/
      https://www.arxiv.org/abs/1105.5379v1/
      https://www.arxiv.org/abs/1105.5379
      https://www.arxiv.org/abs/1105.5379v1
      https://arxiv.org/abs/1105.5379/
      https://arxiv.org/abs/1105.5379v1/
      https://arxiv.org/abs/1105.5379
      https://arxiv.org/abs/1105.5379v1
      http://www.arxiv.org/abs/1105.5379/
      http://www.arxiv.org/abs/1105.5379v1/
      http://www.arxiv.org/abs/1105.5379
      http://www.arxiv.org/abs/1105.5379v1
      http://arxiv.org/abs/1105.5379/
      http://arxiv.org/abs/1105.5379v1/
      http://arxiv.org/abs/1105.5379
      http://arxiv.org/abs/1105.5379v1
      www.arxiv.org/abs/1105.5379/
      www.arxiv.org/abs/1105.5379v1/
      www.arxiv.org/abs/1105.5379
      www.arxiv.org/abs/1105.5379v1
      arxiv.org/abs/1105.5379/
      arxiv.org/abs/1105.5379v1/
      arxiv.org/abs/1105.5379
      arxiv.org/abs/1105.5379v1
    ]
  }
end

describe Cleaner do
  subject { Cleaner }

  context :URL_PREFIX do
    urls.values.flatten.each do |url|
      context(url) { it { expect(url).to match Cleaner::URL_PREFIX } }
    end
  end
  context '.clean' do
    [
      {uncleaned: "This\nis\na\ntest.", cleaned: "This is a test."},
      {uncleaned: "This\ris\ra\rtest.", cleaned: "This is a test."},
      {uncleaned: "This\r\nis\r\na\r\ntest.", cleaned: "This is a test."},
      {uncleaned: "  This\n\r    is\r\na test   ok. ", cleaned: "This is a test ok."},
    ].each do |example|
      it "should clean #{example[:uncleaned].inspect}" do
        expect(subject.clean example[:uncleaned]).to eq example[:cleaned]
      end
    end
  end
  context '.extract_id' do
    context 'without version' do
      context '(invalid type)' do
        it { expect { subject.extract_id 2 }.to raise_error TypeError }
      end
      context '(invalid)' do
        it { expect { subject.extract_id ?a }.to raise_error ArgumentError }
      end
      context '(valid)' do
        context 'URL' do
          context 'old format' do
            urls[:old].each do |url|
              it "should extract an ID from #{url.inspect}" do
                expect(subject.extract_id url).to eq 'cond-mat/9609089'
              end
            end
          end
          context 'new format' do
            urls[:new].each do |url|
              it "should extract an ID from #{url.inspect}" do
                expect(subject.extract_id url).to eq '1105.5379'
              end
            end
          end
        end
        context 'ID' do
          context 'old format' do
            it { expect(subject.extract_id 'cond-mat/9609089').to eq 'cond-mat/9609089' }
            it { expect(subject.extract_id 'cond-mat/9609089v1').to eq 'cond-mat/9609089' }
            it { expect(subject.extract_id 'cs/0003044').to eq 'cs/0003044' }
            it { expect(subject.extract_id 'cs/0003044v10').to eq 'cs/0003044' }
            it { expect(subject.extract_id 'hep-th/9711200').to eq 'hep-th/9711200' }
            it { expect(subject.extract_id 'hep-th/9711200v100').to eq 'hep-th/9711200' }
          end
          context 'new format' do
            it { expect(subject.extract_id '1105.5379').to eq '1105.5379' }
            it { expect(subject.extract_id '1105.5379v1').to eq '1105.5379' }
            it { expect(subject.extract_id '1710.02185').to eq '1710.02185' }
            it { expect(subject.extract_id '1710.02185v10').to eq '1710.02185' }
            it { expect(subject.extract_id '1703.04834').to eq '1703.04834' }
            it { expect(subject.extract_id '1703.04834v100').to eq '1703.04834' }
          end
        end
      end
    end
    context 'with version' do
      context 'URL' do
        context 'old format' do
          urls[:old].each_with_index do |url, i|
            if i.even?
              it "should extract an ID from #{url.inspect}" do
                expect(subject.extract_id url, version: true).to eq 'cond-mat/9609089'
              end
            else
              it "should extract an ID from #{url.inspect}" do
                expect(subject.extract_id url, version: true).to eq 'cond-mat/9609089v1'
              end
            end
          end
        end
        context 'new format' do
          urls[:new].each_with_index do |url, i|
            if i.even?
              it "should extract an ID from #{url.inspect}" do
                expect(subject.extract_id url, version: true).to eq '1105.5379'
              end
            else
              it "should extract an ID from #{url.inspect}" do
                expect(subject.extract_id url, version: true).to eq '1105.5379v1'
              end
            end
          end
        end
      end
      context 'ID' do
        context 'old format' do
          it { expect(subject.extract_id 'cond-mat/9609089').to eq 'cond-mat/9609089' }
          it { expect(subject.extract_id 'cond-mat/9609089v1').to eq 'cond-mat/9609089' }
          it { expect(subject.extract_id 'cs/0003044').to eq 'cs/0003044' }
          it { expect(subject.extract_id 'cs/0003044v10').to eq 'cs/0003044' }
          it { expect(subject.extract_id 'hep-th/9711200').to eq 'hep-th/9711200' }
          it { expect(subject.extract_id 'hep-th/9711200v100').to eq 'hep-th/9711200' }
        end
        context 'new format' do
          it { expect(subject.extract_id '1105.5379').to eq '1105.5379' }
          it { expect(subject.extract_id '1105.5379v1').to eq '1105.5379' }
          it { expect(subject.extract_id '1710.02185').to eq '1710.02185' }
          it { expect(subject.extract_id '1710.02185v10').to eq '1710.02185' }
          it { expect(subject.extract_id '1703.04834').to eq '1703.04834' }
          it { expect(subject.extract_id '1703.04834v100').to eq '1703.04834' }
        end
      end
    end
  end
  context '.extract_version' do
    context 'URL' do
      context 'old format' do
        urls[:old].each_with_index do |url, i|
          if i.even?
            it { expect { subject.extract_version url }.to raise_error ArgumentError }
          else
            it "should extract a version number from #{url.inspect}" do
              expect(subject.extract_version url).to eq 1
            end
          end
        end
      end
      context 'new format' do
        urls[:new].each_with_index do |url, i|
          if i.even?
            it { expect { subject.extract_version url }.to raise_error ArgumentError }
          else
            it "should extract a version number from #{url.inspect}" do
              expect(subject.extract_version url).to eq 1
            end
          end
        end
      end
    end
    context 'ID' do
      context 'old format' do
        it { expect { subject.extract_version 'cond-mat/9609089' }.to raise_error ArgumentError }
        it { expect(subject.extract_version 'cond-mat/9609089v1').to eq 1 }
        it { expect { subject.extract_version 'cs/0003044' }.to raise_error ArgumentError }
        it { expect(subject.extract_version 'cs/0003044v10').to eq 10 }
        it { expect { subject.extract_version 'hep-th/9711200' }.to raise_error ArgumentError }
        it { expect(subject.extract_version 'hep-th/9711200v100').to eq 100 }
      end
      context 'new format' do
        it { expect { subject.extract_version '1105.5379' }.to raise_error ArgumentError }
        it { expect(subject.extract_version '1105.5379v1').to eq 1 }
        it { expect { subject.extract_version '1710.02185' }.to raise_error ArgumentError }
        it { expect(subject.extract_version '1710.02185v10').to eq 10 }
        it { expect { subject.extract_version '1703.04834' }.to raise_error ArgumentError }
        it { expect(subject.extract_version '1703.04834v100').to eq 100 }
      end
    end
  end
end