import os


def msg_system(cmd, error_msg):
    if os.system(cmd) != 0:
        print(error_msg)
        exit(1)
