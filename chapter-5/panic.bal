import ballerina/io;

type MyReason "CODE1"|"CODE2";

type MyErrorDetail record {|
    string message?;
    error cause?;
    string location;
|};

type MyError error<MyReason, MyErrorDetail>;

public function main() {
    string result = myErrorProneFunction();
    io:println(result);
}

function myErrorProneFunction() returns string {
    myPanicFunction();
    return "response";
}

function myPanicFunction() {
    MyError err = error("CODE1", location = "L1");
    panic err;
}
