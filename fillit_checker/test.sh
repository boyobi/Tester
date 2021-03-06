echo "fillit_checker by agadhgad"
i=0
nb=0
var=$(./fillit \200)
if [ "$var" != "error" ]
then
	echo "\033[0;31mFAIL: ne prend pas en compte un fichier inexistant\033[0m" 
	exit 1
fi
echo "--- begin of invalid test ---"	
while [ "$i" != 20 ]
do
	echo "invalid test $i : \c"
	var=$(./fillit error_file/error_$i)
	if [ "$var" != "error" ]
	then
		echo "\033[0;31mfail :/\033[0m"
	else
		echo "\033[0;32mok\033[0m"
		nb=$((nb+1))
	fi
	i=$((i+1))
done
i=0
nb2=0
time=0
echo "--- end of invalid test ---"
if [ "$nb" != 20 ]
then
	echo "\033[0;31minvalid test failed, $nb / 20\033[0m"
else
	echo "\033[0;32minvalid test succeed, $nb / 20\033[0m"
fi
echo "___ begin of valid test ___"
while [ "$i" != 20 ]
do
	echo "valid test $i : \c"
	var=$(./fillit correct_file/valid_$i)
	var2=$(./_exe correct_file/valid_$i)
	if [ "$var" != "$var2" ]
	then
		echo "\033[0;31mfail :/\033[0m"
	else
		echo "\033[0;32mok\033[0m"
		nb2=$((nb2+1))
	fi
	i=$((i+1))
done
echo "___ end of valid test ___"
nb3=$nb
(( nb3 += nb2))
if [ "$nb2" = 20 ]
then
	echo "\033[0;32mvalid test succeed $nb2 / 20\033[0m"
else
	echo "\033[0;31mvalid test failed, $nb2 / 20\033[0m"
fi
if [ "$nb3" = 40 ]
then

	echo "\033[0;34mBONUS : \033[0m"
	time ./$PAT/fillit correct_file/valid_20
	time ./$PAT/fillit correct_file/valid_21
	echo "NOTE: \033[0;32m42/42\033[0m"
else
	(( nb += nb2 ))
	echo "NOTE: \033[0;31m$nb / 40\033[0m"
fi
