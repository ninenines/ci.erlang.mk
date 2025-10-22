#!/usr/bin/env bash

rm -rf ./otp
git clone https://github.com/erlang/otp
cd otp && git tag | grep OTP- | sort -V > ../VERSIONS
cd -
rm -rf ./otp

declare -r versions="OTP-18 OTP-19 OTP-20 OTP-21 OTP-22 OTP-23 OTP-24 OTP-25 OTP-26 OTP-27 OTP-28"

function match_latest {
    cat VERSIONS | grep $1 | sort -V | tail -n1
}

function match_latest_minors {
    local dot0="$(match_latest $1.0)"
    local dot1="$(match_latest $1.1)"
    local dot2="$(match_latest $1.2)"
    local dot3="$(match_latest $1.3)"

    # Awk is used to trim whitespaces.
    echo "$dot0 $dot1 $dot2 $dot3" | awk '{$1=$1};1'
}

for v in $versions; do
    minors="$(match_latest_minors $v)"

    for m in $minors; do
        test -f release-notes/$m.README.txt ||
            wget https://erlang.org/download/$m.README -O release-notes/$m.README.txt
    done

    sed -i "/^$v := /c\\$v := $minors" early-plugins.mk
done

rm VERSIONS

# Immediately stop successfully when nothing was done.
git diff --quiet && exit 0

git add early-plugins.mk release-notes/
# Only commit when there are changes to be pushed.
git diff --cached --quiet || git commit -m "Automatically updated OTP versions"
git push origin master

# We exit with an error so an email is sent for verification
# that everything the script did worked as intended.
exit 17
