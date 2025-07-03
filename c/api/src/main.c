#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp) {
  size_t realsize = size * nmemb;
  printf("%.*s", (int)realsize, (char *)contents); // Print response to stdout
  return realsize;
}

int main(void)
{
  CURL *curl;
  CURLcode res;
  struct curl_slist *headers = NULL;

  curl_global_init(CURL_GLOBAL_DEFAULT);
  curl = curl_easy_init();
  if (!curl) {
    printf("curl init failed\n");
    return 1;
  }

  const char *api_key = getenv("OPENAI_API_KEY");
  const char *project_id = getenv("OPENAI_PROJECT_ID");
  if (!api_key || !project_id) {
    printf("Environment variables OPENAI_API_KEY and PROJECT_ID must be set\n");
    curl_easy_cleanup(curl);
    curl_global_cleanup();
    return 1;
  }

  // Construct the Authorization header
  char auth_header[256];
  snprintf(auth_header, sizeof(auth_header), "Authorization: Bearer %s", api_key);

  // Construct the OpenAI-Project header
  // char project_header[256];
  // snprintf(project_header, sizeof(project_header), "OpenAI-Project: %s", project_id);

  // Set the headers
  headers = curl_slist_append(headers, auth_header);
  // headers = curl_slist_append(headers, "OpenAI-Organization: org-6iiyCBEiYxztovvRBgi1XBSY");
  // headers = curl_slist_append(headers, project_header);
  headers = curl_slist_append(headers, "Content-Type: application/json");
  // JSON payload
  const char *json_payload = "{\"model\": \"gpt-4.1\", \"input\": \"Tell me a three sentence bedtime story about a unicorn.\"}";

  // Set up the curl request
  curl_easy_setopt(curl, CURLOPT_URL, "https://api.openai.com/v1/models");
  curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
  curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
  // Perform the request
  res = curl_easy_perform(curl);
  if (res != CURLE_OK) {
    printf("curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
  }
  // Clean up
  curl_slist_free_all(headers);
  curl_easy_cleanup(curl);
  curl_global_cleanup();
  return res == CURLE_OK ? 0 : 1;
}
