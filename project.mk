
ifneq (,$(wildcard ./.project))
    include .project
    export
endif

PROJECT_NAME_=${PROJECT_NAME}
ENV_PATH_=/opt/${ENV_PATH}
ACTIVATE=$(ENV_PATH_)/venv/bin/activate

help:		## - display all commands
	@echo "PROJECT_NAME is = ${PROJECT_NAME_}"
	@echo "ENV_PATH = ${ENV_PATH}"
	@echo "full ENV_PATH = ${ENV_PATH_}"
	@echo "source $(ACTIVATE)"
	@echo ""
	@echo "Commands:"
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
venv: 	## - prepare env and install requirements
	mkdir -p ${ENV_PATH_}
	python3 -m venv ${ENV_PATH_}/venv
	. $(ACTIVATE); pip3 install --upgrade pip
	make install
install: 	## - install requirements
	. $(ACTIVATE); pip install -r src/requirements.txt
i: install
uninstall: 	## - uninstall all dependencies
	 pip freeze | xargs pip uninstall --yes
style_check:	## - check style
	echo "run style ruff  check"
	. $(ACTIVATE); ruff check
style:		## - format style
	@echo "run style ruff format"
	. $(ACTIVATE); @ruff format

migrations:
	echo 'Upgrade "migrations" command' > logfile.log
	exit 125
	@#litestar --app-dir src database make-migrations
	@#alembic revision --autogenerate
	@#alembic revision --autogenerate -m  "init"
mig: migrations	## - make migrations
migrate:
	@echo 'Upgrade "migrate" command' > logfile.log
	exit 125
	#litestar database upgrade --no-prompt
	#litestar --app-dir src database upgrade head
	@litestar --app-dir src database upgrade --no-prompt
	#litestar --app-dir src run
m: migrate		## - migrate
downgrade:		## - downgrade migrations
	echo 'Upgrade "downgrade" command' > logfile.log
	exit 125
	@litestar --app-dir src database downgrade --no-prompt
	#@alembic downgrade -1
	#@alembic history
	#@alembic downgrade 8ac14e223d1e
run:		## - run sync server
	. $(ACTIVATE); src/manage.py runserver 18040
arun:		## - run async server
	echo "uvicorn runserver"
	.$(ACTIVATE); PYTHONDONTWRITEBYTECODE=1 uvicorn --app-dir src app:app --reload --port 18050
	litestar --app-dir src run --port 18050

tbot:		## - run telegram bot
	echo "start telegram bot prod"
	. $(ACTIVATE); ENV=prod python src/bot/main.py

copy_gitignore:	## - copy .gitignore file from public_gitignore repo
	git fetch git@github.com:and-is-me/public_gitignore.git main:public_gitignore
	git checkout public_gitignore -- .gitignore
	git commit -m "Grabbed .gitignore from public_gitignore.git"
	git push
