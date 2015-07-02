#export TERM=xterm
cd ../
#RED=`tput setaf 1`
#GREEN=`tput setaf 2` 
#NOCOLOR=`tput sgr0`
lngs=( javascript php )
for entry in Test/Cases/*
do
  if [ -f "$entry" ]; then
  	for lng in "${lngs[@]}"
  	do
	  	./template ${lng} < $entry > /tmp/template_test
	  	/usr/bin/diff /tmp/template_test ${entry/Cases\//Expectation\/${lng}/} > /tmp/template_test_diff
	  	if [ $(stat -c "%s" "/tmp/template_test_diff") == 0 ]; then
	  		echo "$entry ${lng} ${GREEN}[OK]${NOCOLOR}"
	  	else
	  		echo "$entry ${lng} ${RED}[FAIL]${NOCOLOR}" >> /dev/stderr
	  	fi
	done
  fi
done

