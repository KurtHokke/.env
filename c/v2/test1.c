
#include <ncurses.h>
#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>

#define DELAY 350000



enum colors {
    ORDER=1,
    CHAOS,
    GREEN_GOLD,
    RED_GOLD
};

int main(void)
{
    WINDOW *mainwin;
    int y = 0, 
        x = 0;
    int max_y = 0, 
        max_x = 0;

    int next_x = 0;

    int direction = 1;

    initscr();
    noecho();
    curs_set(false);
    getmaxyx(stdscr, max_y, max_x);

    x = max_x / 2;
    y = max_y / 2;

    mainwin = newwin(max_y, max_x, 0, 0);

    start_color();
    init_pair(ORDER, 39, 0);
    init_pair(CHAOS, 197, 0);
    init_pair(GREEN_GOLD, 40, 0);
    init_pair(RED_GOLD, 196, 0);
    //init_pair(3, 13, 0);

    //wcolor_set(mainwin, 1, NULL);
    wrefresh(mainwin);
    while (1) {
        getmaxyx(mainwin, max_y, max_x);

        y = max_y / 2;

        wclear(mainwin);
        //mvprintw(y, x, "o");
        box(mainwin, 0, 0);
        wattron(mainwin, COLOR_PAIR(ORDER));
        mvwprintw(mainwin, 20, 20, "order");
        wattroff(mainwin, COLOR_PAIR(ORDER));
        wattron(mainwin, COLOR_PAIR(CHAOS));
        mvwprintw(mainwin, 22, 20, "chaos");
        wattroff(mainwin, COLOR_PAIR(CHAOS));
        wrefresh(mainwin);

        usleep(DELAY);

  }
    delwin(mainwin);
    endwin();
}
