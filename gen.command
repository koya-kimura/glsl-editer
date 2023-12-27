read userInput

now=$(date +%Y-%m-%d-%H-%M-%S)

md_file_path="memo/index.md"
content_file_path="src/${now}.glsl"

cp templete/${userInput}.glsl src/"${now}".glsl
code -r src/"${now}".glsl

echo -e "\n - [${now}.glsl](../${content_file_path})" >> "${md_file_path}"

echo "Successfully appended to ${md_file_path}"