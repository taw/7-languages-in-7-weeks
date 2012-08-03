module Main where
  maze = [(1,1), (1,2), (1,3), (2,1), (3,1), (3,2), (3,3), (3,4), (3,5), (2,5), (1,5), (1,6), (1,7), (3,6), (3,7), (2,7)]

  is_member x [] = False
  is_member x (h:t) =
    if x == h
    then True
    else is_member x t
  
  node_neighbours :: [(Integer,Integer)] -> (Integer,Integer) -> [(Integer,Integer)]
  node_neighbours maze (x,y) = [(xi,yi) | (xi,yi) <- maze, (x,y) /= (xi,yi), (x-xi)*(y-yi) == 0, is_member (x-xi) [-1,0,1], is_member (y-yi) [-1,0,1]]
  
  maze_path :: [(Integer,Integer)] -> (Integer,Integer) -> (Integer,Integer) -> [[(Integer,Integer)]]
  maze_path maze a c = if a == c
    then [[a]]
    else do
      b <- node_neighbours maze a
      path <- maze_path ([m | m <- maze, m /= a]) b c
      return (a:path)

-- maze_path maze (1,1) (1,7)
-- maze_path maze (1,1) (3,7)
