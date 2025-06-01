#include <ncurses.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <locale.h>
#include <stdlib.h>
#include <sys/types.h>

#define THSND_DIVBY255 3.92156862745

enum wsedrf_KEYS {
  Rp = 119,
  Rm = 115,
  Gp = 101,
  Gm = 100,
  Bp = 114,
  Bm = 102,
  SPACE = 32,
  COPY_TO_CLIPBOARD = 121,
  SHOULD_EXIT = 113
};

void make_color(unsigned int rgb[2][3])
{
  for (int i = 0; i < 3; i++)
  {
    if (rgb[0][i] == 255) {
      rgb[1][i] = 1000;
    } else {
      rgb[1][i] = (double)rgb[0][i] * THSND_DIVBY255;
    }
    refresh();
  }
}

void call_syscopy(unsigned int rgb[2][3])
{
  char command[100];
  snprintf(command, sizeof(command), "printf \"#%.02x%.02x%.02x\" | wl-copy", rgb[0][0], rgb[0][1], rgb[0][2]);
  system(command);
}

int main(void)
{
  unsigned int rgb[2][3] = {{125, 125, 125}, {490, 490, 490}};
  // unsigned int f_rgb[3] = {0, 0, 0};
  setlocale(LC_ALL, "");
  initscr();
  noecho();
  cbreak();
  keypad(stdscr, TRUE);
  curs_set(FALSE);
   
  start_color();
  init_pair(20, COLOR_WHITE, COLOR_BLACK);
  refresh();
  int c;
  
  int max_x = 0,
      max_y = 0;
  int x = 0,
      y = 0;

  // unsigned int add = 1;
  u_int8_t add = 1;
  bool should_exit = false;

  while(!should_exit) {
    c = getch();
    getmaxyx(stdscr, max_y, max_x);
    x = max_x / 2;
    y = max_y / 2;
    // printw("%d\n", c);
    // getch();
    switch (c) {
      case COPY_TO_CLIPBOARD:
        call_syscopy(rgb);
        break;
      case SPACE:
        add = (add == 1)? 5 : 1;
        break;
      case Rp:
        rgb[0][0] = ((rgb[0][0] < 255) && (add == 1 || rgb[0][0] <= 250))? rgb[0][0] + add : 255;
        break;
      case Rm:
        rgb[0][0] = ((rgb[0][0] > 0) && (add == 1 || rgb[0][0] >= 5))? rgb[0][0] - add : 0;
        break;
      case Gp:
        rgb[0][1] = ((rgb[0][1] < 255) && (add == 1 || rgb[0][1] <= 250))? rgb[0][1] + add : 255;
        break;
      case Gm:
        rgb[0][1] = ((rgb[0][1] > 0) && (add == 1 || rgb[0][1] >= 5))? rgb[0][1] - add : 0;
        break;
      case Bp:
        rgb[0][2] = ((rgb[0][2] < 255) && (add == 1 || rgb[0][2] <= 250))? rgb[0][2] + add : 255;
        break;
      case Bm:
        rgb[0][2] = ((rgb[0][2] > 0) && (add == 1 || rgb[0][2] >= 5))? rgb[0][2] - add : 0;
        break;
      case SHOULD_EXIT:
        should_exit = true;
        break;
      default:
        break;
    }
    clear();
    make_color(rgb);
    init_color(100, rgb[1][0], rgb[1][1], rgb[1][2]);
    init_pair(10, 0, 100);
    wbkgd(stdscr, COLOR_PAIR(10));
    clear();
    refresh();
    attron(COLOR_PAIR(20));
    mvprintw(y - 1, x - 5, "#%.02x%.02x%.02x", rgb[0][0], rgb[0][1], rgb[0][2]);
    mvprintw(y + 2, x - 2, "X%d", add);
    refresh();
    attroff(COLOR_PAIR(20));
    // for (int i = 0; i < 3; i++)
    // {
    //   mvprintw(10 + i, 10, "%d", rgb[0][i]);
    //   mvprintw(10 + i, 15, "%d", rgb[1][i]);
    //   refresh();
    // }
    // printw("%d\n", rgb[0]);
    // printw("%d\n", rgb[1]);
    // printw("%d\n", rgb[2]);
    // refresh();
  }
  endwin();
  return 0;
  // init_color(100, (int)xcol, 0, 0);
  // init_color(99, 0, 500, 0);
  // init_pair(10, 0, 100);
  // init_pair(11, 0, 99);
  // wbkgd(stdscr, COLOR_PAIR(10));
  // clear();
  // refresh();
  // attron(COLOR_PAIR(10));
  // mvprintw(10, 10, "Hello");
  // attroff(COLOR_PAIR(10));
  
  // getch(); 
  //
  // wbkgd(stdscr, COLOR_PAIR(11));
  // clear();
  // refresh();
  // getch(); 
  // refresh();
  // endwin();
  // return 0;
}
