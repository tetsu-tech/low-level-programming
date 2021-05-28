IMAGE=`docker image ls | grep low-level-programming | awk '{print $1}'`

echo $IMAGE

if [ $IMAGE = low-level-programming ]; then
  docker run -it -v $(pwd):/work -w=/work low-level-programming bash
else
  echo "imageが存在しません、make buildを実行してimageをビルドしてください"
fi
