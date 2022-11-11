clear
cat << 'EOF'
现在在/opt/software文件夹下有一个tar.gz压缩包，请将这个压缩包解压到/opt/module目录下，并将其重命名为zookeeper
完成后运行submit提交
EOF
echo $[$(date '+%s')*1000+$(date '+%N')/1000000] >> /tmp/start-time
function submit() {
  if [ -d /opt/module/zookeeper ]
  then
    echo "成功！"
  else
    echo "失败！"
  fi

  echo "耗时$[$(date '+%s')*1000+$(date '+%N')/1000000-$(cat /tmp/start-time)]ms"
  sleep 5
  exit
}
