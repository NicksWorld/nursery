(add-to-load-path "./builders/")

(use-modules
  (haunt asset)
  (haunt builder assets)
  (haunt builder flat-pages)
  (haunt reader)
  (haunt reader skribe)
  (haunt site)

  (nursery builders commandline))

(define (nursery-template-base site metadata body)
  (define display-title
    (or (assq-ref metadata 'title) "tty.garden"))
  `((doctype "html")
    (head
     (meta (@ (charset "utf-8")))
     (title ,display-title)
     (link (@
            (rel "stylesheet")
            (href "/core.css"))))
    (body
     (div (@
           (id "content"))
      (h1 (@ (class "title")) ,display-title)
      (nav
        (@ (class "primary-nav"))
        (a (@ (href "/")) "Home" )
        (div (@ (class "vertical-seperator")))
        (a (@ (href "https://seed.tty.garden/nmcdaniel")) "Git"))
      ,body))))

(site #:title "tty garden"
  #:domain
  "tty.garden"
  #:readers
  (list
    sxml-reader
    skribe-reader)
  #:builders
  (list
    (cmd-builder '("sass" "--style=compressed") "css/core.scss" "core.css")
    (flat-pages "pages" #:template nursery-template-base)))
