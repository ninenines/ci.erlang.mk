# Copyright (c) Loïc Hoguin <essen@ninenines.eu>
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

OTP-18 := OTP-18.0.3 OTP-18.1.5 OTP-18.2.4.1 OTP-18.3.4.11
OTP-19 := OTP-19.0.7 OTP-19.1.6.1 OTP-19.2.3.1 OTP-19.3.6.13
OTP-20 := OTP-20.0.5 OTP-20.1.7.1 OTP-20.2.4 OTP-20.3.8.26
OTP-21 := OTP-21.0.9 OTP-21.1.4 OTP-21.2.7 OTP-21.3.8.24
OTP-22 := OTP-22.0.7 OTP-22.1.8.1 OTP-22.2.8 OTP-22.3.4.27
OTP-23 := OTP-23.0.4 OTP-23.1.5 OTP-23.2.7.5 OTP-23.3.4.20
OTP-24 := OTP-24.0.6 OTP-24.1.7 OTP-24.2.2 OTP-24.3.4.17
OTP-25 := OTP-25.0.4 OTP-25.1.2.1 OTP-25.2.3 OTP-25.3.2.21
OTP-26 := OTP-26.0.2 OTP-26.1.2 OTP-26.2.5.15
OTP-27 := OTP-27.0.1 OTP-27.1.3 OTP-27.2.4 OTP-27.3.4.3
OTP-28 := OTP-28.0.4 OTP-28.1

OTP-18+ := $(OTP-18) $(OTP-19) $(OTP-20) $(OTP-21) $(OTP-22) $(OTP-23) $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-19+ := $(OTP-19) $(OTP-20) $(OTP-21) $(OTP-22) $(OTP-23) $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-20+ := $(OTP-20) $(OTP-21) $(OTP-22) $(OTP-23) $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-21+ := $(OTP-21) $(OTP-22) $(OTP-23) $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-22+ := $(OTP-22) $(OTP-23) $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-23+ := $(OTP-23) $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-24+ := $(OTP-24) $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-25+ := $(OTP-25) $(OTP-26) $(OTP-27) $(OTP-28)
OTP-26+ := $(OTP-26) $(OTP-27) $(OTP-28)
OTP-27+ := $(OTP-27) $(OTP-28)
OTP-28+ := $(OTP-28)

OTP-LATEST-18+ := $(lastword $(OTP-18)) $(lastword $(OTP-19)) \
	$(lastword $(OTP-20)) $(lastword $(OTP-21)) $(lastword $(OTP-22)) \
	$(lastword $(OTP-23)) $(lastword $(OTP-24)) $(lastword $(OTP-25)) \
	$(lastword $(OTP-26)) $(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-19+ := $(lastword $(OTP-19)) $(lastword $(OTP-20)) \
	$(lastword $(OTP-21)) $(lastword $(OTP-22)) $(lastword $(OTP-23)) \
	$(lastword $(OTP-24)) $(lastword $(OTP-25)) $(lastword $(OTP-26)) \
	$(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-20+ := $(lastword $(OTP-20)) $(lastword $(OTP-21)) \
	$(lastword $(OTP-22)) $(lastword $(OTP-23)) $(lastword $(OTP-24)) \
	$(lastword $(OTP-25)) $(lastword $(OTP-26)) $(lastword $(OTP-27)) \
	$(lastword $(OTP-28))
OTP-LATEST-21+ := $(lastword $(OTP-21)) $(lastword $(OTP-22)) \
	$(lastword $(OTP-23)) $(lastword $(OTP-24)) $(lastword $(OTP-25)) \
	$(lastword $(OTP-26)) $(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-22+ := $(lastword $(OTP-22)) $(lastword $(OTP-23)) \
	$(lastword $(OTP-24)) $(lastword $(OTP-25)) $(lastword $(OTP-26)) \
	$(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-23+ := $(lastword $(OTP-23)) $(lastword $(OTP-24)) \
	$(lastword $(OTP-25)) $(lastword $(OTP-26)) $(lastword $(OTP-27)) \
	$(lastword $(OTP-28))
OTP-LATEST-24+ := $(lastword $(OTP-24)) $(lastword $(OTP-25)) \
	$(lastword $(OTP-26)) $(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-25+ := $(lastword $(OTP-25)) $(lastword $(OTP-26)) \
	$(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-26+ := $(lastword $(OTP-26)) $(lastword $(OTP-27)) \
	$(lastword $(OTP-28))
OTP-LATEST-27+ := $(lastword $(OTP-27)) $(lastword $(OTP-28))
OTP-LATEST-28+ := $(lastword $(OTP-28))

# We exclude release candidates here because they are not
# the latest release, they are the *next* one.

OTP-LATEST := $(lastword $(foreach rel,$(OTP-18+),$(if $(findstring -rc,$(rel)),,$(rel))))

# Configure Erlang.mk's CI plugin.

CI_OTP := $(foreach otp,$(AUTO_CI_OTP),$($(otp))) $(if $(AUTO_CI_MASTER),master)

ci-list:
	$(verbose) printf "%s\n" $(CI_OTP)

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
ci::
	$(verbose) $(MAKE) --no-print-directory ci-auto-master

ci-auto-master: $(KERL)
ifneq ($(wildcard $(KERL_INSTALL_DIR)/master),)
	$(verbose) if find $(KERL_INSTALL_DIR)/master/activate \
			-mmin +$(AUTO_CI_MASTER_MINS) | grep -q master; then \
		$(KERL) delete build master || true; \
		$(KERL) delete installation master || true; \
	fi
endif
endif

endif
