module Main where
  list_top_select f [] top rest = (top, rest)
  list_top_select f (top':todo) top rest =
    if f top top'
    then
      list_top_select f todo top' (top:rest)
    else
      list_top_select f todo top (top':rest)

  mysort [] = []
  mysort (h:t) = h':(mysort t')
    where (h', t') = list_top_select (>) t h []

  -- mysort2 (\a b -> abs a > abs b) [17,2,-5,9,33]
  mysort2 f [] = []
  mysort2 f (h:t) = h':(mysort2 f t')
    where (h', t') = list_top_select f t h []


  is_member x [] = False
  is_member x (h:t) =
    if x == h
    then True
    else is_member x t

  char_to_digit '0' = 0
  char_to_digit '1' = 1
  char_to_digit '2' = 2
  char_to_digit '3' = 3
  char_to_digit '4' = 4
  char_to_digit '5' = 5
  char_to_digit '6' = 6
  char_to_digit '7' = 7
  char_to_digit '8' = 8
  char_to_digit '9' = 9

  parse_decimal_number v [] = v
  parse_decimal_number v ('.':t) = v + parse_decimal_number_frac t 0 1
  parse_decimal_number v (h:t) = parse_decimal_number (10*v+(char_to_digit h)) t
  parse_decimal_number_frac [] num den = num/den
  parse_decimal_number_frac (h:t) num den = parse_decimal_number_frac t ((char_to_digit h)+num*10) (den*10)
 
  -- currency_to_number "$2,345,678.99"
  -- currency_to_number "$00.12"
  currency_to_number str = parse_decimal_number 0 str'
     where str' = filter (\x -> is_member x ('.':['0'..'9'])) str

  every_third (h:t) 0 = h:(every_third t 2)
  every_third (h:t) n = every_third t (n-1)

  every_fifth (h:t) 0 = h:(every_fifth t 4)
  every_fifth (h:t) n = every_fifth t (n-1)

  half_a_number = (/ 2)
  append_nl = (++ "\n")

  mygcd a b =
    if b > a
    then mygcd b a
    else if b == 0
         then a
         else mygcd b (mod a b)

  is_prime (h:t) n =
    if (mod n h) == 0
      then False
      else if n < h*h
        then True
        else is_prime t n
    
  primes = 2:3:(filter (is_prime primes) [5..])

-- BONUS TODO:
-- * break string into lines at word boundaries
-- * then add line numbers to it
-- * functions to left/right/fully adjust
