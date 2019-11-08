import ballerina/io;
import ballerina/time;

const INVALID_ACCOUNT_NUMBER = "INVALID_ACCOUNT_NUMBER";
const INSUFFICIENT_ACCOUNT_BALANCE = "INSUFFICIENT_ACCOUNT_BALANCE";

type AccountMgtErrorReason INVALID_ACCOUNT_NUMBER | 
                           INSUFFICIENT_ACCOUNT_BALANCE;

type AccountMgtErrorDetail record {|
    string message?;
    error cause?;
    int time;
    string account;
|};

type AccountMgtError error<AccountMgtErrorReason, 
                           AccountMgtErrorDetail>;

public type AccountManagement object {

    private map<decimal> accounts = { AC1: 1500.0, AC2: 2550.0 };

    public function getAccountBalance(string accountNumber) 
                                      returns decimal|error {
        decimal? result = self.accounts[accountNumber];
        if (result is decimal) {
            return result;
        } else {
            return error(INVALID_ACCOUNT_NUMBER, 
                         time = time:currentTime().time, 
                         account = accountNumber);
        }
    }

    public function debitAccount(string accountNumber, decimal amount) 
                                 returns AccountMgtError? {
        decimal? result = self.accounts[accountNumber];
        if (result is decimal) {
            decimal balance = result - amount;
            if (balance < 0.0) {
                return error(INSUFFICIENT_ACCOUNT_BALANCE, 
                             time = time:currentTime().time,
                             account = accountNumber);
            } else {
                self.accounts[accountNumber] = balance;
            }
        } else {
            return error(INVALID_ACCOUNT_NUMBER, 
                         time = time:currentTime().time, 
                         account = accountNumber);
        }
    }

    public function creditAccount(string accountNumber, decimal amount) 
                                  returns AccountMgtError? {
        decimal? result = self.accounts[accountNumber];
        if (result is decimal) {
            self.accounts[accountNumber] = result + amount;
        } else {
            return error(INVALID_ACCOUNT_NUMBER, 
                         time = time:currentTime().time,
                         account = accountNumber);
        }
    }

};

type OnlineBanking object {

    private AccountManagement accountMgt;

    public function __init(AccountManagement accountMgt) {
        self.accountMgt = accountMgt;
    }

    public function lookupAccountBalance(string accountNumber) 
                                         returns decimal|error {
        return self.accountMgt.getAccountBalance(accountNumber);
    }

    public function transferMoney(string sourceAccount, 
                                  string targetAccount, 
                                  decimal amount) returns error? {
        AccountMgtError? err = self.accountMgt.debitAccount(
                                  sourceAccount, amount);
        if (err is error) {
            return err;
        }
        err = self.accountMgt.creditAccount(targetAccount, amount);
        if (err is error) {
            return err;
        }
    }

};

public function main() {
    AccountManagement actMgmt = new;
    OnlineBanking onlineBank = new(actMgmt);
    error? err = onlineBank.transferMoney("AC1", "AC2", 500.0);
    if (err is error) {
        io:println("AC1->AC2 Transfer Error: ", err);
    }
    io:println("AC1 Balance: ", onlineBank.lookupAccountBalance("AC1"));
    io:println("AC2 Balance: ", onlineBank.lookupAccountBalance("AC2"));
    err = onlineBank.transferMoney("AC1", "AC2", 1500.0);
    if (err is error) {
        io:println("AC1->AC2 Transfer Error: ", err);
    }
}
