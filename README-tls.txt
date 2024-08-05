# generate CA
botan rng --format=base64 100 | dd status=none of=./ca-pw.txt
truncate -s -1 ca-pw.txt
botan keygen --algo=RSA --params=2048 --passphrase="$(more ./ca-pw.txt)" | dd status=none of=./ca.key
botan gen_self_signed ./ca.key "K3S Amethyst CA" --ca --days=365 --path-limit=2 --country=GB --organization="K3S Amethyst" --key-pass="$(more ./ca-pw.txt)" | dd status=none of=./ca.crt

# generate app cert
botan keygen --algo=RSA --params=2048 | dd status=none of=./app.key
botan gen_pkcs10 ./app.key '127.0.0.1' --dns='*.k3s.lab' --country=GB --organization="K3S Amethyst" | dd status=none of=./app.csr
botan sign_cert --ca-key-pass="$(more ./ca-pw.txt)" --duration=90 ./ca.crt ./ca.key ./app.csr | dd status=none of=./app.crt
rm app.csr

# combine app and CA certs
cat ./app.crt ./ca.crt | dd status=none of=./appca.crt
