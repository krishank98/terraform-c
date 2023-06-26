output "user_name" {
  description = "IAM user name"
  value       = join(" ", aws_iam_user.developer.*.name)
}
