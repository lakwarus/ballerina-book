import ballerina/io;
import ballerina/runtime;
 
public function main() {
    worker w1 {
        int i = 100;
        float k = 2.34;
        [int, float] t1 = [i, k];
        t1 -> w2;
        io:println("[w1 -> w2] i: ", i, " k: ", k);
 
        json j = {};
        j = <- w2;
        string jStr = j.toString();
        io:println("[w1 <- w2] j: ", jStr);
        io:println("[w1 ->> w2] i: ", i);
 
        () send = i ->> w2;

        io:println("[w1 ->> w2] successful!!");

        io:println("[w1 -> w3] k: ", k);
        k -> w3;
        k -> w3;
        k -> w3;

        io:println("Waiting for worker w3 to fetch messages..");

        error? flushResult = flush w3;
        io:println("[w1 -> w3] Flushed!!");
    }
 
    worker w2 {
        int iw;
        float kw;
        [int, float] vW1 = [0, 1.0];
        vW1 = <- w1;
        [iw, kw] = vW1;
        io:println("[w2 <- w1] iw: ", iw , " kw: ", kw);

        json jw = { "name": "Ballerina" };
        io:println("[w2 -> w1] jw: ", jw);
        jw -> w1;

        int lw;
        runtime:sleep(5);
        lw = <- w1;
        io:println("[w2 <- w1] lw: ", lw);
    }

    worker w3 {
        float mw;

        runtime:sleep(50);
        mw = <- w1;
        mw = <- w1;
        mw = <- w1;
        io:println("[w3 <- w1] mw: ", mw);
    }

    wait w1;
}
