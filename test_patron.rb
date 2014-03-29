require './http_client.rb'
require './cookie_processer.rb'
class TestPatron
  def test1(un, pw)
    hc = HttpClient.new
    hc.get 'http://www.baidu.com'
    baiduID = CookieProcesser.get('BAIDUID', hc.cookieString)
    hpss = CookieProcesser.get('H_PS_PSSID', hc.cookieString)
    hc.getWithCookie('https://passport.baidu.com/v2/api/?getapi&class=login&tpl=mn&tangram=false', 'BAIDUID='+baiduID+';H_PS_PSSID='+hpss+';HOSUPPORT=1;')
    token = /login_token='([\s\S]*?)';/.match(hc.body)[1]
    hc.getWithCookie("https://passport.baidu.com/v2/api/?loginhistory&token=" + token + "&tpl=mn&apiver=v3&tt=" + Time.now.to_i.to_s + "&callback=bd__cbs__vehc6w", 'BAIDUID='+baiduID+';H_PS_PSSID='+hpss+';HOSUPPORT=1;')
    ubi = hc.cookieArray['UBI']
    passid = hc.cookieArray['PASSID']
    data = {
        'apiver' => 'v3',
        'callback' => 'parent.bd__pcbs__k2eobr',
        'charset' => 'utf-8',
        'codestring' => '',
        'isPhone' => '',
        'loginmerge' => 'true',
        'logintype' => 'dialogLogin',
        'logLoginType' => 'pc_loginDialog',
        'mem_pass' => 'on',
        'password' => pw,
        'ppui_logintime' => '19682',
        'quick_user' => '0',
        'safeflg' => '0',
        'splogin' => 'rate',
        'staticpage' => 'http://www.baidu.com/cache/user/html/v3Jump.html',
        'token' => token,
        'tpl' => 'mn',
        'tt' => Time.now.to_i.to_s,
        'u' => 'http://www.baidu.com/',
        'username' => un,
        'verifycode' => ''
    }
    hc.postWithCookie('https://passport.baidu.com/v2/api/?login', data, 'BAIDUID='+baiduID+';H_PS_PSSID='+hpss+';HOSUPPORT=1;UBI='+ubi)
    if(hc.body.include?('err_no=0'))
      hao123 = /hao123Param=([\s\S]*?)&/.match(hc.body)[1]
    else
      puts 'needs to input verifycode'
    end
    #hc.getWithCookie("http://user.hao123.com/static/crossdomain.php?bdu=" + hao123 + "&t=" + Time.now.to_i.to_s,hc.cookieString)
    hc.cookieArray
  end
end

if __FILE__ == $0
  t = TestPatron.new
  t.test1('gsh199449',gets).each { |k,v| puts k+'-------'+v}
end