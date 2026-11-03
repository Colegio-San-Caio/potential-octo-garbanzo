/* main.h - shared by main.y: the KDP profile record and its helpers. */
#ifndef KDP_MAIN_H
#define KDP_MAIN_H

struct kdp_profile {
    char nickname[64];
    char code[64];
    char role[32];
    int  points;
};

extern struct kdp_profile kdp;
void kdp_store(const char *key, const char *value);
void kdp_print(void);

#endif
