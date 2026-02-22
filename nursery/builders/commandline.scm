(define-module (nursery builders commandline)
  #:use-module
  (ice-9 match)
  #:use-module
  (haunt artifact)
  #:export
  (cmd-artifact cmd-builder))

(define (cmd-artifact cmd source destination)
  (unless (file-exists? source)
    (error "input file does not exist" source))
  (make-artifact destination
    (lambda (output)
      (let ((command (append cmd (list source))))
        (format #t "run '~a' -> '~a'~%"
          (string-join command " ")
          destination)
        (call-with-output-file output
          (lambda (port)
            (match (primitive-fork)
              (0
                (close 1)
                (dup2 (fileno port) 1)
                (apply execlp (cons (car command) command)))
              (pid
                (match (waitpid pid)
                  ((_ . status)
                    (unless (zero? (status:exit-val status))
                      (error "command failed" command))))))))))))

(define (cmd-builder command in out)
  (lambda (_site _posts)
    (cmd-artifact command in out)))
