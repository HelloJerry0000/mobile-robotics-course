#!/usr/bin/env bash

# Mobile Robotics Course - Week 00 environment check
# Run with:
#   bash scripts/environment_check.sh

set -u

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

pass() {
    printf "%-26s [PASS] %s\n" "$1" "$2"
    PASS_COUNT=$((PASS_COUNT + 1))
}

warn() {
    printf "%-26s [WARN] %s\n" "$1" "$2"
    WARN_COUNT=$((WARN_COUNT + 1))
}

fail() {
    printf "%-26s [FAIL] %s\n" "$1" "$2"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

check_command() {
    local label="$1"
    local command_name="$2"

    if command -v "$command_name" >/dev/null 2>&1; then
        pass "$label" "$(command -v "$command_name")"
    else
        fail "$label" "$command_name not found"
    fi
}

check_ros_package() {
    local label="$1"
    local package_name="$2"

    if ! command -v ros2 >/dev/null 2>&1; then
        fail "$label" "cannot check; ros2 not found"
        return
    fi

    if ros2 pkg prefix "$package_name" >/dev/null 2>&1; then
        pass "$label" "$package_name"
    else
        fail "$label" "$package_name not found"
    fi
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
        fail "Ubuntu" "$UBUNTU_VERSION (course target: 22.04)"
    else
        fail "Ubuntu" "unable to read version"
    fi
else
    fail "Ubuntu" "lsb_release not found"
fi

# ------------------------------------------------------------
# Basic tools
# ------------------------------------------------------------
if command -v git >/dev/null 2>&1; then
    pass "Git" "$(git --version 2>/dev/null | head -n 1)"
else
    fail "Git" "not installed"
fi

if command -v python3 >/dev/null 2>&1; then
    pass "Python 3" "$(python3 --version 2>&1)"
else
    fail "Python 3" "not installed"
fi

check_command "colcon" "colcon"
check_command "rosdep" "rosdep"

# ------------------------------------------------------------
# ROS 2
# ------------------------------------------------------------
if command -v ros2 >/dev/null 2>&1; then
    pass "ROS 2 command" "ros2 found"
else
    fail "ROS 2 command" "ros2 not found"
fi

ROS_DISTRO_VALUE="${ROS_DISTRO:-}"
if [[ "$ROS_DISTRO_VALUE" == "humble" ]]; then
    pass "ROS_DISTRO" "humble"
elif [[ -n "$ROS_DISTRO_VALUE" ]]; then
    fail "ROS_DISTRO" "$ROS_DISTRO_VALUE (course target: humble)"
else
    fail "ROS_DISTRO" "not set; run: source /opt/ros/humble/setup.bash"
fi

# ------------------------------------------------------------
# GUI / simulator tools
# ------------------------------------------------------------
check_command "RViz2" "rviz2"
check_command "Gazebo" "gazebo"

# ------------------------------------------------------------
# Required ROS packages
# ------------------------------------------------------------
check_ros_package "Turtlesim" "turtlesim"
check_ros_package "TurtleBot3 core" "turtlebot3_node"
check_ros_package "TurtleBot3 Gazebo" "turtlebot3_gazebo"
check_ros_package "SLAM Toolbox" "slam_toolbox"
check_ros_package "Nav2" "nav2_bringup"

# ------------------------------------------------------------
# TurtleBot3 workspace / model
# ------------------------------------------------------------
TB3_SETUP="$HOME/turtlebot3_ws/install/setup.bash"
if [[ -f "$TB3_SETUP" ]]; then
    pass "TurtleBot3 workspace" "$TB3_SETUP"
else
    fail "TurtleBot3 workspace" "$TB3_SETUP not found"
fi

TB3_MODEL="${TURTLEBOT3_MODEL:-}"
if [[ "$TB3_MODEL" == "burger" ]]; then
    pass "TURTLEBOT3_MODEL" "burger"
elif [[ -n "$TB3_MODEL" ]]; then
    warn "TURTLEBOT3_MODEL" "$TB3_MODEL (course default: burger)"
else
    warn "TURTLEBOT3_MODEL" "not set; course default: burger"
fi

printf "\n=============================================\n"
printf " Summary: %d PASS / %d WARN / %d FAIL\n" "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"
printf "=============================================\n"

if [[ "$FAIL_COUNT" -gt 0 ]]; then
    printf "\nEnvironment check found required items that are missing.\n"
    printf "Review docs/03_ROS2_Humble環境安裝.md and fix FAIL items first.\n"
    exit 1
fi

if [[ "$WARN_COUNT" -gt 0 ]]; then
    printf "\nEnvironment check completed with warnings.\n"
    exit 0
fi

printf "\nEnvironment check completed successfully.\n"
