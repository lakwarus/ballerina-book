import ballerina/io;

public function main() {
    int i = 0;
    while i < 100 {
        io:println(i);
        i += 1;
    }
}