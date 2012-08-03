(defn new-queue [] (ref []))
(defn enqueue [queue msg] (alter queue (fn [q] (cons msg q))))

(defn try-dequeue [queue]
  (if (= (count @queue) 0)
    nil
    (let [rv (last @queue)]
      (alter queue (fn [q] (take (- (count q) 1) q)))
      rv
    )
))

; Session
(def q (new-queue))
(dosync (enqueue q :foo))
(dosync (enqueue q :bar))
(dosync (enqueue q :blah)) 

(dosync (try-dequeue q))
