resource "null_resource" "install_layer_deps" {
  triggers = {
    layer_build = filemd5("${path.module}/../../../../serverless-api/Pocgame-layer-1/nodejs/package.json")
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../../../serverless-api/Pocgame-layer-1/nodejs"
    command     = "npm install"
  }
}

data "archive_file" "pocGameLayerDefinition" {
  type        = "zip"
  output_path = "${path.module}/../../../../serverless-api/build/pocGameLayer/poc-game-layer.zip"
  source_dir  = "${path.module}/../../../../serverless-api/Pocgame-layer-1"

  depends_on = [null_resource.install_layer_deps]
}

resource "aws_lambda_layer_version" "pocGameLayer" {
  layer_name          = "poc-game-layer"
  description         = "pocGameLayer:^1.0.0"
  filename            = data.archive_file.pocGameLayerDefinition.output_path
  source_code_hash    = data.archive_file.pocGameLayerDefinition.output_base64sha256
  compatible_runtimes = ["nodejs14.x"]
}