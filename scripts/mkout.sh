ls | grep out

if [ $? != 0 ]; then
  mkdir out
fi
