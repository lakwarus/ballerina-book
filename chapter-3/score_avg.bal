import ballerina/lang.'int as ints;
import ballerina/io;

public function main() returns error? {
    int[] scores = [];
    int i = 0;
    while true {
        string input = io:readln("Enter score (q to end): ");
        if (input == "q") {
            break;
        } else {
            scores[i] = check ints:fromString(input);
        }
        i += 1;
    }
    io:println("Score List: ", scores, " Average: ", avg(scores));
}

function avg(int[] scores) returns int {
    int sum = 0;
    int i = 0;
    while i < scores.length() {
        sum += scores[i];
        i += 1;
    }
    return sum / scores.length();
}