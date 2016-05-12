#!/usr/bin/env ruby
# ruby vt.rb <hash>
require 'uirusu'
require 'pry'

vt = YAML.load_file(File.join(File.dirname(__FILE__), 'vt.yml'))
API_KEY = vt['key']

# hash = 'FD287794107630FA3116800E617466A9' #Hash for a version of Poison Ivy
hash = ARGV.first
url = 'http://www.northropgrumman.com'
# comment = 'Hey this is Poison Ivy, anyone have a copy of this binary?'

# To query a hash(sha1/sha256/md5)
# results = Uirusu::VTFile.query_report(API_KEY, hash)
# result = Uirusu::VTResult.new(hash, results)
# print result.to_stdout if result != nil

# To scan for a url
results = Uirusu::VTUrl.query_report(API_KEY, url)
result = Uirusu::VTResult.new(url, results)

binding.pry

print result.to_stdout if result != nil

# To post a comment to a resource(url/hash/scan_id)
# results = Uirusu::VTComment.post_comment(API_KEY, hash, comment)
# print results if results != nil
