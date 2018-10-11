##CA
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 365 -out ca.pem -config openssl.conf
##SERVER
openssl genrsa -out server-key.pem 2048
openssl req -new -key server-key.pem -out server.csr -config openssl.conf
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -extfile docker-ca.conf -extensions 'server' -out server.pem -days 365 -sha256
#CLIENT
openssl genrsa -out key.pem 512
openssl req -new -key key.pem -out client.csr -config openssl.conf
openssl x509 -req -in client.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out cert.pem -days 365 -sha256