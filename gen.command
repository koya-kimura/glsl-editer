now=`date +%Y-%m-%d-%H-%M-%S`

cp templete/basic.glsl src/"$now".glsl
code -r src/"$now".glsl