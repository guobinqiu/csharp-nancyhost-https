创建证书
---

1. 创建根证书密钥文件(自己做CA)root.key

   `openssl genrsa -des3 -out root.key`

2. 创建根证书的申请文件root.csr

   `openssl req -new -key root.key -out root.csr`
   
   输入内容
   
	```
	Country Name (2 letter code) [AU]:CN ← 国家代号，中国输入CN 
	State or Province Name (full name) [Some-State]:Shanghai ← 省的全名，拼音 
	Locality Name (eg, city) []:Shanghai ← 市的全名，拼音 
	Organization Name (eg, company) [Internet Widgits Pty Ltd]:xlhb. ← 公司英文名 
	Organizational Unit Name (eg, section) []: ← 可以不输入 
	Common Name (eg, YOUR name) []: ← 此时不输入 
	Email Address []:qiuguobin@gracepsy.com ← 电子邮箱，可随意填
	```

3. 创建一个自当前日期起为期十年的根证书root.crt

   `openssl x509 -req -days 3650 -sha1 -extensions v3_ca -signkey root.key -in root.req -out root.crt`

4. 将证书文件root.crt和证书密钥文件root.key合并成安装包root.p12

   `openssl pkcs12 -export -in root.crt -inkey root.key -out root.p12`

5. 创建服务器证书密钥server.key

   `openssl genrsa –des3 -out server.key 2048`

6. 创建服务器证书的申请文件server.csr

   `openssl req -new -key server.key -out server.csr`

	输入内容
	
	```
	Country Name (2 letter code) [AU]:CN ← 国家名称，中国输入CN 
	State or Province Name (full name) [Some-State]:Shanghai ← 省名，拼音 
	Locality Name (eg, city) []:Shanghai ← 市名，拼音 
	Organization Name (eg, company) [Internet Widgits Pty Ltd]:xlhb. ← 公司英文名 
	Organizational Unit Name (eg, section) []: ← 可以不输入 
	Common Name (eg, YOUR name) []: localhost ← 服务器域名
	Email Address []:qiuguobin@gracepsy.com ← 电子邮箱，可随便填
	```

7. 创建自当前日期起有效期为期两年的服务器证书server.crt

   `openssl x509 -req -days 730 -sha1 -extensions v3_req -CA root.crt -CAkey root.key -CAserial root.srl -CAcreateserial -in server.csr -out server.crt`

8. 将证书文件server.crt和证书密钥文件server.key合并成安装包server.p12

   `openssl pkcs12 -export -in root.crt -inkey root.key -out root.p12`
