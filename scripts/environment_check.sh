#!/usr/bin/env bash

# Mobile Robotics Course - Week 00 environment check
# Run with:
#   bash scripts/environment_check.sh

set -u

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

pass() {
    printf "%-24s [PASS] %s\n" "$1" "$2"
    PASS_COUNT=$((PASS_COUNT + 1))
}

warn() {
    printf "%-24s [WARN] %s\n" "$1" "$2"
    WARN_COUNT=$((WARN_COUNT + 1))
}

fail() {
    printf "%-24s [FAIL] %s\n" "$1" "$2"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

printf "=============================================\n"
printf " Mobile Robotics Course - Environment Check\n"
printf "=============================================\n\n"

# ------------------------------------------------------------
# Ubuntu version
# ------------------------------------------------------------
if command -v lsb_release >/dev/null 2>&1; then
    UBUNTU_VERSION="$(lsb_release -rs 2>/dev/null || true)"
    if [[ "$UBUNTU_VERSION" == "22.04" ]]; then
        pass "Ubuntu" "$UBUNTU_VERSION"
    elif [[ -n "$UBUNTU_VERSION" ]]; then
        warn "Ubuntu" "$UBUNTU_VERSION (course target: 22.04)"
    else
        fail "Ubuntu" "unable to read version"
    fi
else
    fail "Ubuntu" "lsb_release not found"
fi

# ------------------------------------------------------------
# Git
# ------------------------------------------------------------
if command -v git >/dev/null 2>&1; then
    GIT_VERSION="$(git --version 2>/dev/null | head -n 1)"
    pass "Git" "$GIT_VERSION"
else
    fail "Git" "not installed"
fi

# ------------------------------------------------------------
# Python 3
# ------------------------------------------------------------
if command -v python3 >/dev/null 2>&1; then
    PYTHON_VERSION="$(python3 --version 2>&1)"
    pass "Python 3" "$PYTHON_VERSION"
else
    fail "Python 3" "not installed"
fi

# ------------------------------------------------------------
# ROS 2 command
# ------------------------------------------------------------
if command -v ros2 >/dev/null 2>&1; then
    pass "ROS 2 command" "ros2 found"
else
    fail "ROS 2 command" "ros2 not found"
fi

# ------------------------------------------------------------
# ROS distribution
# ------------------------------------------------------------
ROS_DISTRO_VALUE="${ROS_DISTRO:-}"
if [[ "$ROS_DISTRO_VALUE" == "humble" ]]; then
    pass "ROS_DISTRO" "humble"
elif [[ -n "$ROS_DISTRO_VALUE" ]]; then
    warn "ROS_DISTRO" "$ROS_DISTRO_VALUE (course target: humble)"
else
    warn "ROS_DISTRO" "not set; ROS 2 may not be sourced"
fi

printf "\n=============================================\n"
printf " Summary: %d PASS / %d WARN / %d FAIL\n" "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"
printf "=============================================\n"

if [[ "$FAIL_COUNT" -gt 0 ]]; then
    printf "\nEnvironment check found required items that are missing.\n"
    exit 1
fi

if [[ "$WARN_COUNT" -gt 0 ]]; then
    printf "\nEnvironment check completed with warnings.\n"
    exit 0
fi

printf "\nEnvironment check completed successfully.\n"
