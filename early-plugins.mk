# Copyright (c) 2017-2019, Loïc Hoguin <essen@ninenines.eu>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# We do not keep track of anything below patch releases.
# They are meant for OTP customers, are not announced
# and do not come with an easy to read changelog. They
# are also unlikely to be used by anyone other than
# OTP customers.
#
# Patch releases are announced on erlang-questions,
# and add a third component to the version number.
# A fourth component is also added once the next
# major release is out.

OTP-18 := OTP-18.0.3 OTP-18.1.5 OTP-18.2.4 OTP-18.3.4.11
OTP-19 := OTP-19.0.7 OTP-19.1.6 OTP-19.2.3 OTP-19.3.6.13
OTP-20 := OTP-20.0.5 OTP-20.1.7 OTP-20.2.4 OTP-20.3.8.23
OTP-21 := OTP-21.0.9 OTP-21.1.4 OTP-21.2.7 OTP-21.3.8.8
OTP-22 := OTP-22.0.7 OTP-22.1.3

OTP-18+ := $(OTP-18) $(OTP-19) $(OTP-20) $(OTP-21) $(OTP-22)
OTP-19+ := $(OTP-19) $(OTP-20) $(OTP-21) $(OTP-22)
OTP-20+ := $(OTP-20) $(OTP-21) $(OTP-22)
OTP-21+ := $(OTP-21) $(OTP-22)
OTP-22+ := $(OTP-22)

OTP-LATEST-18+ := $(lastword $(OTP-18)) $(lastword $(OTP-19)) \
	$(lastword $(OTP-20)) $(lastword $(OTP-21)) $(lastword $(OTP-22))
OTP-LATEST-19+ := $(lastword $(OTP-19)) $(lastword $(OTP-20)) \
	$(lastword $(OTP-21)) $(lastword $(OTP-22))
OTP-LATEST-20+ := $(lastword $(OTP-20)) $(lastword $(OTP-21)) $(lastword $(OTP-22))
OTP-LATEST-21+ := $(lastword $(OTP-21)) $(lastword $(OTP-22))
OTP-LATEST-22+ := $(lastword $(OTP-22))

# We exclude release candidates here because they are not
# the latest release, they are the *next* one.

OTP-LATEST := $(lastword $(foreach rel,$(OTP-18+),$(if $(findstring -rc,$(rel)),,$(rel))))

# Older OTP versions that this plugin previously supported
# are listed here. This list is used to cleanup builds and
# installations that we do not care about anymore.

OTP-18-DROPPED := OTP-18.3.4 OTP-18.3.4.6 OTP-18.3.4.7 OTP-18.3.4.8 \
	 OTP-18.3.4.9 OTP-18.3.4.10
OTP-19-DROPPED := OTP-19.3.6 OTP-19.3.6.3 OTP-19.3.6.4 OTP-19.3.6.5 \
	OTP-19.3.6.6 OTP-19.3.6.7 OTP-19.3.6.8 OTP-19.3.6.9 OTP-19.3.6.10 \
	OTP-19.3.6.11 OTP-19.3.6.12
OTP-20-DROPPED := OTP-20.1.5 OTP-20.1.6 OTP-20.2 OTP-20.2.1 OTP-20.2.2 \
	OTP-20.2.3 OTP-20.3 OTP-20.3.2 OTP-20.3.3 OTP-20.3.4 OTP-20.3.5 \
	OTP-20.3.6 OTP-20.3.7 OTP-20.3.8 OTP-20.3.8.1 OTP-20.3.8.2 \
	OTP-20.3.8.3 OTP-20.3.8.5 OTP-20.3.8.6 OTP-20.3.8.7 OTP-20.3.8.8 \
	OTP-20.3.8.9 OTP-20.3.8.10 OTP-20.3.8.11 OTP-20.3.8.12 OTP-20.3.8.13 \
	OTP-20.3.8.14 OTP-20.3.8.15 OTP-20.3.8.16 OTP-20.3.8.17 OTP-20.3.8.18 \
	OTP-20.3.8.19 OTP-20.3.8.20 OTP-20.3.8.22
