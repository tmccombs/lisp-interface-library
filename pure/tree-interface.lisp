;;; -*- Mode: Lisp ; Base: 10 ; Syntax: ANSI-Common-Lisp -*-
;;;;; Pure trees - interface

#+xcvb (module (:depends-on ("pure/map-interface")))

(in-package :pure)

;;; Trees in general

(define-interface <tree> (interface::<tree> <map>) ()
  (:documentation "abstract interface for trees"))

;;; Vanilla Binary Tree

(define-interface <binary-tree>
    (<tree>
     map-simple-empty ;; handles all the null cases so we don't have to.
     map-simple-decons map-simple-update-key
     map-simple-join map-simple-map/2 map-simple-join/list
     map-size-from-fold-left)
  ()
  (:documentation "Keys in binary trees increase from left to right"))

(defclass association-pair (interface::association-pair)
  ())

(defclass binary-tree-node (interface::binary-tree-node association-pair)
  ;;; Or should we have a box instead of an association-pair ???
  ;;; Or let the user just inherit from binary-branch,
  ;;; and use a node-interface with make and update?
  ((left :initform nil)
   (right :initform nil)))

;;; pure AVL-tree

(define-interface <avl-tree> (<binary-tree> interface::<avl-tree>) ())

(defclass avl-tree-node (interface::avl-tree-node binary-tree-node)
  ())

;;; Common special case: when keys are (real) numbers
(define-interface <number-map> (<avl-tree> interface::<number-map>)
  ()
  (:singleton))

(defparameter <nm> <number-map>)