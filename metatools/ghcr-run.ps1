$gitUserName = try { git config user.name } catch { "" }
$gitUserEmail = try { git config user.email } catch { "" }

docker run --rm -it `
  -v "$($PWD.Path):/work" -w /work `
  -e "GIT_USER_NAME=$gitUserName" `
  -e "GIT_USER_EMAIL=$gitUserEmail" `
  ghcr.io/kjetiljd/meta-repo-workshop-tools:latest bash

