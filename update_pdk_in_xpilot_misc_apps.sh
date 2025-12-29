# xpilot_misc_apps
merge_to_branch=$1
pdk_sdk_version=$2
rm -fr /data/liuc/xpilot_misc_apps
cd /data/liuc/
git clone -b ${merge_to_branch} --single-branch git@gitlab-adc.xiaopeng.link:xpilot/xpilot_misc_apps.git
cd /data/liuc/xpilot_misc_apps
git pull
git checkout -b update_${merge_to_branch}_${pdk_sdk_version}
cat /data/liuc/ossutil/pdk_version.txt > /data/liuc/xpilot_misc_apps/bsp_version/xp5/xccp_bsp_version.txt
git add .
git commit -m "update new pdk ${pdk_sdk_version}"
git show HEAD
git push --set-upstream origin update_${merge_to_branch}_${pdk_sdk_version} -f
glab mr create --title "update pdk ${pdk_sdk_version}" --description "update pdk ${pdk_sdk_version}" --target-branch ${merge_to_branch} | grep "https" >> /tmp/update_pdk_sdk_mr.txt

