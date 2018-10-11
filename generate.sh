#This Generates a ca key and certificate.
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 365 -out ca.pem -config openssl.conf
#Server authentication certificate.
openssl genrsa -out server-key.pem 2048
openssl req -new -key server-key.pem -out server.csr -config openssl.conf
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -extfile openssl.conf -extensions 'server' -out server-cert.pem -days 365 -sha256
#Client authentication certificate.
openssl genrsa -out client-key.pem 512
openssl req -new -key client-key.pem -out client.csr -config openssl.conf
openssl x509 -req -in client.csr -CA ca.pem -CAkey ca.key -CAcreateserial -extfile openssl.conf -extensions 'client' -out client-cert.pem -days 365 -sha256
#Browser compliant domain certificate.
openssl genrsa -out tls.key 2048
openssl req -new -key tls.key -out tls.csr -config openssl.conf -extensions 'v3_req'
openssl x509 -req -in tls.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -extfile openssl.conf -extensions 'v3_req' -out tls.crt -days 90 -sha256

