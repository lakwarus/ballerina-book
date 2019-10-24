import ballerina/io;

public function main() {
    int i = 1;
    while i <= 100 {
        io:println(i);
        i += 1;
    }
}