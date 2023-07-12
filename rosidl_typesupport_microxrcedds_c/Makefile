SHELL = /bin/zsh
PWD_DIR = "$(shell basename $$(pwd))"
BUILD_DIR = build

# ==================================
# Pushes the current directory to remote host.
# ==================================

NUM_PROCS = 4
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
clean:
	rm -rf $(BUILD_DIR)
	sudo rm -rf /usr/local/lib/rosidl_typesupport_microxrcedds_c/rosidl_typesupport_microxrcedds_c
	sudo rm -rf /usr/local/lib/librosidl_typesupport_microxrcedds_c.a
	sudo rm -rf /usr/local/share/rosidl_typesupport_microxrcedds_c
	sudo rm -rf /usr/local/include/rosidl_typesupport_microxrcedds_c

# ==================================
# Build
# ==================================

.PHONY: build
build:
	CC=aarch64-none-elf-gcc CXX=aarch64-none-elf-g++ \
		cmake -S . -B $(BUILD_DIR) \
			-DCMAKE_C_COMPILER_WORKS=1 \
			-DCMAKE_CXX_COMPILER_WORKS=1 \
			-DCMAKE_MODULE_PATH=./
	cd $(BUILD_DIR) && $(MAKE) -j $(NUM_PROCS)
	# Install so that we can use the library in other projects.
	cd $(BUILD_DIR) && sudo $(MAKE) install

#	Install the project...
#    -- Install configuration: ""
#    -- Installing: /usr/local/lib/rosidl_typesupport_microxrcedds_c/rosidl_typesupport_microxrcedds_c
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/cmake
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/cmake/rosidl_typesupport_microxrcedds_c_generate_interfaces.cmake
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/msg__rosidl_typesupport_microxrcedds_c.h.em
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/srv__type_support_c.c.em
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/idl__type_support_c.c.em
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/msg__type_support_c.c.em
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/srv__rosidl_typesupport_microxrcedds_c.h.em
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/idl__rosidl_typesupport_microxrcedds_c.h.em
#    -- Installing: /usr/local/share/rosidl_typesupport_microxrcedds_c/resource/rosidl_typesupport_microxrcedds_c__visibility_control.h.in
#    -- Up-to-date: /usr/local/include
#    -- Installing: /usr/local/include/rosidl_typesupport_microxrcedds_c
#    -- Installing: /usr/local/include/rosidl_typesupport_microxrcedds_c/identifier.h
#    -- Installing: /usr/local/include/rosidl_typesupport_microxrcedds_c/message_type_support.h
#    -- Installing: /usr/local/include/rosidl_typesupport_microxrcedds_c/service_type_support.h
#    -- Installing: /usr/local/include/rosidl_typesupport_microxrcedds_c/visibility_control.h
#    -- Installing: /usr/local/lib/librosidl_typesupport_microxrcedds_c.a