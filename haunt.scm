(add-to-load-path "./builders/")
(add-to-load-path "./templates/")

(use-modules
  (haunt asset)
  (haunt builder assets)
  (haunt builder flat-pages)
  (haunt reader)
  (haunt reader skribe)
  (haunt site)

  (nursery templates core)
  (nursery builders commandline))


(site #:title "tty garden"
  #:domain
  "tty.garden"
  #:readers
  (list
    sxml-reader
    skribe-reader)
  #:builders
  (list
    (static-directory "assets")
    (cmd-builder '("sass" "--style=compressed") "css/core.scss" "core.css")
    (flat-pages "pages" #:template nursery-template-base)))
