#include <jansson.h>
#include <stdio.h>


int main(int argc, char *argv[]) {

    json_t *root;
    json_error_t error;
    const char *json_string = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}";

    root = json_loads(json_string, 0, &error);
    if (!root) {
        fprintf(stderr, "ERROR: %s\n", error.text);
        fprintf(stderr, "Error while parsing JSON(%d): %s\n", error.line, error.text);
        return 1;
    }

    if (json_is_object(root)) {
        json_t *name = json_object_get(root, "name");
        if (json_is_string(name)) {
            printf("Name: %s\n", json_string_value(name));
        }
    }
    json_decref(root);

    return 0;
}