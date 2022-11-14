trap "exit" 2 3 20
function current_ts() {
  NANO="$(date '+%N')"
  echo "$(date '+%s')${NANO:0:3}"
}
function submit() {
  HOST="${HOST:-192.168.10.100}"
  ID="001"
  END_TIME="$(current_ts)"
  TIME="$[END_TIME-START_TIME]"
  if [ -d "/opt/module/zookeeper" ] && [ "$(du -bd0 /opt/module/zookeeper| awk '{print $1}')" -eq "36826780" ]
  then
    RESULT="true"
  else
    RESULT="false"
  fi
  curl -X POST http://${HOST} \
     -H 'Content-Type: application/json' \
     -d "{\"class\": \"$CLASS\",\"name\": \"$USERNAME\",\"id\": \"$ID\",\"result\": $RESULT,\"ts\": $END_TIME,\"time\": $TIME}"
  exit
}
clear
while [ -z "$CLASS" ]
do
  read -p "请输入班级（例如：220905）：" CLASS
done
while [ -z "$USERNAME" ]
do
  read -p "请输入姓名（例如：张三）：" USERNAME
done
clear
cat << 'EOF'
现在在/opt/software文件夹下有一个tar.gz压缩包，请将这个压缩包解压到/opt/module目录下，并将其重命名为zookeeper
完成后运行submit提交
EOF
START_TIME="$(current_ts)"
