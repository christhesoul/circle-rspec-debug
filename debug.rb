require 'nokogiri'
require 'pry'

xml = File.open("xml/5.xml") { |f| Nokogiri::XML(f) }
seed = xml.xpath('//property').attr('value')
tests = xml.xpath('//testcase').each_with_object([]) do |testcase, tests|
  tests << testcase.attr('file')
end

failure = "gocardless_migrator"
failing_test = tests.uniq.detect { _1.include?(failure) }
failing_index = tests.uniq.index(failing_test)

strategies = [
  { operator: :>=, value: 106 },
  { operator: :<, value: 110 }
]

tests_to_run = tests.uniq.select.with_index do |test, i|
  strategies.all? do |strategy|
    i.send(strategy[:operator], strategy[:value])
  end
end

tests_to_run << failing_test

puts "bin/rspec #{tests_to_run.uniq.join(' ')} --seed #{seed}"
