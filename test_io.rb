require './http_client.rb'
require './cookie_processer.rb'
class TestIO
  def test1
    dir = Dir.open('/opt')
    dir.each { |f| puts f }
  end
  def testPic
    hc = HttpClient.new
    hc.getWithCookie('http://douban.fm/j/new_captcha','penExpPan=Y;fmNlogin="y";flag="ok"; ac="1396103417"; bid="n10VkXwC1GA"')
    code = /"([\s\S]*?)"/.match(hc.body)[1]
    puts hc.getWithCookie('http://douban.fm/misc/captcha?size=m&id='+code,'penExpPan=Y;fmNlogin="y";flag="ok"; ac="1396103417"; bid="n10VkXwC1GA"')
    puts hc.body
    f = File.open('/opt/jj.jpg','w')
    f.puts hc.body
    f.close
  end
end
if __FILE__ == $0
  t = TestIO.new
  t.testPic
end