@echo off
echo ��ʼ��װ...

rem ��������֤�鵼�뵽�����εİ䷢֤�������
rem ���������p12��pfx��ʽ��crt����
rem crt�ᱨ��SSLδ�����SSL֤�飬����1312
rem https://stackoverflow.com/questions/13076915/ssl-certificate-add-failed-when-binding-to-port
rem https://www.cnblogs.com/CreateMyself/archive/2016/09/25/5904002.html
rem �鿴CertUtil�÷�CertUtil -?��CertUtil -importPFX -?

rem �ڱ��ؼ�����˻������û��˻����µ����֤�鼰��Կ
CertUtil -f -p 123456 -importPFX "%~dp0/certs/root.p12"

rem �ڱ��ؼ�����˻������û��˻����µ�������֤�鼰��Կ
CertUtil -f -p 123456 -importPFX "%~dp0/certs/server.p12"

rem ���������ռ䱣��
rem https://docs.microsoft.com/en-us/windows/desktop/Http/add-urlacl
netsh http delete urlacl url=https://+:7364/
netsh http add urlacl url=https://+:7364/ user=everyone

rem ���ö˿ڰ�֤��
rem https://github.com/NancyFx/Nancy/wiki/Accessing-the-client-certificate-when-using-SSL#configuration-of-hostingself
rem https://docs.microsoft.com/zh-cn/dotnet/framework/wcf/feature-details/how-to-configure-a-port-with-an-ssl-certificate
rem ipport IP��ַ�Ͷ˿�
rem certhash ֤��ָ��
rem appid AssemblyTitle.cs�ļ������õ�[assembly: Guid("{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}")]
netsh http delete sslcert ipport=0.0.0.0:7364
netsh http add sslcert ipport=0.0.0.0:7364 certhash=754cde11861190347b88c17819802f547ee77b2b appid={c32ab972-62b0-4f1e-8560-67e03e68f2c3}

if %errorlevel% == 0 (
	echo ��װ�ɹ�!
) else (
	echo ��װʧ��!
)
pause
