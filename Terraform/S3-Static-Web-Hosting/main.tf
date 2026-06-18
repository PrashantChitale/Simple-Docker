provider "aws" {
    region = "ap-south-1"
}

resource "aws_s3_bucket" "my-s3-buket" {
    bucket = "my-static-website-bucket-712394252404"
}

resource "aws_s3_bucket_website_configuration" "my-website" {
  bucket = aws_s3_bucket.my-s3-buket.id
  
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "Pub-access" {
  bucket = aws_s3_bucket.my-s3-buket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.my-s3-buket.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.my-s3-buket.arn}/*"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.Pub-access]
}
    

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.my-s3-buket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

