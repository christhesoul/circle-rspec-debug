require 'nokogiri'
require 'pry'

xml = File.open("xml/results4.xml") { |f| Nokogiri::XML(f) }
seed = xml.xpath('//property').attr('value')
tests = xml.xpath('//testcase').each_with_object([]) do |testcase, tests|
  tests << testcase.attr('file')
end.uniq

failure = "query_spec"
failing_test = tests.detect { _1.include?(failure) }
failing_index = tests.index(failing_test)

strategies = []

tests_to_run = tests.uniq.select.with_index do |test, i|
  strategies.all? do |strategy|
    i.send(strategy[:operator], strategy[:value])
  end
end

tests_to_run << failing_test

puts "total tests: #{tests[0..failing_index].size}"
puts "bin/rspec #{tests[0..failing_index].join(' ')}"
