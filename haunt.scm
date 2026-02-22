(add-to-load-path "./builders/")

(use-modules
  (haunt asset)
  (haunt builder assets)
  (haunt builder flat-pages)
  (haunt reader)
  (haunt site)

  (nursery builders commandline))

(define (nursery-template-base site metadata body)
  `((doctype "html")
    (head
     (meta (@ (charset "utf-8")))
     (title ,(or (assq-ref metadata 'title) "tty.garden"))
     (link (@
            (rel "stylesheet")
            (href "/core.css"))))
    (body
     (div (@
           (id "content"))
      ,body))))

(site #:title "tty garden"
  #:domain
  "tty.garden"
  #:readers
  (list sxml-reader)
  #:builders
  (list
    (cmd-builder '("sass" "--style=compressed") "css/core.scss" "core.css")
    (flat-pages "pages" #:template nursery-template-base)))
