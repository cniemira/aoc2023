#include <stdio.h>
#include <string.h>

//#define FILENAME "07_1_input.txt"
//#define N_HANDS 1000
#define FILENAME "07_1_sample.txt"
#define N_HANDS 5

typedef struct Hand {
  char chars[5];
  int cards[5]; // s/b uint8_t, but why bother
  int bid;
  enum HandType {
    UNSET,          // 0
    HIGH_CARD,      // 1
    ONE_PAIR,       // 2
    TWO_PAIR,       // 3
    THREE_OF_A_KIND,// 4
    FULL_HOUSE,     // 5
    FOUR_OF_A_KIND, // 6
    FIVE_OF_A_KIND  // 7
  } type;
} hand_t;


void show_hand(hand_t *hand) {
    for (int i=0; i<5; i++) {
      printf("%c", hand->chars[i]);
    }
    printf(" ");
    for (int i=0; i<5; i++) {
      printf("%x", hand->cards[i]);
    }
    printf(" %3d (%d)", hand->bid, hand->type);
}


int compare_hands(hand_t *a, hand_t *b) {
  //printf("compare: %d %d ", a->bid, b->bid);
  int a_card;
  int b_card;

  if (a->type > b->type) {
    //printf("a type higher\n");
    return 1;
  }

  if (a->type == b->type) {
    for (int i=0; i<5; i++) {
      a_card = a->cards[i];
      b_card = b->cards[i];
      if (a_card > b_card) {
        //printf("a card higher\n");
        return 1;
      } else if (b_card > a_card) {
        //printf("b card higher\n");
        return -1;
      }
    }
    //printf("SAME HAND!\n");
  }
  //printf("smaller\n");
  return -1;
}


void rank_hands(hand_t *hands) {
  int again = 1;
  hand_t *a;
  hand_t *b;
  hand_t temp;

  for (int i=N_HANDS; again==1; i--) {
    again = 0;
    for (int j=0; j<i-1; j++) {
      a = &hands[j];
      b = &hands[j+1];
      if (compare_hands(a, b) > 0) {
        memcpy(&temp, &hands[j+1], sizeof(hand_t));
        memcpy(&hands[j+1], &hands[j], sizeof(hand_t));
        memcpy(&hands[j], &temp, sizeof(hand_t));
        again = 1;
      }
    }
  }

  /*
  */
}


void type_hand(hand_t *hand) {
  int hist[15] = {0};
  int temp[5];
  int pairs = 0;
  int three = 0;
  int jokers = 0;
  memcpy(&temp, hand->cards, sizeof(int)*5);

  hand->type = 0;
  //show_hand(hand);

  for (int i=0; i<5; i++) {
    hist[temp[i]]++;
  }

  jokers = hist[1];
  //printf(" (j=%d) ", jokers);

  if (jokers == 4) {
    hand->type = FIVE_OF_A_KIND;
    //printf(" 5 of kind w/j\n");
    return;
  }

  for (int i=0; i<15; i++) {
    if (hist[i] > 4) {
      hand->type = FIVE_OF_A_KIND;
      //printf(" 5 of kind\n");
      return;
    } else if (hist[i] > 3) {
      if (jokers > 0) {
        hand->type = FIVE_OF_A_KIND;
        //printf(" 5 of kind w/j\n");
      } else {
        hand->type = FOUR_OF_A_KIND;
        //printf(" 4 of kind\n");
      }
      return;
    } else if (hist[i] > 2) {
      three++;
      //printf(" +3,");
    } else if (hist[i] > 1) {
      pairs++;
      //printf(" +pair,");
    }
  }

  if (pairs > 0) {
    if (pairs > 1) {
      // two pair, not 4J
      if (jokers > 1) {
        // pair j + 1 pair
        hand->type = FOUR_OF_A_KIND;
        //printf(" 4 of kind w/2j\n");
      } else if (jokers == 1) {
        // single j + 2 pair
        hand->type = FULL_HOUSE;
        //printf(" full house w/j\n");
      } else {
        // no j
        hand->type = TWO_PAIR;
        //printf(" 2 pair\n");
      }
    } else if (three) {
      // 1 pair + 3
      if (jokers > 2) {
        // 3j + 1 pair
        hand->type = FIVE_OF_A_KIND;
        //printf(" 5 of kind w/3j\n");
      } else if (jokers > 1) {
        // 3 + 2j
        hand->type = FIVE_OF_A_KIND;
        //printf(" 5 of kind w/2j\n");
      } else if (jokers > 0) {
        // 3 + 1j
        hand->type = FOUR_OF_A_KIND;
        //printf(" 4 of kind w/j\n");
      } else {
        // 0j
        hand->type = FULL_HOUSE;
        //printf(" full house\n");
      }
    } else {
      // 1pair, js or single j
      if (jokers > 1) {
        // pair of jokers
        hand->type = THREE_OF_A_KIND;
        //printf(" 3 of kind w/2j\n");
      } else if (jokers > 0) {
        // 1j + 1pair
        hand->type = THREE_OF_A_KIND;
        //printf(" 3 of kind w/j\n");
      } else {
        hand->type = ONE_PAIR;
        //printf(" 1 pair\n");
      }
    }
    return;
  }

  if (three) {
    if (jokers > 0) {
      hand->type = FOUR_OF_A_KIND;
      //printf(" 4 of kind w/j\n");
    } else {
      hand->type = THREE_OF_A_KIND;
      //printf(" 3 of kind\n");
    }
    return;
  }

  if (jokers > 0) {
      hand->type = ONE_PAIR;
      //printf(" 1 pair w/j\n");
      return;
  }

  hand->type = HIGH_CARD;
  //printf(" high card no j\n");
}


