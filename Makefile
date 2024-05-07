# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rishmor <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/07 10:30:34 by rishmor           #+#    #+#              #
#    Updated: 2024/05/07 10:30:36 by rishmor          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#* *************************************************************************** *#
#* *                            GENERAL INFO                                 * *#
#* *************************************************************************** *#

NAME						:=				libasm
LIB_NAME					:=				$(NAME).a
TESTER_EXECUTABLE_NAME		:=				libasm-tester

#* *************************************************************************** *#
#* *                          COMPILATION_UTILS                              * *#
#* *************************************************************************** *#

CC							:=				gcc
ASM							:=				nasm
AR							:=				ar rcs

CC_FLAGS					:=				-Wall -Wextra -Werror
ASM_FLAGS					:=				-f elf64

LIBRARY_FLAGS				:=				-L. -lasm # -lasm looks for libasm.a file by convention

#* *************************************************************************** *#
#* *                                 FILES                                   * *#
#* *************************************************************************** *#

SOURCES_PATH				:=				./srcs
OBJECTS_PATH				:=				./objs
HEADERS_PATH				:=				./includes

CC_EXTENSION				:=				.c
ASM_EXTENSION				:=				.s

#* ASM SOURCES *#

ASM_SOURCES_NAMES			:=				ft_read \
											ft_strcmp \
											ft_strcpy \
											ft_strdup \
											ft_strlen \
											ft_write \

ASM_SOURCES_NAMES_BONUS		:=				\

ifeq (bonus, $(filter bonus, $(MAKECMDGOALS)))
	ASM_SOURCES_NAMES		+=				$(ASM_SOURCES_NAMES_BONUS)
endif

SORTED_ASM_SOURCES_NAMES	:=				$(sort $(ASM_SOURCES_NAMES))
ASM_SOURCES					:=				$(addsuffix $(ASM_EXTENSION), $(SORTED_ASM_SOURCES_NAMES))

#* CC SOURCES *#

CC_SOURCES_NAMES			:=				tester/main \

SORTED_CC_SOURCES_NAMES		:=				$(sort $(CC_SOURCES_NAMES))
CC_SOURCES					:=				$(addsuffix $(CC_EXTENSION), $(SORTED_CC_SOURCES_NAMES))

#* OBJECTS *#

ASM_OBJECTS					:=				$(addprefix $(OBJECTS_PATH)/, $(ASM_SOURCES:$(ASM_EXTENSION)=.o))
CC_OBJECTS					:=				$(addprefix $(OBJECTS_PATH)/, $(CC_SOURCES:$(CC_EXTENSION)=.o))

#* CC HEADERS *#

HEADERS_PATH		:=		./includes
INCLUDE_FLAGS		:=		$(addprefix -I , $(HEADERS_PATH))

#* CC DEPENDENCIES *#

CC_DEPENDENCIES				:=				$(CC_OBJECTS:.o=.d)

#* *************************************************************************** *#
#* *                              CONSTANTS                                  * *#
#* *************************************************************************** *#

# Text formatting
BOLD						:=				\033[1m
ITALIC						:=				\033[3m
UNDERLINE					:=				\033[4m
STRIKETHROUGH				:=				\033[9m

# Color codes
RED							:=				\033[0;31m
GREEN						:=				\033[0;32m
YELLOW						:=				\033[0;33m
BLUE						:=				\033[0;34m
PURPLE						:=				\033[0;35m
CYAN						:=				\033[0;36m
WHITE						:=				\033[0;37m
RESET						:=				\033[0m

#* *************************************************************************** *#
#* *                               MESSAGES                                  * *#
#* *************************************************************************** *#

define linking_success_message
	echo "✨ $(BOLD)$(GREEN)LINKAGE SUCCESSFUL$(RESET) ✨"
endef

define compilation_success_message
	echo "✨ $(BOLD)$(GREEN)COMPILATION SUCCESSFUL$(RESET) ✨"
endef

define linking_message
	echo "🔧 $(YELLOW)Linking $(BOLD)$(CYAN)$@ $(RESET)$(YELLOW)...$(RESET) 🔧"
endef

define compilation_message
	echo "🔧 $(YELLOW)Linking $(BOLD)$(CYAN)$@ $(RESET)$(YELLOW)...$(RESET) 🔧"
endef

#* Deletion *#

define del_library
	echo "❌ $(RED)Deleting $(BOLD)$(LIB_NAME)$(RESET) $(RED)library$(RESET)"
endef

define del_objs_folder
	echo "❌ $(RED)Deleting $(BOLD)$(OBJECTS_PATH)$(RESET) $(RED)folder$(RESET)"
endef

define del_exec
	echo "❌ $(RED)Deleting $(BOLD)$(TESTER_EXECUTABLE_NAME)$(RESET) $(RED)executable$(RESET)"
endef

#* Structured compilation message *#

LAST_DIRECTORY :=

define compile_message
	@if [ "$(dir $<)" != "$(LAST_DIRECTORY)" ]; then \
		echo "$(CYAN)$(ITALIC)Compiling files in directory $(BOLD)$(dir $<)$(RESET)"; \
		LAST_DIRECTORY="$(dir $<)"; \
	fi
	@echo "    $(YELLOW)•$(RESET) $(CYAN)$(notdir $<)$(RESET)";
	$(eval LAST_DIRECTORY := $(dir $<))
endef

#* *************************************************************************** *#
#* *                                 RULES                                   * *#
#* *************************************************************************** *#

all: $(NAME)

$(NAME): $(ASM_OBJECTS)
	@$(call linking_message)
	@$(AR) $(LIB_NAME) $(ASM_OBJECTS)
	@$(call linking_success_message)

bonus: all

-include $(CC_DEPENDENCIES)
tester: all $(CC_OBJECTS)
	@$(call linking_message)
	@$(CC) $(CC_FLAGS) $(INCLUDE_FLAGS) -o $(TESTER_EXECUTABLE_NAME) $(CC_OBJECTS) $(LIBRARY_FLAGS)
	@$(call linking_success_message)

$(OBJECTS_PATH)/%.o: $(SOURCES_PATH)/%$(ASM_EXTENSION)
	@mkdir -p $(dir $@)
	@$(call compile_message)
	@$(ASM) $(ASM_FLAGS) $< -o $@

$(OBJECTS_PATH)/%.o: $(SOURCES_PATH)/%$(CC_EXTENSION)
	@mkdir -p $(dir $@)
	@$(call compile_message)
	@$(CC) $(CC_FLAGS) -MMD -MF $(@:.o=.d) $(INCLUDE_FLAGS) -c $< -o $@

clean:
	@if [ -d $(OBJECTS_PATH) ]; then \
		$(call del_objs_folder); \
		rm -rf $(OBJECTS_PATH); \
	fi

fclean: clean
	@if [ -f $(LIB_NAME) ]; then \
		$(call del_library); \
		rm -f $(LIB_NAME); \
	fi
	@if [ -f $(TESTER_EXECUTABLE_NAME) ]; then \
		$(call del_exec); \
		rm -f $(TESTER_EXECUTABLE_NAME); \
	fi

re: fclean all

#* Conflicts protection *#

.PHONY: bonus tester clean fclean re
