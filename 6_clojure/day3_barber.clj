(def haircuts (ref 0))
(def waiting_room (ref 0))
(def result (future (Thread/sleep 10000) @haircuts))
(defn new_customer []
  (dosync
    (alter waiting_room (fn [n] (min 3 (inc n)))
)))
(defn barber []
  (dosync
    (if (> @waiting_room 0)
      (do
        (alter waiting_room dec)
        (alter haircuts inc)
        true
      )
      false
)))

(defn infinite-loop [f]
  (future
    (loop [n 0]
      (f)
      (recur (inc n))
    )
  )
)

(infinite-loop (fn []
  (Thread/sleep (+ 10 (rand 20)))
  (new_customer)
))
(infinite-loop (fn []
  ;(println (str "barber:" @haircuts "/" @waiting_room))
  (if (barber)
    (Thread/sleep 20)
    (Thread/sleep 1)
)))

(println @result)
(println @haircuts)
(println @waiting_room)
; (exit) ; doesn't work
