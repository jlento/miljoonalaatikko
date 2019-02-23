(defun markdown-justify-buffer ()
  "Justifies markdown buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (let ((current-prefix-arg 1)
            (paragraph-start
             (concat paragraph-start "\\| ? ? ?\\[[^]]+]:")))
            (call-interactively 'markdown-fill-paragraph))
          (markdown-forward-paragraph))))
