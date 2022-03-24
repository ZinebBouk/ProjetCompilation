(*fichier lexeur.mll *)
{
open Parseur
exception Eof
exception TokenInconu
}
rule token = parse
[' ' '\t' '\n' '\r'] { token lexbuf }
| [';'] { PT_VIRG }
| ['0'-'9']+('.'['0'-'9'])? { NOMBRE }
| '+' { PLUS }
| '-' { MOINS }
| '*' { FOIS }
| '(' { GPAREN }
| ')' { DPAREN }
| eof { raise Eof }
| _ { raise TokenInconu }
