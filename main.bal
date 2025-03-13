import ballerina/http;
import ballerinax/ai.agent;
import ballerina/os;

configurable string apiKey = os:getEnv("API_KEY");
configurable string deploymentId = "gpt4o";
configurable string apiVersion = "2023-07-01-preview";
configurable string serviceUrl = "https://ballerina-ai-eastus.openai.azure.com/openai";

final agent:Model model = check new agent:AzureOpenAiModel(serviceUrl, apiKey, deploymentId, apiVersion);
final agent:Agent agent = check new (
    systemPrompt = {
        role: "Math Tutor",
        instructions: "You are a school tutor assistant. " +
        "Provide answers to students' questions so they can compare their answers. " +
        "Use the tools when there is query related to math"
    },
    model = model,
    tools = [sum, mult, sqrt],
    verbose = true
);

@agent:Tool
isolated function sum(decimal a, decimal b) returns decimal => a + b;

@agent:Tool
isolated function mult(decimal a, decimal b) returns decimal => a * b;

@agent:Tool
isolated function sqrt(float a) returns float => a.sqrt();

service on new agent:Listener(9090) {
    resource function post chat(@http:Payload agent:ChatReqMessage request) returns agent:ChatRespMessage|error {
        string response = check agent->run(request.message, memoryId = request.sessionId);
        return {message: response};
    }
}
