;;; test.el --- 测试make-thread下调用动态模块函数是否会卡住主线程 -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 zombie110year
;;
;; Author: zombie110year <zombie110year@outlook.com>
;; Maintainer: zombie110year <zombie110year@outlook.com>
;; Created: 七月 18, 2022
;; Modified: 七月 18, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/zom/test
;; Package-Requires: ((emacs "26.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  测试make-thread下调用动态模块函数是否会卡住主线程
;;
;;; Code:

(declare-function example-dymod--wait3 nil)
(declare-function example-dymod--wait3-thread nil)
(module-load "./libemacs_module_multithread.so")

(defun test-dymod-wait3-builtin ()
  "Use builtin `sleep-for'."
  (make-thread
   (lambda ()
     (sleep-for 3)
     (message "test-dymod-wait3-builtin")))
  (insert "test-dymod-wait3-builtin"))

(defun test-dymod-wait3-common ()
  "Use wait3 function, not use Rust's thread."
  (make-thread
   (lambda ()
     (example-dymod--wait3)
     (message "test-dymod-wait3-common")))
  (insert "test-dymod-wait3-common"))

(defun test-dymod-wait3-thread ()
  "Use wait3 function, spawn thread by Rust."
  (make-thread
   (lambda ()
    (example-dymod--wait3-thread)
    (message "test-dymod-wait3-thread")))
  (insert "test-dymod-wait3-thread in emacs."))

(provide 'test)
;;; test.el ends here
