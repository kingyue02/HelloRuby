require 'rubygems'
require 'curb'
class TestHttp
  def test1
    http = Curl.get("http://www.baidu.com/")
    puts http.body_str
  end
end

if __FILE__ == $0
  t = TestHttp.new
  t.test1
end