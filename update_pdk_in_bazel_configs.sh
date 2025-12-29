# bazel_configs
merge_to_branch=$1
pdk_sdk_version=$2

rm -fr /data/liuc/bazel_configs
cd /data/liuc/
git clone -b ${merge_to_branch} --single-branch git@gitlab-adc.xiaopeng.link:xpilot/bazel_configs.git
cd /data/liuc/bazel_configs
git pull
git checkout -b update_${merge_to_branch}_${pdk_sdk_version}
# 替换 URL：匹配 xccp_sdk_url = ["..."] 中的引号内容
sed -i "s|\(xccp_sdk_urls = \[\)\"[^\"]*\"|\1\"${sdk_url}\"|" globals.bzl
# 替换 SHA256：匹配 xccp_sdk_sha256 = "..." 中的引号内容
sed -i "s|\(xccp_sdk_sha256 = \"\)[^\"]*\"|\1${sdk_sha256}\"|" globals.bzl
git add .
git commit -m "update new sdk ${pdk_sdk_version}"
git show HEAD
git push --set-upstream origin update_${merge_to_branch}_${pdk_sdk_version} -f
glab mr create --title "update pdk ${pdk_sdk_version}" --description "update pdk ${pdk_sdk_version}" --target-branch ${merge_to_branch}
