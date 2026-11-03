%{
/* main.y - the KDP profile through a Yacc (bison -y) grammar with a small hand-written scanner.
   build: bison -o main.tab.c main.y && cc -I. -o kdp_yacc main.tab.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"

int yylex(void);
void yyerror(const char *msg);

struct kdp_profile kdp;

static const char *src =
    "=== KDP Forum Profile ===\n"
    "Nickname : KDPMember:KL5UQ4f48673352\n"
    "Code : KL5UQ4f48673352\n"
    "Role : Member\n"
    "Points : 1\n";
%}

%union { char *s; }
%token BANNER
%token <s> KEY VALUE

%%

profile : BANNER fields ;

fields  : field
        | fields field
        ;

field   : KEY ':' VALUE   { kdp_store($1, $3); free($1); free($3); }
        ;

%%

static char *copy_n(const char *s, size_t n)
{
    char *p = malloc(n + 1);
    memcpy(p, s, n);
    p[n] = '\0';
    return p;
}

/* Scanner: the banner line, then "KEY : VALUE" lines. */
int yylex(void)
{
    static int state = 0;                 /* 0 = want KEY, 1 = want ':', 2 = want VALUE */
    const char *s;
    size_t n;

    while (*src == ' ' || *src == '\n') src++;
    if (*src == '\0') return 0;

    if (state == 0 && strncmp(src, "===", 3) == 0) {
        while (*src && *src != '\n') src++;
        return BANNER;
    }
    if (state == 0) {
        s = src;
        while (*src && *src != ' ' && *src != ':' && *src != '\n') src++;
        yylval.s = copy_n(s, (size_t)(src - s));
        state = 1;
        return KEY;
    }
    if (state == 1) {
        if (*src == ':') { src++; state = 2; return ':'; }
        return *src++;                    /* anything else is a syntax error */
    }
    s = src;
    while (*src && *src != '\n') src++;
    n = (size_t)(src - s);
    while (n > 0 && s[n - 1] == ' ') n--;
    yylval.s = copy_n(s, n);
    state = 0;
    return VALUE;
}

void yyerror(const char *msg) { fprintf(stderr, "parse error: %s\n", msg); }

void kdp_store(const char *key, const char *value)
{
    if (strcmp(key, "Nickname") == 0)      snprintf(kdp.nickname, sizeof kdp.nickname, "%s", value);
    else if (strcmp(key, "Code") == 0)     snprintf(kdp.code, sizeof kdp.code, "%s", value);
    else if (strcmp(key, "Role") == 0)     snprintf(kdp.role, sizeof kdp.role, "%s", value);
    else if (strcmp(key, "Points") == 0)   kdp.points = atoi(value);
}

void kdp_print(void)
{
    printf("=== KDP Forum Profile ===\n");
    printf("Nickname : %s\n", kdp.nickname);
    printf("Code     : %s\n", kdp.code);
    printf("Role     : %s\n", kdp.role);
    printf("Points   : %d\n", kdp.points);
}

int main(void)
{
    if (yyparse() != 0) return 1;
    kdp_print();
    return 0;
}
