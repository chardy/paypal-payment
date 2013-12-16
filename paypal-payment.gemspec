# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "paypal-payment"

Gem::Specification.new do |s|
  s.name        = "paypal-payment"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chardy Wang"]
  s.email       = ["chardy@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/paypal-payment"
  s.summary     = "PayPal Client."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "curb"
  s.add_dependency "multi_json"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "vcr"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "pry"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "activesupport"
end
