(*fichier main.ml *)

let _ = (*main en OCaml*)
try
let argc = Array.length Sys.argv in
if (argc == 2) then let file = open_in Sys.argv.(1) in let lexbuf = Lexing.from_channel file in let destination = open_out_gen [Open_trunc;Open_creat;Open_wronly] 0o777 (Sys.argv.(1)^".jsm") in (*lexeur lancé sur stdin*)
while true do (*on ne s'arrête pas*)
(("Halt\n" |> ((Parseur.main Lexeur.token lexbuf (*parseur une ligne*)
|> AST.assembleur_AST) |> (^))) |> (destination |> output_string )) ;
done
else let lexbuf =  Lexing.from_channel stdin in (*lexeur lancé sur stdin*)
while true do (*on ne s'arrête pas*)
Parseur.main Lexeur.token lexbuf (*parseur une ligne*)
|> AST.assembleur_AST |> Printf.printf "%s\nHalt\n%!" ;
done
with
(*| End_of_file -> close_in (open_in Sys.argv.(1)); close_out destination*)
| Lexeur.Eof -> exit 0 (*impossible*)
| Lexeur.TokenInconu (*erreur de lexing*)
| Parsing.Parse_error -> (*erreur de parsing*)
Printf.printf ("Ceci n'est pas une expression arithmetique\n")

