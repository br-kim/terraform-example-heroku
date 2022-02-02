resource "heroku_app" "my_app" {
  name   = "my-test-app-terraform"
  region = "us"

  buildpacks = [
    "heroku/python"
  ]
  config_vars = {
    FASTAPI_ENV = "production"
  }
}

resource "heroku_addon" "prd_db" {
  app  = heroku_app.my_app.name
  plan = "heroku-postgresql:hobby-dev"
  name = "myapp-prd-db"
}

resource "heroku_addon_attachment" "prd_database" {
  app_id   = heroku_app.my_app.id
  addon_id = heroku_addon.prd_db.id
  name     = "myapp_prd_db"
}
