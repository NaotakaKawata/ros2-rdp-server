#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
#source "${ROS_ROOT}/install/setup.bash"
exec "$@"
