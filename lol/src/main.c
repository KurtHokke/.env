#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>
#include <cjson/cJSON.h>

#define TEAM_SIZE 10

// Structure to hold response data
struct Memory {
    char *data;
    size_t size;
};

const char *positionNames[] = {
    "TOP",
    "JUNGLE",
    "MIDDLE",
    "BOTTOM",
    "UTILITY"
};

double goldstats[] = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
};

// Callback function to collect response data
static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp);
int exitprint(int code, char *msg);
char *create_champData(void);

int write_to_file(char *path, char *text) {
    FILE *file = fopen(path, "w");
    fprintf(file, "%s", text);
    fclose(file);
    return 0;
}


int do_curl(char **curl_response) {
    CURL *curl;
    CURLcode res;
    struct Memory response = {0};

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();
    if (!curl) {
        fprintf(stderr, "curl_easy_init() Failed");
        curl_global_cleanup();
        return 1;
    }
    curl_easy_setopt(curl, CURLOPT_URL, "http://127.0.0.1:2999/liveclientdata/allgamedata");
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

    res = curl_easy_perform(curl);
    if (res != CURLE_OK) {
        fprintf(stderr, "curl_easy_perform() Failed: %s\n", curl_easy_strerror(res));
        curl_easy_cleanup(curl);
        curl_global_cleanup();
        free(response.data); // Free in case of error
        return 1;
    }

    *curl_response = response.data;

    // Clean up
    curl_easy_cleanup(curl);
    curl_global_cleanup();
    return 0;
}

CJSON_PUBLIC(cJSON*) get_obj(cJSON * const data, const char * const item) {
    cJSON *obj = NULL;
    if (cJSON_HasObjectItem(data, item)) { 
        obj = cJSON_GetObjectItemCaseSensitive(data, item);
    }
    return obj;
}

int main(int argc, char *argv[]){
    
    int i;
    char *curl_response = NULL;
    FILE *champDataFile;

    if (argc >= 2) {
        if (strcmp(argv[1], "champData") == 0) {
            cJSON *champData = cJSON_Parse(create_champData());
            char *pretty = cJSON_Print(champData);
            return write_to_file("../debug/champData.json", pretty);
        } else if (strcmp(argv[1], "test") == 0) {
            goldstats[0] = 15;
            goldstats[6] = 142;
            for (i = 0; i < TEAM_SIZE; i++) {
                printf("%d: %.f\n", i + 1, goldstats[i]);
            }
            return 0;
        } else if (strcmp(argv[1], "aplayer") == 0) {

            if (do_curl(&curl_response) == 1) {
                return 1;
            }
            cJSON *data = cJSON_Parse(curl_response);
            free(curl_response);
            cJSON *player = NULL;
            if (argc < 3) return 1;
            cJSON *activeplayer = get_obj(data, argv[2]);
            if (activeplayer == NULL) {
                return 1;
            } else {
                printf("yesss\n");
                return 0;
            }
            return 0;
        }
    }
    if (do_curl(&curl_response) == 1) {
        return 1;
    }
    cJSON *data = cJSON_Parse(curl_response);
    free(curl_response);
    if (data == NULL) {
        const char *error_ptr = cJSON_GetErrorPtr();
        if (error_ptr != NULL) {
            fprintf(stderr, "Error before: %s\n", error_ptr);
            return 1;
        }
    }

    cJSON *allPlayers = NULL;
    allPlayers = cJSON_GetObjectItemCaseSensitive(data, "allPlayers");

    cJSON *nextPlayer = allPlayers->child;
    champDataFile = fopen("../debug/champData.json", "w");
    for (i = 0; i < TEAM_SIZE && nextPlayer; i++) {

        double totalprice = 0;
        cJSON *items = cJSON_GetObjectItemCaseSensitive(nextPlayer, "items");
        cJSON *nextitem = items->child;
        do {
            cJSON *priceitem = cJSON_GetObjectItemCaseSensitive(nextitem, "price");

            if (priceitem->type == cJSON_Number) {
                //price = priceitem->valuedouble;
                totalprice += priceitem->valuedouble;
            } else {
                printf("type was not of number\n");
            }
        } while ((nextitem = nextitem->next) != NULL);
        goldstats[i] = totalprice;

        cJSON *team = cJSON_GetObjectItemCaseSensitive(nextPlayer, "team");
        cJSON *position = cJSON_GetObjectItemCaseSensitive(nextPlayer, "position");
        cJSON *champion = cJSON_GetObjectItemCaseSensitive(nextPlayer, "championName");
        char *teamName = team->valuestring;
        char *positionName = position->valuestring;
        char *championName = champion->valuestring;

        char displaystats[150];
        snprintf(displaystats, sizeof(displaystats), "%s  %s\t\t%s\t\t%.f", teamName, positionName, championName, totalprice);
        printf("%s\n", displaystats);

        nextPlayer = nextPlayer->next;
    }


    return 0;
}


int exitprint(int code, char *msg) {
    printf("%s\n", msg);
    return code;
}

// Callback function to collect response data
static size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp) {
    size_t realsize = size * nmemb;
    struct Memory *mem = (struct Memory *)userp;

    // Reallocate memory to fit new data
    char *ptr = realloc(mem->data, mem->size + realsize + 1);
    if (!ptr) {
        fprintf(stderr, "realloc() failed\n");
        return 0;
    }

    mem->data = ptr;
    memcpy(&(mem->data[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->data[mem->size] = 0; // Null-terminate

    return realsize;
}

char *create_champData(void) {
    char *string = NULL;
    cJSON *positions = NULL;
    cJSON *position = NULL;
    cJSON *order = NULL;
    cJSON *chaos = NULL;

    cJSON *champData = cJSON_CreateObject();
    if (champData == NULL) {
        return "null1";
    }
    order = cJSON_CreateArray();
    chaos = cJSON_CreateArray();
    if (order == NULL || chaos == NULL) {
        return "null2";
    }

    for (int i = 0; i < 5; i++) {
        cJSON *gold = cJSON_CreateObject();
        cJSON_AddNumberToObject(gold, positionNames[i], 0);
        cJSON_AddItemToArray(order, cJSON_Duplicate(gold, 1));
        cJSON_AddItemToArray(chaos, gold);
    }

    cJSON_AddItemToObject(champData, "order", order);
    cJSON_AddItemToObject(champData, "chaos", chaos);

    string = cJSON_Print(champData);
    if (string == NULL) {
        return "null";
    }
    cJSON_Delete(champData);
    return string;
}
