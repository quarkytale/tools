ps aux | grep <application_name> | awk '{print $1}' | xargs kill -9
