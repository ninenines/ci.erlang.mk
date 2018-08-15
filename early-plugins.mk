# Copyright (c) 2017-2018, Loïc Hoguin <essen@ninenines.eu>
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

OTP-18 := OTP-18.0.3 OTP-18.1.5 OTP-18.2.4 OTP-18.3.4.9
OTP-19 := OTP-19.0.7 OTP-19.1.6 OTP-19.2.3 OTP-19.3.6.10
OTP-20 := OTP-20.0.5 OTP-20.1.7 OTP-20.2.4 OTP-20.3.8.6
OTP-21 := OTP-21.0.5

OTP-18+ := $(OTP-18) $(OTP-19) $(OTP-20) $(OTP-21)
OTP-19+ := $(OTP-19) $(OTP-20) $(OTP-21)
OTP-20+ := $(OTP-20) $(OTP-21)
OTP-21+ := $(OTP-21)

# We exclude release candidates here because they are not
# the latest release, they are the *next* one.

OTP-LATEST := $(lastword $(foreach rel,$(OTP-18+),$(if $(findstring -rc,$(rel)),,$(rel))))

# Older OTP versions that this plugin previously supported
# are listed here. This list is used to cleanup builds and
# installations that we do not care about anymore.

OTP-18-DROPPED := OTP-18.3.4 OTP-18.3.4.6 OTP-18.3.4.7 OTP-18.3.4.8
OTP-19-DROPPED := OTP-19.3.6 OTP-19.3.6.3 OTP-19.3.6.4 OTP-19.3.6.5 OTP-19.3.6.6 OTP-19.3.6.7 OTP-19.3.6.8 OTP-19.3.6.9
OTP-20-DROPPED := OTP-20.1.5 OTP-20.1.6 OTP-20.2 OTP-20.2.1 OTP-20.2.2 OTP-20.2.3 OTP-20.3 OTP-20.3.2 OTP-20.3.3 OTP-20.3.4 OTP-20.3.5 OTP-20.3.6 OTP-20.3.7 OTP-20.3.8 OTP-20.3.8.1 OTP-20.3.8.2 OTP-20.3.8.3 OTP-20.3.8.5
OTP-21-DROPPED := OTP-21.0-rc1 OTP-21.0-rc2 OTP-21.0 OTP-21.0.1 OTP-21.0.2 OTP-21.0.3 OTP-21.0.4

OTP-DROPPED := $(OTP-18-DROPPED) $(OTP-19-DROPPED) $(OTP-20-DROPPED) $(OTP-21-DROPPED)

# Configure Erlang.mk's CI plugin.

CI_OTP := $(foreach otp,$(AUTO_CI_OTP),$($(otp)))
CI_HIPE := $(foreach otp,$(AUTO_CI_HIPE),$($(otp)))
CI_ERLLVM := $(foreach otp,$(AUTO_CI_ERLLVM),$($(otp)))

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
WINDOWS-OTP-21 := 21.0.1

WINDOWS-OTP-18+ := $(WINDOWS-OTP-18) $(WINDOWS-OTP-19) $(WINDOWS-OTP-20) $(WINDOWS-OTP-21)
WINDOWS-OTP-19+ := $(WINDOWS-OTP-19) $(WINDOWS-OTP-20) $(WINDOWS-OTP-21)
WINDOWS-OTP-20+ := $(WINDOWS-OTP-20) $(WINDOWS-OTP-21)
WINDOWS-OTP-21+ := $(WINDOWS-OTP-21)

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

WINDOWS-OTP-21.0-INSTALL-DIR := $(call msys2_path,$(PROGRAMFILES)/erl10.0.1/bin)

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
