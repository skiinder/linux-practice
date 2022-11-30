trap "exit" 2 3 20
function current_ts() {
  NANO="$(date +%s%N)"
  echo "${NANO:0:-6}"
}
function submit() {
  HOST="${HOST:-http://192.168.10.100}"
  ID="54"
  END_TIME="$(current_ts)"
  TIME="$[END_TIME-START_TIME]"
  if [ -d "/opt/module/zookeeper" ] && [ "$(find /opt/module/zookeeper -type f | wc -l)" -eq "1520" ]
  then
    echo "结果正确，用时${TIME}ms。"
    RESULT="true"
  else
    echo "结果错误，用时${TIME}ms。"
    RESULT="false"
  fi
  curl -X POST ${HOST} \
     -H 'Content-Type: application/json' \
     -d "{\"token\": \"$TOKEN\",\"question_id\": \"$ID\",\"question_type\": \"linux\",\"result\": $RESULT}"
  sleep 5
  exit
}
clear
while [ -z "$TOKEN" ]
do
  read -p "请输入网站获取的TOKEN：" TOKEN
done
clear
cat << 'EOF'
现在在/opt/software文件夹下有一个tar.gz压缩包，请将这个压缩包解压到/opt/module目录下，并将其重命名为zookeeper
完成后运行submit提交
EOF
START_TIME="$(current_ts)"
