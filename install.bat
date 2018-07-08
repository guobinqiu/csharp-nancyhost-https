@echo off
echo 开始安装...

rem 将创建的证书导入到受信任的颁发证书机构中
rem 导入必须是p12或pfx格式，crt不行
rem crt会报告SSL未能添加SSL证书，错误1312
rem https://stackoverflow.com/questions/13076915/ssl-certificate-add-failed-when-binding-to-port
rem https://www.cnblogs.com/CreateMyself/archive/2016/09/25/5904002.html
rem 查看CertUtil用法CertUtil -?或CertUtil -importPFX -?

rem 在本地计算机账户（非用户账户）下导入根证书及密钥
CertUtil -f -p 123456 -importPFX "%~dp0/certs/root.p12"

rem 在本地计算机账户（非用户账户）下导入服务端证书及密钥
CertUtil -f -p 123456 -importPFX "%~dp0/certs/server.p12"

rem 配置命名空间保留
rem https://docs.microsoft.com/en-us/windows/desktop/Http/add-urlacl
netsh http delete urlacl url=https://+:7364/
netsh http add urlacl url=https://+:7364/ user=everyone

rem 配置端口绑定证书
rem https://github.com/NancyFx/Nancy/wiki/Accessing-the-client-certificate-when-using-SSL#configuration-of-hostingself
rem https://docs.microsoft.com/zh-cn/dotnet/framework/wcf/feature-details/how-to-configure-a-port-with-an-ssl-certificate
rem ipport IP地址和端口
rem certhash 证书指纹
rem appid AssemblyTitle.cs文件里配置的[assembly: Guid("{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}")]
netsh http delete sslcert ipport=0.0.0.0:7364
netsh http add sslcert ipport=0.0.0.0:7364 certhash=754cde11861190347b88c17819802f547ee77b2b appid={c32ab972-62b0-4f1e-8560-67e03e68f2c3}

if %errorlevel% == 0 (
	echo 安装成功!
) else (
	echo 安装失败!
)
pause
