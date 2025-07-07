
help:	## - show this help
	@echo ""
	@echo "Commands:"
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)
	@echo ""
	@echo "Commands of project:"
	@sed -ne '/@sed/!s/## //p' project.mk
	@echo ""

push:	## - push
	git add .
	git commit -m "💾"
	git push gitlab
	git push github
