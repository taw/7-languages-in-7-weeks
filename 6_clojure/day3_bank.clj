(def bank (ref {:alice 100 :bob 200 :charlie 300}))

(defn get-account [name] (@bank name))
(defn set-account [name val] (alter bank merge {name val}))
(defn mod-account [name val] (set-account name (+ val (@bank name))))
(defn transfer-money [from to val] (mod-account from (- val)) (mod-account to val))
(defn try-transfer-money [fromac toac val] 
  (if (>= (@bank fromac) val)
    (transfer-money fromac toac val)
    (throw (Exception. "fail")))
)
