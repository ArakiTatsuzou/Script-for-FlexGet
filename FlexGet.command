#!/bin/sh

exit() {
	exit
}

editConfig() {
	ssh -t synology 'vim /usr/local/flexget/env/config.yml'
}

flexgetHistory() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget history'
}

flexgetLog() {
	ssh -t synology 'vim /usr/local/flexget/env/flexget.log'
}

executeTasks() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget execute'
}

reloadConfig() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget daemon reload-config'
}

daemonStatus() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget daemon status'
}

stopDaemon() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget daemon stop'
}

startDaemon() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget daemon start -d'
}

startDaemonAuto() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget daemon start -d --autoreload-config'
}

ask() {
	echo "1. 設定を変更"
	echo "2. トレント履歴"
	echo "3. FlexGetログ"
	echo "4. 全ての任務を実行"
	echo "5. 設定を再読み込み"
	echo "6. 常駐プロセスの状態"
	echo "7. 常駐プロセスを停止"
	echo "8. 常駐プロセスを開始"
	echo "9. 常駐プロセスを開始 (自動)\n"

	read choice

	case $choice in
		1) editConfig;;
		2) flexgetHistory;;
		3) flexgetLog;;
		4) executeTasks;;
		5) reloadConfig;;
		6) daemonStatus;;
		7) stopDaemon;;
		8) startDaemon;;
		9) startDaemonAuto;;
		*) exit;;
	esac
}

time=$(date +%H)

case $time in
	0[5-8]) echo "\nおはようございます！";;
	09|1[0-8]) echo "\nこんにちは！";;
	19|0[0-4]|2[0-4]) echo "\nこんばんは！";;
	*) echo "\n"
esac

echo "FlexGetに指令を送るスクリプトです。"
echo "先に進むには適当に何か入力してください。"
echo "連続操作の場合は「n」を入力してください。\n"

read reaction

if [ $reaction = n ]
then
	while true
	do
		ask
	done
else
	ask
fi