(local {: kind} (require :kindness))

(local list (kind :list))

(fn list.wrap [v] [v])

(fn list.bind [vs f]
  (local result [])
  (each [_ v (ipairs vs)]
    (each [_ u (ipairs (f v))]
      (table.insert result u)))
  result)

(local maybe (kind :maybe))

(fn maybe.just [v]
  {:just true
   :value v})

(fn maybe.none []
  {:just false})

(fn maybe.wrap [v] (maybe.just v))

(fn maybe.bind [v f]
  (if v.just (f v.value) v))

{: list
 : maybe}
