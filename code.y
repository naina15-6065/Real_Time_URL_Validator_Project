%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "code.tab.h"


int yylex();
int yyparse();
int yyerror(char *s);

// Flex buffer functions declarations for Windows
typedef void* YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char *str);
extern void yy_delete_buffer(YY_BUFFER_STATE);
YY_BUFFER_STATE buffer;



char *protocol_val;
char *domain_val;
char *path_val;
char *query_val;
char *fragment_val;
char *port_val;
int url_valid = 1;
%}

%union {
    char *str;
}

%token <str> ID NUMBER
%token HTTP HTTPS FTP
%token COLONSLASH COLON SLASH DOT QMARK EQUAL AMP HASH

%type <str> domain domain_rest
%type <str> opt_path more_path
%type <str> opt_query more_queries
%type <str> opt_fragment

%%

url:
      HTTP COLONSLASH domain opt_port opt_path opt_query opt_fragment { protocol_val = "http"; }
    | HTTPS COLONSLASH domain opt_port opt_path opt_query opt_fragment { protocol_val = "https"; }
    | FTP COLONSLASH domain opt_port opt_path opt_query opt_fragment   { protocol_val = "ftp"; }
    ;

domain:
      ID domain_rest
      {
        int len = strlen($1) + strlen($2) + 1;
        domain_val = malloc(len);
        sprintf(domain_val, "%s%s", $1, $2);
      }
    ;

domain_rest:
      /* empty */ { $$ = strdup(""); }
    | DOT ID domain_rest
      {
        int len = strlen($2) + strlen($3) + 2;
        $$ = malloc(len);
        sprintf($$, ".%s%s", $2, $3);
      }
    ;

opt_port:
      /* empty */ { port_val = NULL; }
    | COLON NUMBER { port_val = $2; }
    ;

opt_path:
      /* empty */ { path_val = NULL; $$ = strdup(""); }
    | SLASH ID more_path
      {
        int len = strlen($2) + strlen($3) + 2;
        path_val = malloc(len);
        sprintf(path_val, "/%s%s", $2, $3);
        $$ = path_val;
      }
    ;

more_path:
      /* empty */ { $$ = strdup(""); }
    | SLASH ID more_path
      {
        int len = strlen($2) + strlen($3) + 2;
        $$ = malloc(len);
        sprintf($$, "/%s%s", $2, $3);
      }
    ;

opt_query:
      /* empty */ { query_val = NULL; $$ = strdup(""); }
    | QMARK ID EQUAL ID more_queries
      {
        int len = strlen($2) + strlen($4) + strlen($5) + 3;
        query_val = malloc(len);
        sprintf(query_val, "%s=%s%s", $2, $4, $5);
        $$ = query_val;
      }
    ;

more_queries:
      /* empty */ { $$ = strdup(""); }
    | AMP ID EQUAL ID more_queries
      {
        int len = strlen($2) + strlen($4) + strlen($5) + 3;
        $$ = malloc(len);
        sprintf($$, "&%s=%s%s", $2, $4, $5);
      }
    ;

opt_fragment:
      /* empty */ { fragment_val = NULL; $$ = strdup(""); }
    | HASH ID      { fragment_val = $2; $$ = $2; }
    ;

%%

int yyerror(char *s) {
    printf("\nInvalid URL (%s)\n", s);
    url_valid = 0;
    return 0;
}

int main() {
    char choice;
    char input[1024];

    do {
        protocol_val = domain_val = path_val = query_val = fragment_val = port_val = NULL;
        url_valid = 1;

        printf("\nEnter a URL:\n");
        if (!fgets(input, sizeof(input), stdin)) break;

        // Remove newline
        size_t len = strlen(input);
        while (len > 0 && (input[len-1] == '\n' || input[len-1] == '\r')) {
            input[len-1] = '\0';
            len--;
        }

        // Feed input directly to Flex
        buffer = yy_scan_string(input);
        yyparse();
        yy_delete_buffer(buffer);

        if (url_valid) {
            printf("\nURL is valid\n");
            printf("Protocol: %s\n", protocol_val);
            printf("Domain: %s\n", domain_val);
            printf("Port: %s\n", port_val ? port_val : "(none)");
            printf("Path: %s\n", path_val ? path_val : "/");
            printf("Query: %s\n", query_val ? query_val : "(none)");
            printf("Fragment: %s\n", fragment_val ? fragment_val : "(none)");
        }

        printf("\nDo you want to enter another URL? (y/n): ");
        scanf(" %c", &choice);
        int c; while ((c = getchar()) != '\n' && c != EOF);

    } while (choice == 'y' || choice == 'Y');

    return 0;
}