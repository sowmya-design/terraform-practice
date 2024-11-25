resource "aws_s3_bucket" "example" {
  bucket = "aarviiii"
  
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "yuvan-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}