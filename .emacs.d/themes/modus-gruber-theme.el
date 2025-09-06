;;; modus-gruber-theme.el --- A custom theme inspired by Modus Operandi and Gruber Darker.

;;; Commentary:
;; This theme combines the muted, high-contrast background of Gruber Darker
;; with the clear, accessible syntax colors of Modus Operandi.

;;; Code:

(deftheme modus-gruber "A custom theme inspired by Modus Operandi and Gruber Darker.")

;; Color palette and face definitions will go here.
(let ((bg      "#202020")
      (fg      "#E8E8E8")
      (comment "#707070")
      (blue    "#0072d8")
      (cyan    "#007575")
      (magenta "#b11a97")
      (red     "#c40000")
      (yellow  "#a67300")
      (green   "#007300"))
  ;; Face definitions will go inside this 'let' block.
  )

(custom-theme-set-faces
 'modus-gruber
 ;; Basic text faces
 `(default ((t (:background ,bg :foreground ,fg))))
 `(cursor ((t (:background ,blue))))
 `(region ((t (:background "#404040"))))
 `(highlight ((t (:background "#383838"))))
 `(mode-line ((t (:background "#303030" :foreground ,fg))))

 ;; Syntax highlighting faces
 `(font-lock-comment-face ((t (:foreground ,comment))))
 `(font-lock-function-name-face ((t (:foreground ,yellow))))
 `(font-lock-keyword-face ((t (:foreground ,blue))))
 `(font-lock-string-face ((t (:foreground ,cyan))))
 `(font-lock-variable-name-face ((t (:foreground ,magenta))))
 `(font-lock-type-face ((t (:foreground ,green))))
 `(font-lock-warning-face ((t (:foreground ,red :weight 'bold))))
 `(font-lock-builtin-face ((t (:foreground ,blue))))
 `(font-lock-constant-face ((t (:foreground ,magenta)))))

(provide-theme 'modus-gruber)

;;; modus-gruber-theme.el ends here
