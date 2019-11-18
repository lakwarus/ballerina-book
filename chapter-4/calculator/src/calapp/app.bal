import ballerina/io;
import laf/calparser;

public function main() {
    io:println("Hello World!");
    var result = calparser:parseRequest("xx 10 53 05 053");
    io:println(result);
}
