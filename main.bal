import ballerina/http;
import ballerinax/ai.agent;

// configurable string apiKey = ?;
// configurable string deploymentId = ?;
// configurable string apiVersion = ?;
// configurable string serviceUrl = ?;

// final agent:Model model = check new agent:AzureOpenAiModel(serviceUrl, apiKey, deploymentId, apiVersion);
// final agent:Agent agent = check new (
//     systemPrompt = {
//         role: "Math Tutor",
//         instructions: "You are a school tutor assistant. " +
//         "Provide answers to students' questions so they can compare their answers. " +
//         "Use the tools when there is query related to math"
//     },
//     model = model,
//     tools = [sum, mult, sqrt],
//     verbose = true
// );

// @agent:Tool
// isolated function sum(decimal a, decimal b) returns decimal => a + b;

// @agent:Tool
// isolated function mult(decimal a, decimal b) returns decimal => a * b;

// @agent:Tool
// isolated function sqrt(float a) returns float => a.sqrt();

service /mychat on new agent:Listener(9090) {
    resource function post chat(@http:Payload agent:ChatReqMessage request) returns agent:ChatRespMessage|error {
        // string response = check agent->run(request.message, memoryId = request.sessionId);
        return {message: request.message.toUpperAscii()};
    }
}
