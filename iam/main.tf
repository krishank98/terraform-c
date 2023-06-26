resource "aws_iam_user" "developer" {
    count = "${length(var.username)}"
    name="${element(var.username,count.index)}"
}