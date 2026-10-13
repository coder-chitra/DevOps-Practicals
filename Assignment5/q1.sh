# clone
git clone https://github.com/octocat/Hello-World.git
cd Hello-World && ls -a && cd ..

# config
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global --list


# create new repo and commit
git clone https://github.com/<username>/devops-git-lab.git
cd devops-git-lab
echo "# devops-git-lab" > README.md
echo "This repository is used to practise Git and GitHub workflows for the DevOps-I lab course." >> README.md
git status
git add README.md
git commit -m "Update README to describe the purpose of the repository"

# pull
git pull origin main

# edit/change
echo "Added a simple web page." >> README.md
cat > index.html <<'EOF'
<!DOCTYPE html>
<html>
  <head><title>Git Lab</title></head>
  <body><h1>Hello from Git and GitHub</h1></body>
</html>
EOF
git add README.md index.html
git status
git commit -m "Add index.html and update README"

# git push

git push -u origin main