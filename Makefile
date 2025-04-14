REPO_DIR = $(shell git rev-parse --show-toplevel)
APPS = $(foreach app_dir,$(dir $(wildcard ${REPO_DIR}/*/apps.py)),$(patsubst ${REPO_DIR}/%/,%,$(app_dir)))
APP_PATH_DIRS = $(dir $(abspath $(wildcard ${REPO_DIR}/*/apps.py)))
PY_DIRS = mysite ${APP_DIRS}
MANAGE_PY = ${REPO_DIR}/manage.py
PYTHON = python

DJANGO_ADMIN_TARGETS = AUTH CONTENTTYPE DEBUG_TOOLBAR DJANGO SESSIONS STATICFILES
DJANGO_ADMIN_AUTH_TARGETS = changepassword createsuperuser
DJANGO_ADMIN_CONTENTTYPE_TARGETS = remove_stale_contenttypes
DJANGO_ADMIN_DEBUG_TOOLBAR_TARGETS = debugsqlshell
DJANGO_ADMIN_DJANGO_TARGETS = check compilemessages createcachetable dbshell diffsettings dumpdata flush inspectdb loaddata makemessages makemigrations migrate optimizemigration sendtestemail shell showmigrations sqlflush sqlmigrate sqlsequencereset squashmigrations startapp startproject test testserver
DJANGO_ADMIN_SESSIONS_TARGETS = clearsessions
DJANGO_ADMIN_STATICFILES_TARGETS = collectstatic findstatic runserver

runserver_PREQUISITES = test
test_PREQUISITES = migrate
migrate_PREQUISITES = makemigrations
makemigrations_PREQUISITES = check
sqlmigrate_PREQUISITES = check

shell_REQ_ARGS = -v 2
makemigrations_REQ_ARGS = $(APPS)
optimizemigration_REQ_ARGS = $(APPS)

makemigrations_IGNORE_ARGS := 1

# Setting default goal
all: runserver

# Append all django-admin command sections to the top-level variable
define TARGET_TEMPLATE =
	DJANGO_MANAGE_PY_TARGETS += $$(DJANGO_ADMIN_$(1)_TARGETS)
endef
# Do it now.
$(foreach target,$(DJANGO_ADMIN_TARGETS),$(eval $(call TARGET_TEMPLATE,$(target))))

# Validate input
TARGETS :::= all clean ${DJANGO_MANAGE_PY_TARGETS}
ARGS :::= $(filter-out $(TARGETS), $(MAKECMDGOALS))
.PHONY = $(TARGETS) $(ARGS)
ifneq ($(MAKECMDGOALS),)
	.DEFAULT_GOAL :::= $(firstword $(filter $(TARGETS), $(MAKECMDGOALS)) all)
endif

# Compute the rule recipe for each django_admin command
define RULE_TEMPLATE =
ifeq ($$($(1)_IGNORE_ARGS),)
	$(1)_REQ_ARGS += $(ARGS)
endif
$(1): $$($(1)_PREQUISITES) ${MANAGE_PY}
	@echo "Running target: $(1)"
	${PYTHON} ${MANAGE_PY} $(1) $${${1}_REQ_ARGS}
endef
# Do it now.
$(foreach target,$(DJANGO_MANAGE_PY_TARGETS),$(eval $(call RULE_TEMPLATE,$(target))))

clean:
	@echo "Cleaning up..."
	-rmdir /s /q $(foreach dir, ${PY_DIRS}, ${dir}\__pycache__)

${ARGS}:
	-@echo.>nul