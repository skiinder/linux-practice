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
  {
  date +%F
  date -d "-100 days" +%F
  date -d "-100 days" +%w
  } > /home/atguigu/solution.txt
  if [ -f "/home/atguigu/result.txt" ] && [ "$(git diff --no-index "/home/atguigu/result.txt" "/home/atguigu/solution.txt" | wc -l)" -eq "0" ]
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
  read -p "请输入网站获取的TOKEN：" TOKEN
done
clear
cat << 'EOF'
完成如下需求，将结果依次追加到/home/atguigu/result.txt，每个一行
  1. 查询当前日期，格式如下"yyyy-mm-dd";
  2. 查询100天前的日期，格式如下"yyyy-mm-dd";
  3. 查询100天前是周几，用0-6代表周日到周六（周日为第一天）
EOF
START_TIME="$(current_ts)"
