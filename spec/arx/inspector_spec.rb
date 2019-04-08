require 'spec_helper'

class Test
  include Inspector
  define_method(:a) { }
  define_method(:b) { raise StandardError.new }
  define_method(:c) { :c }
  define_method(:d) { ?d.ord }
  define_method(:e) { ?e }
end

describe Inspector do
  context 'no methods' do
    before { Test.send :inspector }

    it do
      instance = Test.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} >"
    end
  end
  context 'erroneous methods' do
    before { Test.send :inspector, :b }

    it do
      instance = Test.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} >"
    end
  end
  context 'nil-return methods' do
    before { Test.send :inspector, :a }

    it do
      instance = Test.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} a=nil>"
    end
  end
  context 'valid-return methods' do
    before { Test.send :inspector, *%i[c d e] }

    it do
      instance = Test.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} c=:c, d=100, e=\"e\">"
    end
  end
  context 'all methods' do
    before { Test.send :inspector, *%i[a b c d e] }

    it do
      instance = Test.new
      expect(instance.inspect).to eq "#<Test:#{instance.object_id} a=nil, c=:c, d=100, e=\"e\">"
    end
  end
end