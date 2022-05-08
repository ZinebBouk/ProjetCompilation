(*fichier main.ml *)

let _ = (*main en OCaml*)
try
let lexbuf =  Lexing.from_channel stdin in (*lexeur lancé sur stdin*)
while true do (*on ne s'arrête pas*)
(Parseur.main Lexeur.token lexbuf (*parseur une ligne*)
|> AST.resultat_AST) |> Printf.printf "%F\n%!" ;
done
with
(*| End_of_file -> close_in (open_in Sys.argv.(1)); close_out destination*)
| Lexeur.Eof -> exit 0 (*impossible*)
| Lexeur.TokenInconu (*erreur de lexing*)
| Parsing.Parse_error -> (*erreur de parsing*)
Printf.printf ("Ceci n'est pas une expression arithmetique\n")

