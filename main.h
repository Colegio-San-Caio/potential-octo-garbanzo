#ifndef MAIN_H
#define MAIN_H
typedef struct {
    char nickname[128];
    char code[64];
    char role[32];
    int points;
    // eal7 extension - adapted from FEMoeneye
    char page[128];
    char event[32];
    double flops;
    char boa_type[64];
    int port;
} KDP;
extern KDP kdp;
void kdp_store(const char *key, const char *value);
void kdp_print(void);
int yylex(void);
void yyerror(const char *msg);
#endif
