%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
KDP kdp = {.points=0, .flops=0, .port=8038};
%}
%union { char *str; int num; double flt; }
%token <str> KEY STRING
%token <num> NUMBER
%token <flt> FNUMBER
%token COLON NEWLINE
%%
profile: /* empty */ | profile line ;
line: KEY COLON STRING NEWLINE { kdp_store($1,$3); free($1); free($3); }
    | KEY COLON NUMBER NEWLINE { char b[32]; snprintf(b,sizeof(b),"%d",$3); kdp_store($1,b); free($1); }
    | KEY COLON FNUMBER NEWLINE { char b[32]; snprintf(b,sizeof(b),"%.0f",$3); kdp_store($1,b); free($1); }
    | NEWLINE
;
%%
void yyerror(const char *msg){ fprintf(stderr,"parse error: %s\n",msg); }
void kdp_store(const char *key, const char *value){
    if(strcmp(key,"Nickname")==0) snprintf(kdp.nickname,sizeof(kdp.nickname),"%s",value);
    else if(strcmp(key,"Code")==0) snprintf(kdp.code,sizeof(kdp.code),"%s",value);
    else if(strcmp(key,"Role")==0) snprintf(kdp.role,sizeof(kdp.role),"%s",value);
    else if(strcmp(key,"Points")==0) kdp.points=atoi(value);
    else if(strcmp(key,"Page")==0) snprintf(kdp.page,sizeof(kdp.page),"%s",value);
    else if(strcmp(key,"Event")==0) snprintf(kdp.event,sizeof(kdp.event),"%s",value);
    else if(strcmp(key,"Flops")==0) kdp.flops=atof(value);
    else if(strcmp(key,"BOA")==0) snprintf(kdp.boa_type,sizeof(kdp.boa_type),"%s",value);
    else if(strcmp(key,"Port")==0) kdp.port=atoi(value);
}
void kdp_print(void){
    printf("=== KDP Forum Profile + eal7 QUAD ===\n");
    printf("Nickname : %s\nCode     : %s\nRole     : %s\nPoints   : %d\n",kdp.nickname,kdp.code,kdp.role,kdp.points);
    printf("Page     : %s\nEvent    : %s\nFlops    : %.0f\nBOA      : %s\nPort     : %d\n",kdp.page,kdp.event,kdp.flops,kdp.boa_type,kdp.port);
    printf("=== FLOP QUADRUPLE: 4+16+64=%d ===\n",(int)(4+16+64));
}
int main(void){ if(yyparse()!=0) return 1; kdp_print(); return 0; }
