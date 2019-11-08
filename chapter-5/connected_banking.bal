import ballerina/io;
import ballerina/time;

const INVALID_ACCOUNT_NUMBER = "INVALID_ACCOUNT_NUMBER";
const INSUFFICIENT_ACCOUNT_BALANCE = "INSUFFICIENT_ACCOUNT_BALANCE";

type AccountMgtErrorReason INVALID_ACCOUNT_NUMBER | INSUFFICIENT_ACCOUNT_BALANCE;

type AccountMgtErrorDetail record {|
    string message?;
    error cause?;
    int time;
    string account;
|};

type AccountMgtError error<AccountMgtErrorReason, AccountMgtErrorDetail>;

type AccountManagement object {

    private map<decimal> accounts = { AC1: 1500.0, AC2: 2550.0 };

    public function getAccountBalance(string accountNumber) returns decimal|error {
        decimal? result = self.accounts[accountNumber];
        if (result is decimal) {
            return result;
        } else {
            return error(INVALID_ACCOUNT_NUMBER, time = time:currentTime().time, 
                         account = accountNumber);
        }
    }

    public function debitAccount(string accountNumber, decimal amount) returns AccountMgtError? {
        decimal? result = self.accounts[accountNumber];
        if (result is decimal) {
            decimal balance = result - amount;
            if (balance < 0.0) {
                return error(INSUFFICIENT_ACCOUNT_BALANCE, time = time:currentTime().time,
                             account = accountNumber);
            } else {
                self.accounts[accountNumber] = balance;
            }
        } else {
            return error(INVALID_ACCOUNT_NUMBER, time = time:currentTime().time, 
                         account = accountNumber);
        }
    }

    public function creditAccount(string accountNumber, decimal amount) returns AccountMgtError? {
        decimal? result = self.accounts[accountNumber];
        if (result is decimal) {
            self.accounts[accountNumber] = result + amount;
        } else {
            return error(INVALID_ACCOUNT_NUMBER, time = time:currentTime().time,
                         account = accountNumber);
        }
    }

};

public function main() {
    AccountManagement am = new;
    decimal|error r1 = am.getAccountBalance("AC1");
    decimal|error r2 = am.getAccountBalance("AC2");
    decimal|error r3 = am.getAccountBalance("AC3");
    io:println(r1);
    io:println(r2);
    io:println(r3);
    error? err = am.debitAccount("AC1", 1000);
    if (err is error) {
        io:println("Error: ", err);
    }
    err = am.creditAccount("AC2", 1000);
    if (err is error) {
        io:println("Error: ", err);
    }
    io:println(am.getAccountBalance("AC1"));
    io:println(am.getAccountBalance("AC2"));
    err = am.debitAccount("AC1", 1000);
    if (err is error) {
        io:println("Error: ", err);
    }
}
