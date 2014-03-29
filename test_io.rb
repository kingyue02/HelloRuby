class TestIO
  def test1
    dir = Dir.open('/opt')
    dir.each { |f| puts f }
  end
end
if __FILE__ == $0
  t = TestIO.new
  t.test1
end