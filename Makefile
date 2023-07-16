SHELL = /bin/zsh
PWD_DIR = "$(shell basename $$(pwd))"
BUILD_DIR = build
ROSIDL_TYPESUPPORT_MICROXRCEDDS_C_DIR = rosidl_typesupport_microxrcedds_c

# ==================================
# Pushes the current directory to remote host.
# ==================================

REMOTE_USER_HOST = "patrick@vm_comp4961_ubuntu1804"
REMOTE_DEST_DIR = "~/remote/$(shell hostname -s)/"

.PHONY: push-remote
push-remote:
	# Make the directory on the remote if it doesn't exist already.
	(ssh -t $(REMOTE_USER_HOST) "mkdir -p $(REMOTE_DEST_DIR)$(PWD_DIR)")
	# Sync our current directory with the remote.
	(rsync -a \
 			--delete \
 			--exclude "build" \
 			--exclude "build-remote" \
 			--exclude "cmake-build*" \
 			--exclude ".vscode" \
 			--exclude ".idea" \
 			--exclude ".git" \
 			--exclude ".gitignore" \
 			./ $(REMOTE_USER_HOST):$(REMOTE_DEST_DIR)$(PWD_DIR))

# ==================================
# Runs a Make command remotely.
# ==================================

.PHONY: remote
remote: push-remote
	ssh -t $(REMOTE_USER_HOST) "\
		cd $(REMOTE_DEST_DIR)$(PWD_DIR) ; \
		zsh -ilc 'make $(MAKE_CMD)' ; "

# ==================================
# Clean
# ==================================

.PHONY: clean
clean: clean-rosidl-typesupport-microxrcedds-c

.PHONY: clean-rosidl-typesupport-microxrcedds-c
clean-rosidl-typesupport-microxrcedds-c:
	$(MAKE) -C $(ROSIDL_TYPESUPPORT_MICROXRCEDDS_C_DIR) clean

# ==================================
# Build
# ==================================

.PHONY: build
build: build-rosidl-typesupport-microxrcedds-c

.PHONY: build-rosidl-typesupport-microxrcedds-c
build-rosidl-typesupport-microxrcedds-c:
	$(MAKE) -C $(ROSIDL_TYPESUPPORT_MICROXRCEDDS_C_DIR) build



