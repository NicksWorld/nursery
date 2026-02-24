(define-module (nursery templates core)
  #:export
  (nursery-template-base))

(define (nursery-template-base site metadata body)
  (define display-title
    (or (assq-ref metadata 'title) "tty.garden"))
  `((doctype "html")
    (head
     (meta (@ (charset "utf-8")))
     (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
     (title ,display-title)
     (link (@
            (rel "stylesheet")
            (href "/core.css")))
     (link (@
            (rel "icon")
            (href "/assets/garden.svg"))))
    (body
     (div (@
           (id "content"))
      (div (@ (id title))
       (div (@ (class "garden-icon")))
       (h1 (@ (class "title")) ,display-title))
      (nav
       (@ (class "primary-nav"))
       (a (@ (href "/")) "Home")
       (div (@ (class "vertical-seperator")))
       (a (@ (href "https://seed.tty.garden/nmcdaniel")) "Git")
       (div (@ (class "vertical-seperator")))
       (a (@ (href "/about")) "About"))
      ,body))))
