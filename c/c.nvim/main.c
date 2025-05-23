#include <ncurses.h>
#include <stdio.h>
#include <stdbool.h>
#include <locale.h>

#define THSND_DIVBY255 3.92156862745

enum wsedrf_KEYS {
  Rp = 119,
  Rm = 115,
  Gp = 101,
  Gm = 100,
  Bp = 114,
  Bm = 102,
  SPACE = 32,
  SHOULD_EXIT = 113
};


unsigned int *make_color(unsigned int rgb[])
{
  float f_rgb[3] = {0,0,0};
  for (int i = 0; i < 3; i++)
  {
    if (rgb[i] == 255) {
      f_rgb[i] == 1000;
    } else {
      f_rgb[i] = (float)rgb[i] * THSND_DIVBY255;
    }
    mvprintw(10 + i, 10, "%f", f_rgb[i]);
    refresh();
  }
  return (unsigned int*)f_rgb;
}

int main(void)
{
  unsigned int rgb[3] = {127, 127, 127};
  unsigned int f_rgb[3] = {0, 0, 0};
  setlocale(LC_ALL, "");
  initscr();
  noecho();
  cbreak();
  keypad(stdscr, TRUE);
  curs_set(FALSE);
   
  start_color();
  refresh();
  int c;
  unsigned int add = 1;
  bool should_exit = false;
  while(!should_exit) {
    c = getch();
    // printw("%d\n", c);
    // getch();
    switch (c) {
      case SPACE:
        add = (add == 1)? 5 : 1;
        break;
      case Rp:
        rgb[0] = ((rgb[0] < 255) && (add == 1 || rgb[0] <= 250))? rgb[0] + add : 255;
        break;
      case Rm:
        rgb[0] = ((rgb[0] > 0) && (add == 1 || rgb[0] >= 5))? rgb[0] - add : 0;
        break;
      case Gp:
        rgb[1] = ((rgb[1] < 255) && (add == 1 || rgb[1] <= 250))? rgb[1] + add : 255;
        break;
      case Gm:
        rgb[1] = ((rgb[1] > 0) && (add == 1 || rgb[1] >= 5))? rgb[1] - add : 0;
        break;
      case Bp:
        rgb[2] = ((rgb[2] < 255) && (add == 1 || rgb[2] <= 250))? rgb[2] + add : 255;
        break;
      case Bm:
        rgb[2] = ((rgb[2] > 0) && (add == 1 || rgb[2] >= 5))? rgb[2] - add : 0;
        break;
      case SHOULD_EXIT:
        should_exit = true;
        break;
      default:
        break;
    }
    clear();
    f_rgb = *make_color(rgb);
    for (int i = 0; i < 3; i++)
    {
      mvprintw(10 + i, 10, "%d", rgb[i]);
      refresh();
    }
    // printw("%d\n", rgb[0]);
    // printw("%d\n", rgb[1]);
    // printw("%d\n", rgb[2]);
    refresh();
  }
  endwin();
  return 0;
  // init_color(100, (int)xcol, 0, 0);
  init_color(99, 0, 500, 0);
  init_pair(10, 0, 100);
  init_pair(11, 0, 99);
  wbkgd(stdscr, COLOR_PAIR(10));
  clear();
  refresh();
  // attron(COLOR_PAIR(10));
  // mvprintw(10, 10, "Hello");
  // attroff(COLOR_PAIR(10));
  
  getch(); 
  
  wbkgd(stdscr, COLOR_PAIR(11));
  clear();
  refresh();
  getch(); 
  refresh();
  endwin();
  return 0;
}
