#include <stdio.h>
#include <stdlib.h>
#include <cjson/cJSON.h>

char* read_file(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Could not open file %s\n", filename);
        return NULL;
    }

    // Get file size
    fseek(file, 0, SEEK_END);
    long length = ftell(file);
    fseek(file, 0, SEEK_SET);

    // Allocate buffer for file contents
    char* buffer = (char*)malloc(length + 1);
    if (!buffer) {
        fclose(file);
        fprintf(stderr, "Memory allocation failed\n");
        return NULL;
    }

    // Read file into buffer
    fread(buffer, 1, length, file);
    buffer[length] = '\0'; // Null-terminate the string
    fclose(file);
    return buffer;
}

int main() {
    // Read JSON file
    const char* filename = "example.json";
    char* json_string = read_file(filename);
    if (!json_string) {
        return 1;
    }

    // Parse JSON string into cJSON object
    cJSON* json = cJSON_Parse(json_string);
    if (!json) {
        fprintf(stderr, "Error parsing JSON: %s\n", cJSON_GetErrorPtr());
        free(json_string);
        return 1;
    }

    // Now `json` holds the parsed JSON data
    // Example: Print the JSON structure
    char* printed_json = cJSON_Print(json);
    printf("Parsed JSON:\n%s\n", printed_json);

    // Clean up
    free(printed_json);
    cJSON_Delete(json);
    free(json_string);

    return 0;
}