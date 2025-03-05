import ballerina/http;
import ballerina/lang.runtime;

public type ChatRequest record {|
    string chat_instance_id;
    string chat_message;
|};

public type ChatResponse record {|
    string response_message;
|};

public type Service distinct service object {
    *http:Service;

    resource function post chat(ChatRequest chatRequest) returns ChatResponse;
};

service / on new http:Listener(9090) {

    resource function post chat(@http:Payload ChatRequest chatRequest) returns ChatResponse {
        runtime:sleep(2);
        ChatResponse response = {
            response_message: chatRequest.chat_message.toUpperAscii()
        };
        return response;
    }
}


