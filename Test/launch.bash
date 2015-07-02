cd ../
for entry in Test/Cases/*
do
  if [ -f "$entry" ]; then
  	./template < $entry > /tmp/template_test
  	/usr/bin/diff /tmp/template_test ${entry/Cases\//Expectation\/js_} > /tmp/template_test_diff
  	if [ $(stat -c "%s" "/tmp/template_test_diff") == 0 ]; then
  		echo "$entry [OK]"
  	else
  		echo "$entry [FAIL]"
  	fi
  fi
done

