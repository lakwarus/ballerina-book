import ballerina/io;
import laf/calparser;
import laf/calfunctions;

public function main() returns error? {
    string input = io:readln("Enter calculator request: ");
    calparser:Request request = check calparser:parseRequest(input);
    if request.algorithm == calparser:ALGO_FACT {
        io:println("Result: ", calfunctions:fact(request.data[0]));
    } else if request.algorithm == calparser:ALGO_SORT {
        io:println("Result: ", calfunctions:sort(request.data));
    } else {
        io:println("Unknown algorithm");
        return;
    }
}
