class Hello
  def hello
    puts 'hello'
  end
end

if __FILE__ == $0
  h = Hello.new
  h.hello
end