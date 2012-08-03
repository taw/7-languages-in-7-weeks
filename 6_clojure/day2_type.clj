(definterface IPlayerCharacter
  (hit [dmg])
  (status [])
  (isAlive [])
)

(deftype PlayerCharacter [name ^{:volatile-mutable true} hp hpmax]
  IPlayerCharacter
  (hit [this dmg] (set! hp (- hp dmg)))
  (isAlive [this] (> hp 0))
  (status [this]
    (str name " (" hp "/" hpmax ") - " (if (.isAlive this) "alive" "dead"))
  )
)


(def c (PlayerCharacter. "bob" 50 100))
(println (.status c))
(.hit c 40)
(println (.status c))
(.hit c 15)
(println (.status c))
