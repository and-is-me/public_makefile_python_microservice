# Repo for copypasta Makefile to projects

here is a doc to Makefile doc 
https://www.gnu.org/software/make/manual/make.html

# Usage

for ussage there must be file
.project 
```
PROJECT_NAME=replace_project_name
ENV_PATH=replace_project/env_path
```

after copy visit Makefile, check `prepare` instruction, you might would like to set another python version

# Copy

copy and paste command in terminal 



### github

via ssh
```bash
git fetch git@github.com:and-is-me/public_makefile_python_microservice.git main:public_makefile_python_microservice
git checkout public_makefile_python_microservice -- project.mk
mv  "project.mk" "Makefile"
git add Makefile
git commit -m "grabbed project.mk->Makefile from public_makefile_python_microservice repo"
git push
git remote remove public_makefile_python_microservice
```

via https
```bash
git fetch https://github.com/and-is-me/public_makefile_python_microservice.git main:public_makefile_python_microservice
git checkout public_makefile_python_microservice -- project.mk
mv  "project.mk" "Makefile"
git add Makefile
git commit -m "grabbed project.mk->Makefile from public_makefile_python_microservice repo"
git push
git remote remove public_makefile_python_microservice
```


### gitlab

via ssh
```bash
git archive --remote=git@gitlab.com:and_me_group_submodules/public_makefile_python_microservice.git main project.mk | tar xvf -
mv  "project.mk" "Makefile"
git commit -m "grabbed project.mk->Makefile from public_makefile_python_microservice repo"
git push
```
