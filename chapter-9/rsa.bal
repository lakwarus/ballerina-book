01 import ballerina/crypto;
02 import ballerina/io;
03 import ballerina/lang.'string as strings;
04 
05 public function main(string... args) returns error? {
06     string input = "Hello, World!";
07     crypto:KeyStore keyStore = { path: "/usr/lib/ballerina/ballerina-1.0.0" + 
08                                  "-alpha/examples/crypto/sampleKeystore.p12",
09                                  password: "ballerina" };
10     crypto:PrivateKey privateKey = check crypto:decodePrivateKey(keyStore,
11                                          "ballerina", "ballerina");
12     crypto:PublicKey publicKey = check crypto:decodePublicKey(keyStore, 
13                                          "ballerina");
14     byte[] output = check crypto:encryptRsaEcb(input.toBytes(), publicKey);
15     io:println("RSA Public Key Encrypted Data: ", output.toBase16());
16     output = check crypto:decryptRsaEcb(output, privateKey);
17     io:println("RSA Private Key Decrypted Data: ", strings:fromBytes(output));
18 }
19 
