RSpec::Matchers.define :get_paper do |expected|
  match {|actual| actual.title == expected}
  failure_message do |actual|
    "expected paper: \n\t\"#{expected}\"\ngot:\n\t\"#{actual.title}\""
  end
end

RSpec::Matchers.define :get_papers do |*expected|
  match {|actual| actual.map(&:title) == expected.flatten}
  failure_message do |actual|
    output = "expected papers:\n\t"
    output << expected.flatten.map {|title| "\"#{title}\""}.join(",\n\t")
    output << "\ngot:\n\t"
    output << actual.map {|paper| "\"#{paper.title}\""}.join(",\n\t")
    output
  end
end