import ballerina/io;

public function main() {
    int i = 0;
    while i < 10 {
        io:println(i);
        i = i + 1;
        int j = 20;
    }
    io:println(j);
}