OTP-21-DROPPED := OTP-21.0-rc1 OTP-21.0-rc2 OTP-21.0 OTP-21.0.1 OTP-21.0.2 \
	OTP-21.0.3 OTP-21.0.4 OTP-21.0.5 OTP-21.0.6 OTP-21.0.7 OTP-21.0.8 \
	OTP-21.1 OTP-21.1.1 OTP-21.1.2 OTP-21.1.3 OTP-21.2 OTP-21.2.1 \
	OTP-21.2.2 OTP-21.2.3 OTP-21.2.4 OTP-21.2.5 OTP-21.2.6 OTP-21.3 \
	OTP-21.3.1 OTP-21.3.2 OTP-21.3.3 OTP-21.3.4 OTP-21.3.5 OTP-21.3.6 \
	OTP-21.3.7 OTP-21.3.8 OTP-21.3.8.1 OTP-21.3.8.2 OTP-21.3.8.3 OTP-21.3.8.4 \
	OTP-21.3.8.5 OTP-21.3.8.6 OTP-21.3.8.7
OTP-22-DROPPED := OTP-22.0-rc1 OTP-22.0-rc2 OTP-22.0-rc3 OTP-22.0 \
	OTP-22.0.1 OTP-22.0.2 OTP-22.0.3 OTP-22.0.4 OTP-22.0.5 OTP-22.0.6 \
	OTP-22.1 OTP-22.1.1 OTP-22.1.2

OTP-DROPPED := $(OTP-18-DROPPED) $(OTP-19-DROPPED) $(OTP-20-DROPPED) \
	$(OTP-21-DROPPED) $(OTP-22-DROPPED)

# Configure Erlang.mk's CI plugin.

CI_OTP := $(foreach otp,$(AUTO_CI_OTP),$($(otp))) $(if $(AUTO_CI_MASTER),master)

# Disable HiPE builds; Erlang/OTP's HiPE support is broken
# starting from Erlang/OTP 22.0.6. Use explicit versions instead.
#CI_HIPE := $(foreach otp,$(AUTO_CI_HIPE),$($(otp)))
#CI_ERLLVM := $(foreach otp,$(AUTO_CI_ERLLVM),$($(otp)))

# Remove the existing master if necessary.

ifdef AUTO_CI_MASTER

ifeq ($(AUTO_CI_MASTER),daily)
AUTO_CI_MASTER_MINS = 1440
else
ifeq ($(AUTO_CI_MASTER),weekly)
AUTO_CI_MASTER_MINS = 10080
else
ifeq ($(AUTO_CI_MASTER),monthly)
AUTO_CI_MASTER_MINS = 43200
endif
endif
endif

ifdef AUTO_CI_MASTER_MINS
ci:: $(KERL)
ifneq ($(wildcard $(KERL_INSTALL_DIR)/master),)
	$(verbose) if find $(KERL_INSTALL_DIR)/master/activate \
			-mmin +$(AUTO_CI_MASTER_MINS) | grep -q master; then \
		$(KERL) delete build master || true; \
		$(KERL) delete installation master || true; \
	fi
endif
endif

endif

# Cleanup older OTP versions we don't care about anymore.

CI_AUTO_CLEANUP_TARGETS := $(foreach t,$(OTP-DROPPED),ci-auto-cleanup-$t)

.PHONY: ci-auto-cleanup $(CI_AUTO_CLEANUP_TARGETS)

define ci_auto_cleanup_target
ci-auto-cleanup-$1: $(KERL)
	$(verbose) $(KERL) list builds | grep -q "^git,$1$$$$" && $(KERL) delete build $1 || true
	$(verbose) $(KERL) list installations | grep -q "^$1 " && $(KERL) delete installation $1 || true
	$(verbose) $(KERL) list builds | grep -q "^git,$1-native$$$$" && $(KERL) delete build $1-native || true
	$(verbose) $(KERL) list installations | grep -q "^$1-native " && $(KERL) delete installation $1-native || true
	$(verbose) $(KERL) list builds | grep -q "^git,$1-erllvm$$$$" && $(KERL) delete build $1-erllvm || true
	$(verbose) $(KERL) list installations | grep -q "^$1-erllvm " && $(KERL) delete installation $1-erllvm || true
endef

$(foreach t,$(OTP-DROPPED),$(eval $(call ci_auto_cleanup_target,$t)))

ci-auto-cleanup: $(CI_AUTO_CLEANUP_TARGETS)

# Erlang/OTP comes with Windows installers. They are more practical
# than compiling from source at the moment. We have a special target
# to perform CI using them.
#
# Right now we assume that the versions are already installed on
# the test machines. In the future we may want to also automate
# the installation.

ifeq ($(PLATFORM),msys2)

