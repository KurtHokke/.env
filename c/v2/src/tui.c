#include "utils.h"
#include <ncurses.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <unistd.h>
#include <locale.h>

#define DELAY 3000000

void cleanup_tui(WINDOW *mainwin)
{
    delwin(mainwin);
    endwin();
}

void ncurses_tui(WINDOW *mainwin)
{
    setlocale(LC_ALL, "");
    
    int max_y = 0, 
        max_x = 0;
    initscr();
    noecho();
    cbreak();
    keypad(stdscr, TRUE);
    curs_set(false);
    getmaxyx(stdscr, max_y, max_x);

    mainwin = newwin(max_y, max_x, 0, 0);

    start_color();
    init_pair(ORDER, 39, 0);
    init_pair(CHAOS, 197, 0);
    init_pair(GREEN_GOLD, 40, 0);
    init_pair(RED_GOLD, 196, 0);

    cchar_t vline;
    cchar_t hline;

    cchar_t rucorner;
    cchar_t rbcorner;
    cchar_t lucorner;
    cchar_t lbcorner;

    setcchar(&vline, L"┃", A_NORMAL, 1, NULL);
    setcchar(&hline, L"━", A_NORMAL, 1, NULL);

    setcchar(&rucorner, L"┓", A_NORMAL, 1, NULL);
    setcchar(&rbcorner, L"┛", A_NORMAL, 1, NULL);
    setcchar(&lucorner, L"┏", A_NORMAL, 1, NULL);
    setcchar(&lbcorner, L"┗", A_NORMAL, 1, NULL);

    wclear(mainwin);
    //mvwprintw(mainwin, 24, 10, "%d %d %d %d %d", max_y, max_x, y, x, hlinelen);
    wrefresh(mainwin);
    /*
    redraw_screen(mainwin);
    int ch;
    while ((ch = wgetch(mainwin)) != 'q') {
        if (ch == KEY_RESIZE) {
            // Update ncurses internal state
            endwin();
            refresh();

            // Resize the window to match new dimensions
            wresize(mainwin, LINES, COLS);
            wclear(mainwin);
            // Redraw the screen
            redraw_screen(mainwin);
        }
        // Handle other keys if needed
    }
    */
}

void redraw_screen(WINDOW *mainwin)
{
    int max_y = 0,
        max_x = 0;
    int y = 0,
        x = 0;
    getmaxyx(mainwin, max_y, max_x);
    x = max_x / 2;
    y = max_y / 2;
    box(mainwin, 0, 0);
    char *names[2][5] = { {"Fiora", "Shaco", "Zed", "Jinx", "Braum"}, {"Aatrox", "Nidalee", "Fizz", "Miss Fortune", "Sona"} };
    int gold[2][5] = {{100, 200, 300, 400, 500}, {500, 400, 300, 200, 100}};
    uint8_t longestNamePair = 0;
    for (size_t i = 0; i < 5; i++) 
    {
        longestNamePair = ((longestNamePair == 0) || (longestNamePair < strlen(names[0][i]) + strlen(names[1][i])))? 
                          strlen(names[0][i]) + strlen(names[1][i]) : longestNamePair;
        //printf("%ld: %d\n", i, longestNamePair);
    }
    uint16_t hlinelen = (float)x / (float)2.5 + (float)longestNamePair;
    u_int8_t hlineStart = x - (hlinelen + 2) / 2;
    u_int8_t hlineEnd   = hlineStart + hlinelen + 1;
    u_int8_t tophline   = y - 6;
    u_int8_t vlineStart = tophline + 1;
    
    for (size_t i = 0, j = 1; i < 5; i++, j += 2)
    {
        wattron(mainwin, WA_BOLD);

        wattron(mainwin, COLOR_PAIR(ORDER));
        mvwprintw(mainwin, tophline + j, x - 5 - strlen(names[0][i]), "%s", names[0][i]);
        wattroff(mainwin, COLOR_PAIR(ORDER));

        wattron(mainwin, COLOR_PAIR(CHAOS));
        mvwprintw(mainwin, tophline + j, x + 4, "%s", names[1][i]);
        wattroff(mainwin, COLOR_PAIR(CHAOS));
    
        wattroff(mainwin, WA_BOLD);

        char goldstr[7];
        snprintf(goldstr, sizeof(goldstr), "%d", gold[0][i] - gold[1][i]);
        int goldstrlen = strlen(goldstr);
        (gold[0][i] >= gold[1][i])? wattron(mainwin, COLOR_PAIR(GREEN_GOLD)) : wattron(mainwin, COLOR_PAIR(RED_GOLD));
        mvwprintw(mainwin, tophline + j, (goldstrlen % 2 == 0)? x - goldstrlen / 2 - 1 : x - (goldstrlen - 1) / 2 - 1, "%s", goldstr);
        (gold[0][i] >= gold[1][i])? wattroff(mainwin, COLOR_PAIR(GREEN_GOLD)) : wattroff(mainwin, COLOR_PAIR(RED_GOLD));
        //mvwprintw(mainwin, tophline + j, hlineEnd - strlen(names[1][i]), "%s", names[1][i]);
    }
    wrefresh(mainwin);
}

    /*
    mvwadd_wch(mainwin, tophline, hlineStart, &lucorner); 
    mvwhline_set(mainwin, tophline, hlineStart + 1, &hline, hlinelen);
    mvwadd_wch(mainwin, tophline, hlineEnd, &rucorner);

    mvwadd_wch(mainwin, tophline + 10, hlineStart, &lbcorner); 
    mvwhline_set(mainwin, tophline + 10, hlineStart + 1, &hline, hlinelen);
    mvwadd_wch(mainwin, tophline + 10, hlineEnd, &rbcorner);

    mvwvline_set(mainwin, vlineStart, hlineStart, &vline, 9);
    mvwvline_set(mainwin, vlineStart, hlineEnd, &vline, 9);
    */