;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — esn

(ecosystem
  (version "1.0.0")
  (name "esn")
  (type "project")
  (purpose "A Rust implementation of Echo State Networks (reservoir computing) for time series prediction and classification.")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "A Rust implementation of Echo State Networks (reservoir computing) for time series prediction and classification.")
  (what-this-is-not "- NOT exempt from RSR compliance"))
