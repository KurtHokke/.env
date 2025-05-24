#include <stdio.h>
#include <stdlib.h>

void copy_to_clipboard(const char *text) {
    FILE *pipe = popen("xclip -selection clipboard", "w");
    if (!pipe) return;
    
    fputs(text, pipe);
    pclose(pipe);
}

int main(void) {
    const char *text = "Hello, Clipboard!";
    copy_to_clipboard(text);
    return 0;
}
