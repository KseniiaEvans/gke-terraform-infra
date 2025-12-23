resource "tls_private_key" "this" {
  algorithm   = var.algorithm
  ecdsa_curve = var.algorithm == "ECDSA" ? var.ecdsa_curve : null
}
