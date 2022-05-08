
type expression_a =
    | Plus  of expression_a * expression_a
    | Moins of expression_a * expression_a
    | Mult  of expression_a * expression_a
    | Div   of expression_a * expression_a
    | Mod   of  expression_a * expression_a
    | Neg   of expression_a
    | Num   of float
;;


(* Fonctions d'affichage *)

let rec print_binaire form s g d = Format.fprintf form "@[<2>%s%s@ %a%s@ %a%s@]" s "(" print_AST g " ," print_AST d " )" 

and print_AST form = let open Format in function
    | Plus  (g,d) -> print_binaire form "Plus" g d
    | Moins (g,d) -> print_binaire form "Moins" g d
    | Mult  (g,d) -> print_binaire form "Mult" g d
    | Div   (g,d) -> print_binaire form "Div" g d
    | Mod   (g,d) -> print_binaire form "Mod" g d
    | Neg    e    -> fprintf form "@[<2>%s@ %a@]" "Neg" print_AST e 
    | Num    n    -> fprintf form "@[<2>%s@ %F@]" "Num" n
;; 

(* Fonction pour l'assembleur*)
let rec assembleur_AST form = match form with
    | Plus  (g,d) -> (assembleur_AST g)^"\n"^(assembleur_AST d)^"\n"^"AddiNb\n"
    | Num    n    -> "CstNb "^string_of_float n
    | Moins (g,d) -> (assembleur_AST g)^"\n"^(assembleur_AST d)^"\n"^"SubiNb\n"
    | Mult  (g,d) -> (assembleur_AST g)^"\n"^(assembleur_AST d)^"\n"^"MultNb\n"
    | Div  (g,d) -> (assembleur_AST g)^"\n"^(assembleur_AST d)^"\n"^"DiviNb\n"
    | Mod  (g,d) -> (assembleur_AST g)^"\n"^(assembleur_AST d)^"\n"^"ModNb\n"
    | Neg    e    -> (assembleur_AST e)^"\n"^"NegaNb\n"
;; 

(* Fonctions pour les calculs*)

let print_result g d o = match o with
    | "+." -> (g +. d)
    | "-." -> (g -. d)
    | "*." -> (g *. d)
    | "/." -> (g /. d)
    | "%." -> mod_float g d
    | "-"  -> -. g
    | _ -> 0.
;;

let rec resultat_AST form = match form with
    | Num    n    -> n
    | Plus  (g,d) -> print_result (resultat_AST g) (resultat_AST d) "+."
    | Moins (g,d) -> print_result (resultat_AST g) (resultat_AST d) "-."
    | Mult  (g,d) -> print_result (resultat_AST g) (resultat_AST d) "*."
    | Div   (g,d) -> print_result (resultat_AST g) (resultat_AST d) "/."
    | Mod   (g,d) -> print_result (resultat_AST g) (resultat_AST d) "%."
    | Neg    e    -> print_result (resultat_AST e) (resultat_AST e) "-"
;; 



