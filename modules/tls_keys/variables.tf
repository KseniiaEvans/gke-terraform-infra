variable "algorithm" {
  type        = string
  default     = "ECDSA"
  description = "RSA or ECDSA"
}

variable "ecdsa_curve" {
  type        = string
  default     = "P256"
  description = "ECDSA curve if algorithm=ECDSA"
}
