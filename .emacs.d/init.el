;;; init.el --- The one true init file

;; This file should be the only .el file in your ~/.emacs.d/
;; It loads the real configuration from config.org
(setq debug-on-error t)
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6bf350570e023cd6e5b4337a6571c0325cec3f575963ac7de6832803df4d210a"
     "7235b77f371f46cbfae9271dce65f5017b61ec1c8687a90ff30c6db281bfd6b7"
     "1c2fb3448ce245f18c62fde3c7cfd008e69a27e88ae8a03fbb62857f13d0b6fe"
     "0a08e6dac817385803c9f516c87e775cbfcf56ec926669159ed21a19f32a87fa"
     "a9028cd93db14a5d6cdadba789563cb90a97899c4da7df6f51d58bb390e54031"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
