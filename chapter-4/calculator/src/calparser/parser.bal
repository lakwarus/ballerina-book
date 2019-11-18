import ballerina/stringutils;
import ballerina/lang.'int as ints;

public type Algorithm ALGO_FACT|ALGO_SORT;

public type Request record {
    Algorithm algorithm;
    int[] data;
};

public function parseRequest(string request) returns Request|error {
    string trimReq = request.trim();
    if trimReq.startsWith("fact ") {
        return { algorithm: ALGO_FACT, data: 
                 check parseArray(trimReq.substring(5)) };
    } else if trimReq.startsWith("sort ") {
        return { algorithm: ALGO_SORT, data: 
                 check parseArray(trimReq.substring(5)) };
    } else {
        return error(ERROR_INVALID_REQUEST);
    }
}

function parseArray(string data) returns int[]|error {
    int[] result = [];
    string[] entries = stringutils:split(data, " ");
    foreach var entry in entries {
        var item = ints:fromString(entry);
        if item is int {
            result.push(item);
        } else {
            return error(ERROR_INVALID_REQUEST);
        }
    }
    return result;
}