from utils import msg_system

error_msg = "Git is not installed"
msg_system("git checkout main", error_msg)
msg_system("git merge dev", error_msg)
msg_system("git push", error_msg)
msg_system("git checkout dev", error_msg)
input("ok")
