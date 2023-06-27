output "user_name" {
  description = "IAM user name"
  value       = join(" ", aws_iam_user.demo.*.name)
}

output "user_arn" {
  value = aws_iam_user.demo.*.arn
}