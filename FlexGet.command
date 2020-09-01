#!/bin/sh

exit() {
	exit
}

editConfig() {
	ssh -t synology "vim /usr/local/flexget/env/config.yml"
}

replaceConfig() {
	ssh -t synology "cp /volume1/Storage/その他/config.yml /usr/local/flexget/env/config.yml"
}

flexgetHistory() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget history"
}

flexgetLog() {
	ssh -t synology "vim /usr/local/flexget/env/flexget.log"
}

executeTasks() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget execute"
}

executeSpecificTask() {
	echo "\n実行させたい任務の名前を入力してください"
	read task
	ssh -t synology "/usr/local/flexget/env/bin/flexget execute --tasks ${task}"
}

reloadConfig() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget daemon reload-config"
}

daemonStatus() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget daemon status"
}

stopDaemon() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget daemon stop"
}

startDaemon() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget daemon start -d"
}

startDaemonAuto() {
	ssh -t synology "/usr/local/flexget/env/bin/flexget daemon start -d --autoreload-config"
}


ask() {
	echo "01. 設定を見る"
	echo "02. 設定を書き換える"
	echo "03. 設定を再読み込み"
	echo "04. 指定の任務を実行"
	echo "05. 全ての任務を実行"
	echo "06. トレント履歴を見る"
	echo "07. FlexGetログを見る"
	echo "08. 常駐プロセスの状態"
	echo "09. 常駐プロセスを停止"
	echo "10. 常駐プロセスを開始"
	echo "11. 常駐プロセスを開始 (自動)\n"

	read choice

	case $choice in
		1) editConfig;;
		2) replaceConfig;;
		3) reloadConfig;;
		4) executeSpecificTask;;
		5) executeTasks;;
		6) flexgetHistory;;
		7) flexgetLog;;
		8) daemonStatus;;
		9) stopDaemon;;
		10) startDaemon;;
		11) startDaemonAuto;;
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