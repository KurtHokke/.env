#include <X11/Xlib.h>
#include <stdio.h>

int main(void) {
    Display *display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Cannot open display\n");
        return 1;
    }

    // Move mouse to (100, 100) relative to the root window (screen)
    XWarpPointer(display, None, None, 0, 0, 0, 0, 100, 100);
    XFlush(display); // Ensure the command is sent to the X server

    XCloseDisplay(display);
    return 0;
}
