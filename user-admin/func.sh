trap "exit" 2 3 20
function current_ts() {
  NANO="$(date +%s%N)"
  echo "${NANO:0:-6}"
}
function submit() {
  HOST="${HOST:-http://192.168.10.100}"
  ID="${ID:54}"
  END_TIME="$(current_ts)"
  TIME="$((END_TIME-START_TIME))"
  read -ra array <<< "$(id tom | sed 's/[=\\((\\)),]/ /g')"
  if [ "${array[1]}" = "1001" ] && \
  [ "${array[2]}" = "tom" ] && \
  [ "${array[4]}" = "1001" ] && \
  [ "${array[5]}" = "test" ] && \
  [ "${array[9]}" = "10" ] && \
  [ "${array[10]}" = "wheel" ] && \
  [ "$(grep -c '^ *tom' /etc/sudoers)" -eq '1' ]
  then
    echo "结果正确，用时${TIME}ms。"
    RESULT="true"
  else
    echo "结果错误，用时${TIME}ms。"
    RESULT="false"
  fi
  curl -X POST "${HOST}" \
     -H 'Content-Type: application/json' \
     -d "{\"token\": \"$TOKEN\",\"question_id\": \"$ID\",\"question_type\": \"linux\",\"result\": $RESULT}"
  sleep 3
  exit
}
clear
while [ -z "$TOKEN" ]
do
  read -rp "请输入网站获取的TOKEN：" TOKEN
done
clear
cat << 'EOF'
完成如下需求：
  1. 创建test用户组
  2. 创建tom用户，使其属于test组
  3. 给tom用户追加wheel组
  4. 给tom用户配置sudo权限
EOF
START_TIME="$(current_ts)"
