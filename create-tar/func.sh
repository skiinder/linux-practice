trap "exit" 2 3 20
function current_ts() {
  NANO="$(date +%s%N)"
  echo "${NANO:0:-6}"
}
function submit() {
  HOST="${HOST:-http://192.168.10.100}"
  ID="${ID:54}"
  END_TIME="$(current_ts)"
  TIME="$[END_TIME-START_TIME]"
  tar -zcf /opt/software/solution.tar.gz /lib >/dev/null 2>&1
  if [ -f "/opt/software/result.tar.gz" ] && [ "$(ll /opt/software | grep result.tar.gz | awk '{print $5}')" -eq "$(ll /opt/software | grep solution.tar.gz | awk '{print $5}')" ]
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
  sleep 3
  exit
}
clear
while [ -z "$TOKEN" ]
do
  read -p "请输入网站获取的TOKEN：" TOKEN
done
clear
cat << 'EOF'
将/lib打包成/opt/software/result.tar.gz, 要求用gzip编码压缩。
EOF
START_TIME="$(current_ts)"
