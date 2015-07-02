#export TERM=xterm
cd ../
#RED=`tput setaf 1`
#GREEN=`tput setaf 2` 
#NOCOLOR=`tput sgr0`
for entry in Test/Cases/*
do
  if [ -f "$entry" ]; then
  	./template < $entry > /tmp/template_test
  	/usr/bin/diff /tmp/template_test ${entry/Cases\//Expectation\/js_} > /tmp/template_test_diff
  	if [ $(stat -c "%s" "/tmp/template_test_diff") == 0 ]; then
  		echo "$entry ${GREEN}[OK]${NOCOLOR}"
  	else
  		echo "$entry ${RED}[FAIL]${NOCOLOR}" >> /dev/stderr
  	fi
  fi
done

