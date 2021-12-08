//usr/bin/env cc -std=c99 -O3 "$0" && exec ./a.out < dec04.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NNUMS 100
#define BUFSIZE NNUMS * 3 + 1
#define NGRIDS 100
#define ROW "%2" SCNu8 " %2" SCNu8 " %2" SCNu8 " %2" SCNu8 " %2" SCNu8 "\n"
#define NMASKS 10
#define MASKS 31, 992, 31744, 1015808, 32505856,  \
    17318416, 8659208, 4329604, 2164802, 1082401

struct Game {
  uint8_t  numbers[NNUMS];
  uint8_t  grids[NGRIDS * 25];
  uint32_t marked[NNUMS];
  size_t   iwinnro;
  size_t   iwingrid;
};

typedef struct Game Game;

Game new_game(void)
{
  Game game = {{0},{0},{0}, SIZE_MAX, SIZE_MAX};

  char line[BUFSIZE] = {0};
  char *ptr = line;
  fgets(line, BUFSIZE, stdin);
  for (size_t i = 0; i < NNUMS; i++)
    {
      game.numbers[i] = (uint8_t) strtol(ptr, &ptr, 10);
      ptr++;
    }

  for (int i = 0; i < NGRIDS; i++)
    {
      uint8_t *g = &game.grids[i * 25];
      fscanf(stdin, "\n");
      for (int j = 0; j < 25; j += 5)
        fscanf(stdin, ROW, &g[j], &g[j+1], &g[j+2], &g[j+3], &g[j+4]);
    }

  return(game);
}

void print_game(Game game)
{
  for (size_t i = 0; i < NNUMS - 1; i++)
    printf("%d,", game.numbers[i]);
  printf("%d\n", game.numbers[NNUMS - 1]);

  for (int i = 0; i < NGRIDS; i++)
    {
      uint8_t *g = &game.grids[i * 25];
      printf("\n");
      for (int j = 0; j < 25; j += 5)
        printf(ROW, g[j], g[j+1], g[j+2], g[j+3], g[j+4]);
    }
}

void reset(Game *game)
{
  game->iwinnro = game->iwingrid = SIZE_MAX;
  memset(game->marked, 0, sizeof(game->marked));
}

void play_to_first(Game *game)
{
  reset(game);
  const uint32_t masks[NMASKS] = {MASKS};
  for (uint8_t n = 0; n < NNUMS; n++)
    {
      for (size_t i = 0; i < NGRIDS * 25; i++)
        if (game->numbers[n] == game->grids[i])
          {
            game->marked[i/25] |= 1 << (i % 25);
          }
      for (size_t i = 0; i < NGRIDS; i++)
        for (size_t j = 0; j < NMASKS; j++)
          if ((game->marked[i] & masks[j]) == masks[j])
            {
              game->iwinnro = n;
              game->iwingrid = i;
              goto bingo;
            }
    }
  exit(1);
 bingo: return;
}

void play_to_last(Game *game)
{
  reset(game);
  const uint32_t masks[NMASKS] = {MASKS};
  int c = 0, skip[NGRIDS] = {0};
  for (uint8_t n = 0; n < NNUMS; n++)
    {
      for (size_t i = 0; i < NGRIDS * 25; i++)
        {
          if (skip[i/25]) continue;
          if (game->numbers[n] == game->grids[i])
            game->marked[i/25] |= 1 << (i % 25);
        }
      for (size_t i = 0; i < NGRIDS; i++)
        {
          if (skip[i]) continue;
          for (size_t j = 0; j < NMASKS; j++)
            if ((game->marked[i] & masks[j]) == masks[j])
              {
                game->iwinnro = n;
                game->iwingrid = i;
                skip[i] = 1;
                if (c++ == NGRIDS - 1) goto lastbingo;
                break;
              }
        }
    }
  exit(1);
 lastbingo: return;
}

uint64_t score(Game game)
{
  uint64_t s = 0;
  for (size_t i = 0; i < 25; i++)
    if (!(game.marked[game.iwingrid] & (1 << i)))
      s += game.grids[i + 25 * game.iwingrid];
  return((uint64_t) game.numbers[game.iwinnro] * s);
}

int main(int argc, char *argv[])
{
  Game bingo = new_game();
  play_to_first(&bingo);
  printf("%" PRIu64 "\n", score(bingo));
  play_to_last(&bingo);
  printf("%" PRIu64 "\n", score(bingo));


  return(0);
}
