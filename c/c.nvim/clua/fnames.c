#include <dirent.h>
#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>


static int l_fnames(lua_State *L)
{
  const char *path = luaL_checkstring(L, 1);
  DIR *dir = opendir(path);
  if (dir == NULL) {
    lua_pushfstring(L, "failed to open %s", path);
    return -1;
  }
  int i = 1;
  lua_newtable(L);
  struct dirent *entry;
  while ((entry = readdir(dir)) != NULL) {
    if (entry->d_name[0] == '.') {
      if (entry->d_name[1] == '\0') continue;
      if (entry->d_name[1] == '.' && entry->d_name[2] == '\0') continue;
    }
      lua_pushinteger(L, i);
      lua_pushfstring(L, "%s", entry->d_name);
      lua_settable(L, -3);
      i++;
  }
  closedir(dir);
  return 1;
}

static const struct luaL_Reg fnames[] = {
    {"fnames", l_fnames},
    {NULL, NULL} // Sentinel
};

int luaopen_fnames(lua_State *L) {
    luaL_openlib(L, "fnames", fnames, 0); // Register functions in global table 'mylib'
    return 1;                           // Return the table
}
