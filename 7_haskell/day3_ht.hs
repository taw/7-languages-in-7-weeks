module Main where
  animals = [("dog", "fido"), ("cat", "cloud")]
  humans = [("adolf", "hitler"), ("angela", "merkel")]  
  distros = [("linux", "ubuntu"), ("mac", "osx")]
  languages = [("python", "3000"), ("ruby", "1.9.3")]
  alive = [("animals", animals), ("humans", humans)]
  things = [("distros", distros), ("languages", languages)]
  universe = [("alive", alive), ("things", things)]

  htget [] key = Nothing
  htget ((k,v):rest) key = if k == key
                           then Just(v)
                           else htget rest key

  htget3 ht k1 k2 k3 = do
    a <- htget ht k1
    b <- htget a k2
    c <- htget b k3
    return c
