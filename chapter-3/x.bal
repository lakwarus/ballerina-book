import ballerina/io;

const float PI = 3.1415;

    type IO_ERROR "IO_ERROR";

function sendSMS () returns error? {

xml payload = xml `<soapenv:Envelope xmlns:soapenv="http://govsms.icta.lk/"><soapenv:Header>
<govsms:authData xmlns:govsms="http://govsms.icta.lk/"><govsms:user>icta</govsms:user>
<govsms:key>g0v5ms123</govsms:key></govsms:authData></soapenv:Header>
<soapenv:Body>
<v1:SMSRequest xmlns:v1="http://govsms.icta.lk/">
<v1:requestData>
<v1:outSms>Testing testing testing fubar</v1:outSms>
<v1:recepient>94715910955</v1:recepient>
<v1:depCode>PRE2019</v1:depCode>
<v1:smscId/>
<v1:billable/>
</v1:requestData>
</v1:SMSRequest>
</soapenv:Body></soapenv:Envelope>`;

http:Client hc = new ("https://gsms.lgcc.gov.lk:9443/services/GovSMSMTHandlerProxy");
http:Response res = check hc->post ("/", payload);
io:println("Status = " + res.statusCode.toString());
}

public function main() {

    int? score = ();
    int finalScore = score?:0;
    io:println(finalScore);
}