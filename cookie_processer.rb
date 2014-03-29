class CookieProcesser
  def CookieProcesser.get(name,cookie)
    reg = /#{name}=([\s\S]*?);/
    reg.match cookie
    $1
  end

  def CookieProcesser.listKeys cookie
    reg = /#{name}=([\s\S]*?);/
    reg.match cookie
    $1
  end
end