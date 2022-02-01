resource "heroku_app" "my_app" {
  name   = "my-test-app-terraform"
  region = "us"

  buildpacks = [
    "heroku/python"
  ]
}

resource "heroku_addon" "prd_db" {
  app  = heroku_app.my_app.name
  plan = "heroku-postgresql:hobby-dev"
  name = "myapp-prd-db"
}

resource "heroku_addon" "dev_db" {
  app  = heroku_app.my_app.name
  plan = "heroku-postgresql:hobby-dev"
  name = "myapp-dev-db"
}

resource "heroku_addon_attachment" "prd_database" {
  app_id   = heroku_app.my_app.id
  addon_id = heroku_addon.prd_db.id
  name     = "myapp_prd_db"
}

resource "heroku_addon_attachment" "dev_database" {
  app_id   = heroku_app.my_app.id
  addon_id = heroku_addon.dev_db.id
  name     = "myapp_prd_db"
}
