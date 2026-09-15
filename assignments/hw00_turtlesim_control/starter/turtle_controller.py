#!/usr/bin/env python3

"""HW00 starter code: Turtlesim Motion Control.

請完成 TODO 區域，使 Turtle 可以自動完成：
1. 向前
2. 左轉約 90 度
3. 再向前
4. 停止

本檔案只提供 ROS 2 Python Node 的基本架構，不包含作業解答。
"""

import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist


class TurtleController(Node):
    def __init__(self):
        super().__init__('turtle_controller')

        # TODO 1:
        # 建立 Publisher，發布 Twist 到 /turtle1/cmd_vel

        # TODO 2:
        # 建立你需要的控制狀態，例如目前正在前進、旋轉或停止

        # TODO 3:
        # 建立 Timer，固定頻率呼叫 control_loop()

        self.get_logger().info('Turtle controller started.')

    def control_loop(self):
        """Implement your motion sequence here."""

        # TODO 4:
        # 建立 Twist message
        # 根據目前狀態設定 linear.x / angular.z
        # 發布速度命令
        # 在適當時機切換到下一個動作
        # 最後發布零速度並停止
        pass


def main(args=None):
    rclpy.init(args=args)
    node = TurtleController()

    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()
