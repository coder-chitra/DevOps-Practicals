# C0: add an h1 tag in README.md
echo "<h1>Git Branching Lab</h1>" > README.md
git add README.md
git commit -m "C0: add h1 tag in README.md"

# C1: create a new txt file
echo "first line" > newfile.txt
git add newfile.txt
git commit -m "C1: create newfile.txt"

# C2: modify the txt file
echo "second line" >> newfile.txt
git commit -am "C2: modify newfile.txt"

git log --oneline --graph
git push origin main

git checkout -b iss53            # same as: git switch -c iss53
echo "<html><body><h2>Issue 53</h2></body></html>" > index.html
echo "Work on issue 53" >> README.md
git add index.html README.md
git commit -m "C3: create index.html and update README.md on iss53"

git log --oneline                # note the hashes of C1 and C2
git diff <C1-hash> <C2-hash>     # differences between commits C1 and C2
git diff main iss53              # differences between the two branches

git push -u origin iss53

git checkout main
git checkout -b hotfix
echo "urgent fix" >> newfile.txt
git commit -am "C4: update newfile.txt on hotfix"
git push -u origin hotfix

git checkout main
git merge iss53                   # three-way merge; editor opens for the merge commit message
git log --oneline --graph
git branch -d iss53
git push origin main
git push origin --delete iss53