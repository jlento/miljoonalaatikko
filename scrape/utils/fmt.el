(require 'markdown-mode)

(defun markdown-justify-buffer ()
  "Justifies markdown buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (let* ((current-prefix-arg 1)
             (reference-link-start "\\| ? ? ?\\[[^]]+]:")
             (paragraph-start (concat paragraph-start reference-link-start)))
        (call-interactively 'markdown-fill-paragraph)
        (markdown-forward-paragraph)))))
