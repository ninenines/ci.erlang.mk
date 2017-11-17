# Copyright (c) 2017, Loïc Hoguin <essen@ninenines.eu>
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

OTP-18 := OTP-18.0.3 OTP-18.1.5 OTP-18.2.4 OTP-18.3.4.6
OTP-19 := OTP-19.0.7 OTP-19.1.6 OTP-19.2.3 OTP-19.3.6.3
OTP-20 := OTP-20.0.5 OTP-20.1.5

OTP-18+ := $(OTP-18) $(OTP-19) $(OTP-20)
OTP-19+ := $(OTP-19) $(OTP-20)
OTP-20+ := $(OTP-20)

OTP-LATEST := $(lastword $(OTP-18+))

# Older OTP versions that this plugin previously supported
# are listed here. This list is used to cleanup builds and
# installations that we do not care about anymore.

OTP-DROPPED := OTP-18.3.4 OTP-19.3.6

# Configure Erlang.mk's CI plugin.

CI_OTP := $(foreach otp,$(AUTO_CI_OTP),$($(otp)))
CI_HIPE := $(foreach otp,$(AUTO_CI_HIPE),$($(otp)))
CI_ERLLVM := $(foreach otp,$(AUTO_CI_ERLLVM),$($(otp)))

# Cleanup older OTP versions we don't care about anymore.

CI_AUTO_CLEANUP_TARGETS := $(foreach t,$(OTP-DROPPED),ci-auto-cleanup-$t)

.PHONY: ci-auto-cleanup $(CI_AUTO_CLEANUP_TARGETS)

define ci_auto_cleanup_target
ci-auto-cleanup-$1: $$(KERL)
	$$(verbose) $$(KERL) list builds | grep -q "^git,$1$$$$" && $$(KERL) delete build $1 || true
	$$(verbose) $$(KERL) list installations | grep -q "^$1 " && $$(KERL) delete installation $1 || true
	$$(verbose) $$(KERL) list builds | grep -q "^git,$1-native$$$$" && $$(KERL) delete build $1-native || true
	$$(verbose) $$(KERL) list installations | grep -q "^$1-native " && $$(KERL) delete installation $1-native || true
	$$(verbose) $$(KERL) list builds | grep -q "^git,$1-erllvm$$$$" && $$(KERL) delete build $1-erllvm || true
	$$(verbose) $$(KERL) list installations | grep -q "^$1-erllvm " && $$(KERL) delete installation $1-erllvm || true
endef

$(foreach t,$(OTP-DROPPED),$(eval $(call ci_auto_cleanup_target,$t)))

ci-auto-cleanup: $(CI_AUTO_CLEANUP_TARGETS)
