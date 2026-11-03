%{
/* main.l - the KDP profile through a Lex (flex) scanner.
   build: flex -o main.yy.c main.l && cc -o kdp_lex main.yy.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const char PROFILE[] =
    "Nickname : KDPMember:KL5UQ4f48673352\n"
    "Role : Member\n"
    "Points : 1\n";

static char nick[64];
static char role[32];
static int  points;
%}

%option noyywrap noinput nounput

ID      KDPMember:[A-Za-z0-9]+
WORD    [A-Za-z]+

%%

^"Nickname"[ \t]*":"[ \t]*{ID}  { sscanf(strchr(yytext, ':') + 1, " %63s", nick); }
^"Role"[ \t]*":"[ \t]*{WORD}    { sscanf(strchr(yytext, ':') + 1, " %31s", role); }
^"Points"[ \t]*":"[ \t]*[0-9]+  { points = atoi(strchr(yytext, ':') + 1); }
\n|.                            { /* ignore everything else */ }

%%

int main(void)
{
    YY_BUFFER_STATE b = yy_scan_string(PROFILE);
    yylex();
    yy_delete_buffer(b);

    /* the short code after the "KDPMember:" prefix */
    const char *code = strncmp(nick, "KDPMember:", 10) == 0 ? nick + 10 : nick;
    printf("=== KDP Forum Profile ===\n");
    printf("Nickname : %s\n", nick);
    printf("Code     : %s\n", code);
    printf("Role     : %s\n", role);
    printf("Points   : %d\n", points);
    return 0;
}