int parse_input(char *filename, hand_t *hands) {
  FILE *fh;
  char c;
  int n = 0;
  int bid[4] = {0};
  int pos = 0;
  int value = 0;

  fh = fopen(filename, "r");
  if (fh) {
    while ((c = getc(fh)) != EOF) {
      switch (c) {
        case 0x0a:
          if (pos == 6) {
            hands[n].bid = bid[0];
          } else if (pos == 7) {
            hands[n].bid = bid[1] + (bid[0] * 10); 
          } else if (pos == 8) {
            hands[n].bid = bid[2] + (bid[1] * 10) + (bid[0] * 100);
          } else {
            hands[n].bid = bid[3] + (bid[2] * 10) + (bid[1] * 100) + (bid[0] * 1000);
          }

          type_hand(&hands[n]);
          //show_hand(&hands[n]);
          //printf("\n");

          n++;
          bid[0] = 0; 
          bid[1] = 0; 
          bid[2] = 0; 
          pos = 0;
          continue;
        case 0x20: // space
          continue;
        case 0x30: // 0
        case 0x31:
        case 0x32:
        case 0x33:
        case 0x34:
        case 0x35:
        case 0x36:
        case 0x37:
        case 0x38:
        case 0x39:
          value = (int)c - 0x30;
          break;
        case 0x54: // T
          value = 10;
          break;
        case 0x4A: // J
          value = 1;
          break;
        case 0x51: // Q
          value = 12;
          break;
        case 0x4B: // K
          value = 13;
          break;
        case 0x41: // A
          value = 14;
          break;
        default:
         break;
      }

      if (pos<5) {
        hands[n].cards[pos] = value;
        hands[n].chars[pos] = c;
      } else {
        bid[pos-5] = value;
      }

      pos++;
    }
    fclose(fh);
  }

  return n;
}


int main() {
  int winnings = 0;
  int mul;
  int sum;

  hand_t hands[N_HANDS];
  parse_input(FILENAME, hands);
  rank_hands(hands);

  //printf("--\n");
  for (int i=0; i<N_HANDS; i++) {
    mul = i+1;
    sum = mul * hands[i].bid;
    //show_hand(&hands[i]);
    //printf(" i=%d (%d*%d) = %d + %d = ", i, mul, hands[i].bid, sum, winnings);

    winnings = winnings + sum;
    //printf("%d\n", winnings);
  }

  printf("%d\n", winnings);
  return 0;
}
