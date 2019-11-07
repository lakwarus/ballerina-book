import ballerina/io;
import ballerina/math;

type MyErrorDetail record {|
    string message?;
    error cause?;
    string location;
|};

const MyErrorReason1 = "MyReason1";
const MyErrorReason2 = "MyReason2";

type MyError1 error<MyErrorReason1, MyErrorDetail>;
type MyError2 error<MyErrorReason2>;

public function main() {
    string|error result = myErrorProneFunction();
    if (result is string) {
        io:println(result);
    } else if (result is MyError1) {
        io:println("Error1: ", result);
    } else if (result is MyError2) {
        io:println("Error2: ", result);
    }
}

function myErrorProneFunction() returns string|error {
    if (math:random() > 0.5) {
        return error(MyErrorReason1, message = "invalid input",
                     location = "MyLocation");
    } else {
        return error(MyErrorReason2, message = "invalid operation");
    }
}
