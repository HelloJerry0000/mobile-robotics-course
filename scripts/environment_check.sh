#!/usr/bin/env bash

# Mobile Robotics Course - Week 00 environment check
# Run with:
#   bash scripts/environment_check.sh

set -u

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

pass() { printf "%-28s [PASS] %s\n" "$1" "$2"; PASS_COUNT=$((PASS_COUNT + 1)); }
warn() { printf "%-28s [WARN] %s\n" "$1" "$2"; WARN_COUNT=$((WARN_COUNT + 1)); }
fail() { printf "%-28s [FAIL] %s\n" "$1" "$2"; FAIL_COUNT=$((FAIL_COUNT + 1)); }

check_command() {
    if command -v "$2" >/dev/null 2>&1; then pass "$1" "$(command -v "$2")"; else fail "$1" "$2 not found"; fi
}

check_ros_package() {
    if ! command -v ros2 >/dev/null 2>&1; then fail "$1" "cannot check; ros2 not found"; return; fi
    if ros2 pkg prefix "$2" >/dev/null 2>&1; then pass "$1" "$2"; else fail "$1" "$2 not found"; fi
}

printf "=============================================\n"
printf " Mobile Robotics Course - Environment Check\n"
printf "=============================================\n\n"

if command -v lsb_release >/dev/null 2>&1; then
    UBUNTU_VERSION="$(lsb_release -rs 2>/dev/null || true)"
    [[ "$UBUNTU_VERSION" == "22.04" ]] && pass "Ubuntu" "$UBUNTU_VERSION" || fail "Ubuntu" "$UBUNTU_VERSION (course target: 22.04)"
else
    fail "Ubuntu" "lsb_release not found"
fi

check_command "Git" "git"
check_command "Python 3" "python3"
check_command "Terminator" "terminator"
check_command "colcon" "colcon"
check_command "rosdep" "rosdep"
check_command "ROS 2 command" "ros2"

# ROS apt source: current course setup uses ros2-apt-source / ros2.sources.
if dpkg-query -W -f='${Status}' ros2-apt-source 2>/dev/null | grep -q "install ok installed"; then
    pass "ros2-apt-source" "installed"
else
    warn "ros2-apt-source" "not installed; review docs section 6"
fi

if [[ -e /etc/apt/sources.list.d/ros2.sources ]]; then
    pass "ROS apt source" "/etc/apt/sources.list.d/ros2.sources"
else
    warn "ROS apt source" "ros2.sources not found"
fi

ROS_SOURCE_COUNT="$(grep -RIl "packages.ros.org/ros2/ubuntu" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null | wc -l)"
if [[ "$ROS_SOURCE_COUNT" -gt 1 ]]; then
    warn "ROS source duplicates" "$ROS_SOURCE_COUNT files reference ROS 2 repository; check Signed-By settings"
else
    pass "ROS source duplicates" "no duplicate source files detected"
fi

ROS_DISTRO_VALUE="${ROS_DISTRO:-}"
if [[ "$ROS_DISTRO_VALUE" == "humble" ]]; then pass "ROS_DISTRO" "humble"; elif [[ -n "$ROS_DISTRO_VALUE" ]]; then fail "ROS_DISTRO" "$ROS_DISTRO_VALUE (target: humble)"; else fail "ROS_DISTRO" "not set"; fi

check_ros_package "Demo nodes C++" "demo_nodes_cpp"
check_ros_package "Demo nodes Python" "demo_nodes_py"
check_command "RViz2" "rviz2"
check_command "Gazebo" "gazebo"
check_ros_package "Turtlesim" "turtlesim"
check_ros_package "TurtleBot3 core" "turtlebot3_node"
check_ros_package "TurtleBot3 Gazebo" "turtlebot3_gazebo"
check_ros_package "SLAM Toolbox" "slam_toolbox"
check_ros_package "Nav2" "nav2_bringup"

TB3_SETUP="$HOME/turtlebot3_ws/install/setup.bash"
[[ -f "$TB3_SETUP" ]] && pass "TurtleBot3 workspace" "$TB3_SETUP" || fail "TurtleBot3 workspace" "$TB3_SETUP not found"

STUDENT_WS="$HOME/mobile_robotics_ws"
STUDENT_SETUP="$STUDENT_WS/install/setup.bash"
[[ -d "$STUDENT_WS/src" ]] && pass "Student workspace" "$STUDENT_WS" || fail "Student workspace" "$STUDENT_WS/src not found"
[[ -f "$STUDENT_SETUP" ]] && pass "Student workspace setup" "$STUDENT_SETUP" || fail "Student workspace setup" "$STUDENT_SETUP not found; run colcon build"

COURSE_REPO="$HOME/mobile-robotics-course"
if [[ -d "$COURSE_REPO/.git" ]]; then
    pass "Course repository" "$COURSE_REPO"
    if [[ -n "$(git -C "$COURSE_REPO" status --porcelain 2>/dev/null)" ]]; then
        warn "Course repo status" "local changes found; course repo should normally remain unchanged"
    else
        pass "Course repo status" "clean"
    fi
else
    fail "Course repository" "$COURSE_REPO/.git not found"
fi

TB3_MODEL="${TURTLEBOT3_MODEL:-}"
if [[ "$TB3_MODEL" == "burger" ]]; then pass "TURTLEBOT3_MODEL" "burger"; elif [[ -n "$TB3_MODEL" ]]; then warn "TURTLEBOT3_MODEL" "$TB3_MODEL (course default: burger)"; else warn "TURTLEBOT3_MODEL" "not set"; fi

printf "\n=============================================\n"
printf " Summary: %d PASS / %d WARN / %d FAIL\n" "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"
printf "=============================================\n"

if [[ "$FAIL_COUNT" -gt 0 ]]; then
    printf "\nRequired items are missing. Review docs/03_ROS2_Humble環境安裝.md.\n"
    exit 1
fi

printf "\nEnvironment check completed.\n"
