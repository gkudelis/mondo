(local {: kind} (require :kindness))

(local list (kind :list))

(fn list.bind [vs f]
  (local result [])
  (each [_ v (ipairs vs)]
    (each [_ u (ipairs (f v))]
      (table.insert result u)))
  result)

(fn list.wrap [v] [v])

(local maybe (kind :maybe))

(maybe:constructor
  :some
  (fn [v] {:some v}))

(maybe:constructor
  :none
  (fn [] {:none true}))

(fn maybe.wrap [v] (maybe.some v))

(fn maybe.bind [v f]
  (match v
    {:some u} (f u)
    {:none _} v))

(local result (kind :result))

(result:constructor
  :ok
  (fn [v] {:ok v}))

(result:constructor
  :error
  (fn [e] {:error e}))

(fn result.bind [v f]
  (match v
    {:ok u} (f u)
    {:error _} v))

(fn result.wrap [v] (result.ok v))

{: list
 : maybe
 : result}
