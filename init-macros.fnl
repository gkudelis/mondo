(local bind (gensym :bind))
(local wrap (gensym :wrap))

(fn resolve-wrap [body]
  (if (= (. body 1) (sym :wrap)) (tset body 1 wrap))
  body)

(fn mon-do-helper [bindings body]
  (match bindings
    [name value & rest] `(: ,value :bind (fn [,name] ,(mon-do-helper rest body)))
    [] (resolve-wrap body)))

(fn mon-do [bindings body]
  `(let [,bind (. ,monad :bind)
         ,wrap (. ,monad :wrap)]
     ,(mon-do-helper bindings body)))

{: mon-do}
