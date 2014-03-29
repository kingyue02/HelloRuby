require 'rubygems'
require 'patron'
class HttpClient
  attr_accessor :body, :cookieString, :cookieArray

  def get(url)
    sess = Patron::Session.new
    resp = sess.get(url)
    setResult resp
  end

  def getWithCookie(url, cookie)
    sess = Patron::Session.new
    sess.headers['cookie']=cookie
    resp = sess.get(url)
    setResult resp
  end

  def postWithCookie(url,data,cookie)
    sess = Patron::Session.new
    sess.headers['cookie']=cookie
    resp = sess.post(url,data)
    setResult resp
  end

  def setResult(resp)
    @body = resp.body
    @cookieArray = {}
    resp.headers['Set-Cookie'].each { |s| /([\s\S]*?)=([\s\S]*?);/.match(s);@cookieArray.store($1,$2) }
    @cookieString = ''
    @cookieArray.each_pair {|k,v| @cookieString = @cookieString + k+'='+v+';'}
  end
end