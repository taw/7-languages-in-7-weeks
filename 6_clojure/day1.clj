(println "Hello, world!")

(defn big [st n] (> (.length st) n))

(def tests1 (list "foo" "bar" "hello" "?" "kitty" "woot" "ha" "fail"))
(doseq [s tests1]
  (if (big s 3)
    (println (str "String `" s "' is longer than " 3 " characters"))
    (println (str "String `" s "' is not than " 3 " characters"))
  )
)

; clashes on nil
(defn collection-type [col]
  (case (.getName (class col))
    ("clojure.lang.PersistentList") :list
    ("clojure.lang.PersistentList$EmptyList") :list
    ("clojure.lang.PersistentArrayMap") :map
    ("clojure.lang.PersistentHashMap") :map
    ("clojure.lang.PersistentVector") :vector
    (str "unknown(" (.getName (class col)) ")")
  )
)

(def tests2 (list 
  [] [1] (list) (list 1) {} {1 2}  42
))
(doseq [c tests2]
  (println (str "Collection `" c "' is of type " (collection-type c)))
)
