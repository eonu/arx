require 'spec_helper'

describe Inspector do
  subject do
    Test = Class.new do
      include Inspector
      define_method(:a) { }
      define_method(:b) { raise StandardError.new }
      define_method(:c) { :c }
      define_method(:d) { ?d.ord }
      define_method(:e) { ?e }
    end
  end

  context 'no methods' do
    before { subject.send :inspector }

    it do
      instance = subject.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} >"
    end
  end
  context 'erroneous methods' do
    before { subject.send :inspector, :b }

    it do
      instance = subject.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} >"
    end
  end
  context 'nil-return methods' do
    before { subject.send :inspector, :a }

    it do
      instance = subject.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} a=nil>"
    end
  end
  context 'valid-return methods' do
    before { subject.send :inspector, *%i[c d e] }

    it do
      instance = subject.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} c=:c, d=100, e=\"e\">"
    end
  end
  context 'all methods' do
    before { subject.send :inspector, *%i[a b c d e] }

    it do
      instance = subject.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} a=nil, c=:c, d=100, e=\"e\">"
    end
  end
end