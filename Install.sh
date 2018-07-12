#!/bin/bash
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
read -p "Digite a Key Para os Arquivos: " Key
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
[[ ! $Key ]] && {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey Invalida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
exit
}
echo -ne "\033[1;33mVerificando key: "
cd $HOME
wget $(ofus "$Key") > /dev/null 2>&1 && echo -e "\033[1;32m Pass" || echo -e "\033[1;31m Fail"
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
sleep 1s
[[ -e $HOME/lista-arq ]] && {
REQUEST=$(ofus "$Key" |cut -d'/' -f2)
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33mBaixando Arquivo \033[1;31m[$arqx] "
wget ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mRecebido Com Sucesso!" || echo -e "\033[1;31m- \033[1;31mFalha (nao recebido!)"
sleep 1s
done
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mDowloads Concluidos!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
rm $HOME/lista-arq
chmod +x ./sshplus.sh; ./sshplus.sh
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey Invalida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}

