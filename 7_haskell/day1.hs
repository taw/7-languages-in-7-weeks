module Main where
  allEven :: [Int] -> Bool
  allEven [] = True
  allEven (h:t) = even h && allEven t

  allEven2 t = all even t
  
  myreverse2 [] t = t
  myreverse2 (h:t) t2 = myreverse2 t (h:t2)
  myreverse t = myreverse2 t []
  
  colors = ["black", "white", "blue", "yellow", "red"]
  color_combinations = [(c1,c2) | c1 <- colors, c2 <- colors, c1 < c2]
  
  mult_table = [(a,b,a*b) | a <- [1..12], b <- [1..12]]
  
  map_colors = ["red", "green", "blue"]
  map_colorings = [(t,m,a,g,f) |
                    t <- map_colors,
                    m <- map_colors,
                    a <- map_colors,
                    g <- map_colors,
                    f <- map_colors,
                    t /= m,
                    t /= a,
                    t /= g,
                    m /= a,
                    a /= g,
                    f /= a,
                    f /= g ]
