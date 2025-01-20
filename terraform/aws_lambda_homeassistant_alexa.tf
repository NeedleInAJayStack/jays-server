# Source: https://www.home-assistant.io/integrations/alexa.smart_home/#requirements

resource "aws_iam_role" "homeasssistant_lambda" {
  name = "AWSLambdaBasicExecutionRole-SmartHome"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com"
          ]
        }
      }
    ]
  })
}

data "archive_file" "homeassistant_lambda" {
  type        = "zip"
  source_file = "homeassistant_lambda.py"
  output_path = "homeassistant_lambda_function_payload.zip"
}

resource "aws_lambda_function" "homeassistant" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.homeassistant_lambda.output_path
  function_name = "homeassistant_lambda"
  role          = aws_iam_role.homeasssistant_lambda.arn
  handler       = "homeassistant_lambda.lambda_handler"

  source_code_hash = data.archive_file.homeassistant_lambda.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {
      BASE_URL = "https://home.herron.dev"
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.homeassistant.function_name
  principal     = "alexa-connectedhome.amazon.com"

  event_source_token = "amzn1.ask.skill.345bd3ae-aa02-4e36-8bed-0a1e7531dc32"
}
