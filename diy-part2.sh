#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
#!/bin/sh
sed -i '/"u-boot"/,/read-only;/s/read-only;//' target/linux/ath79/dts/ar934x_ubiquiti_xw.dtsi
sed -i '/"u-boot-env"/,/read-only;/s/read-only;//' target/linux/ath79/dts/ar934x_ubiquiti_xw.dtsi
echo "CONFIG_PACKAGE_luci=y" >> .config
echo "CONFIG_PACKAGE_luci-mod-admin-full=y" >> .config
echo "CONFIG_PACKAGE_uhttpd=y" >> .config
echo "CONFIG_PACKAGE_luci-app-firewall=y" >> .config
mkdir -p files/etc/uci-defaults
cat << 'EOF' > files/etc/uci-defaults/99_change_uboot_ip
#!/bin/sh
echo "/dev/mtd1 0x0 0x10000 0x10000" > /etc/fw_env.config
fw_setenv ipaddr 10.175.80.22
fw_setenv serverip 10.175.80.100
exit 0
EOF
chmod +x files/etc/uci-defaults/99_change_uboot_ip