WINDOWS-OTP-18 := 18.0 18.1 18.2.1 18.3
WINDOWS-OTP-19 := 19.0 19.1 19.2 19.3
WINDOWS-OTP-20 := 20.0 20.1 20.2 20.3
WINDOWS-OTP-21 := 21.0.1 21.1 21.2 21.3
WINDOWS-OTP-22 := 22.0 22.1

WINDOWS-OTP-18+ := $(WINDOWS-OTP-18) $(WINDOWS-OTP-19) $(WINDOWS-OTP-20) $(WINDOWS-OTP-21) $(WINDOWS-OTP-22)
WINDOWS-OTP-19+ := $(WINDOWS-OTP-19) $(WINDOWS-OTP-20) $(WINDOWS-OTP-21) $(WINDOWS-OTP-22)
WINDOWS-OTP-20+ := $(WINDOWS-OTP-20) $(WINDOWS-OTP-21) $(WINDOWS-OTP-22)
WINDOWS-OTP-21+ := $(WINDOWS-OTP-21) $(WINDOWS-OTP-22)
WINDOWS-OTP-22+ := $(WINDOWS-OTP-22)

WINDOWS-OTP-LATEST-18+ := $(lastword $(WINDOWS-OTP-18)) $(lastword $(WINDOWS-OTP-19)) \
	$(lastword $(WINDOWS-OTP-20)) $(lastword $(WINDOWS-OTP-21)) $(lastword $(WINDOWS-OTP-22))
WINDOWS-OTP-LATEST-19+ := $(lastword $(WINDOWS-OTP-19)) $(lastword $(WINDOWS-OTP-20)) \
	$(lastword $(WINDOWS-OTP-21)) $(lastword $(WINDOWS-OTP-22))
WINDOWS-OTP-LATEST-20+ := $(lastword $(WINDOWS-OTP-20)) $(lastword $(WINDOWS-OTP-21)) \
	$(lastword $(WINDOWS-OTP-22))
WINDOWS-OTP-LATEST-21+ := $(lastword $(WINDOWS-OTP-21)) $(lastword $(WINDOWS-OTP-22))
WINDOWS-OTP-LATEST-22+ := $(lastword $(WINDOWS-OTP-22))

WINDOWS-OTP-LATEST := $(lastword $(WINDOWS-OTP-18+))

msys2_path = $(shell cygpath -u $1)

WINDOWS-OTP-18.0-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl7.0/bin)
WINDOWS-OTP-18.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl7.1/bin)
WINDOWS-OTP-18.2.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl7.2.1/bin)
WINDOWS-OTP-18.3-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl7.3/bin)

WINDOWS-OTP-19.0-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl8.0/bin)
WINDOWS-OTP-19.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl8.1/bin)
WINDOWS-OTP-19.2-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl8.2/bin)
WINDOWS-OTP-19.3-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl8.3/bin)

WINDOWS-OTP-20.0-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl9.0/bin)
WINDOWS-OTP-20.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl9.1/bin)
WINDOWS-OTP-20.2-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl9.2/bin)
WINDOWS-OTP-20.3-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl9.3/bin)

WINDOWS-OTP-21.0.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.0.1/bin)
WINDOWS-OTP-21.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.1/bin)
WINDOWS-OTP-21.2-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.2/bin)
WINDOWS-OTP-21.3-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.3/bin)

WINDOWS-OTP-22.0-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.4/bin)
WINDOWS-OTP-22.1-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.5/bin)

# We have to duplicate this for it to work as
# it is not yet defined when we define this.
ci_windows_verbose_0 = @echo " CI    " $(1);
ci_windows_verbose = $(ci_windows_verbose_$(V))

define ci_windows_target
ci-windows-$1:
	$(verbose) $(MAKE) --no-print-directory clean
	$(ci_windows_verbose) \
		PATH="$(WINDOWS-OTP-$1-INSTALL-DIR):$(PATH)" \
		CI_OTP_RELEASE="$1" \
		CT_OPTS="-label $1" \
		CI_VM="otp" \
		$(MAKE) ci-setup tests
	$(verbose) $(MAKE) --no-print-directory ci-extra
endef

CI_WINDOWS := $(foreach otp,$(AUTO_CI_WINDOWS),$(WINDOWS-$(otp)))

$(foreach otp,$(CI_WINDOWS),$(eval $(call ci_windows_target,$(otp))))

ci-windows:: $(addprefix ci-windows-,$(CI_WINDOWS))

endif
