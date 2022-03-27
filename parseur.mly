%token <float> NOMBRE
%token NOMBRE PLUS MOINS FOIS GPAREN DPAREN PT_VIRG MODULO
%left PLUS MOINS
%left FOIS MODULO
%nonassoc UMOINS
%type <float> main expression
%start main
%%
main:
expression PT_VIRG {$1}
;
expression:
expression PLUS expression {$1 +. $3}
| expression MOINS expression {$1 -. $3}
| expression FOIS expression {$1 *. $3}
| expression MODULO expression {mod_float $1 $3}
| GPAREN expression DPAREN {$2}
| MOINS expression %prec UMOINS {-.$2}
| NOMBRE {$1}
;