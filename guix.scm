;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell

;;; guix.scm — Guix package definition for esn
;;; Reference: https://guix.gnu.org/manual/en/html_node/Defining-Packages.html

(use-modules (guix packages)
             (guix download)
             (guix git-download)
             (guix build-system cargo)
             (guix licenses)
             ((guix licenses) #:prefix license:)
             (gnu packages crates-io)
             (gnu packages rust))

;;; Development shell for local builds
;;; Usage: guix shell -D -f guix.scm
(define-public esn
  (package
    (name "esn")
    (version "0.1.0")
    (source (local-file "." "esn-checkout"
                        #:recursive? #t
                        #:select? (git-predicate ".")))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-ndarray" ,rust-ndarray-0.15)
        ("rust-ndarray-rand" ,rust-ndarray-rand-0.14)
        ("rust-rand" ,rust-rand-0.8)
        ("rust-rand-distr" ,rust-rand-distr-0.4)
        ("rust-rayon" ,rust-rayon-1)
        ("rust-serde" ,rust-serde-1)
        ("rust-thiserror" ,rust-thiserror-1)
        ("rust-tracing" ,rust-tracing-0.1))
       #:cargo-development-inputs
       (("rust-approx" ,rust-approx-0.5))
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'set-env
           (lambda _
             (setenv "CARGO_HOME" (getcwd))
             #t)))))
    (native-inputs
     (list rust))
    (home-page "https://github.com/hyperpolymath/esn")
    (synopsis "Echo State Network - Reservoir Computing library in Rust")
    (description
     "A Rust implementation of Echo State Networks (reservoir computing)
for time series prediction and classification.  Features include sparse
reservoir generation, leaky integrator neurons, ridge regression training,
and hierarchical ESN support.")
    (license (list license:expat license:agpl3+))))

;;; For development: guix shell -D -f guix.scm
esn
