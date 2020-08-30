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

startDaemonWithAutoReloadConfig() {
	ssh -t synology '/usr/local/flexget/env/bin/flexget daemon start -d --autoreload-config'
}

ask() {
	echo "\n0. 終了"
	echo "1. 設定"
	echo "2. 履歴"
	echo "3. 任務実行"
	echo "4. 設定を再読み込み"
	echo "5. 常駐プロセスの状態"
	echo "6. 常駐プロセスを停止"
	echo "7. 常駐プロセスを開始"
	echo "8. 常駐プロセスを開始 (設定自動再読み込み)\n"

	read choice

	case $choice in
		0) exit;;
		1) editConfig;;
		2) flexgetHistory;;
		3) executeTasks;;
		4) reloadConfig;;
		5) daemonStatus;;
		6) stopDaemon;;
		7) startDaemon;;
		8) startDaemonWithAutoReloadConfig;;
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
echo "実行完了後自動的に終了することを希望しない場合のみ、「n」を入力してください。\n"

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