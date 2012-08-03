(defmacro unless [test body & args]
  (if (> (count args) 1)
    (throw "unless accepts 2 or 3 arguments only")
  )
  (if (empty? args)
    `(if (not ~test) ~body)
    `(if (not ~test) ~body ~(first args))
  )
)

(doseq [x (list 1 2 3 4)]
  (unless (< x 0)
    (println (str "It's a good nonnegative number:" x))
    (println (str "Cannot do anything with negative: " x))
  )
  (unless (odd? x)
    (println (str "Even numbers are the best! " x))
  )
)

; Exception in thread "main" java.lang.ClassCastException: java.lang.String cannot be cast to java.lang.Throwable
;(unless (win? 123)
;  4
;  5
;  6
;)
