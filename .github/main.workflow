workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Pages Deploy"]
}

action "Target the correct branch" {
  uses = "actions/bin/filter@46ffca7632504e61db2d4cb16be1e80f333cb859"
  args = "branch source"
}

action "Install dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Target the correct branch"]
  args = "i"
}

action "GitHub Action for npm" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Install dependencies"]
  args = "run build"
}

action "GitHub Pages Deploy" {
  uses = "maxheld83/ghpages@v0.2.0"
  env = {
    BUILD_DIR = "dist/"
  }
  needs = ["Target the correct branch"]
  secrets = ["GH_PAT"]
}
