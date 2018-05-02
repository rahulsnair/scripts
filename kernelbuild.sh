rm -rf out
mkdir -p out/target/product/generic/obj/kernel
my_top_dir=$PWD
kernel_out_dir=$PWD/out/target/product/generic/obj/kernel
cp kernel/arch/arm/configs/albus_defconfig $kernel_out_dir/.config
cross=$my_top_dir/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
make -j12 -C kernel O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$cross KBUILD_BUILD_USER= KBUILD_BUILD_HOST= defoldconfig
make -j12 -C kernel O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$cross oldconfig
make -j12 -C kernel O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$cross KBUILD_BUILD_USER= KBUILD_BUILD_HOST= headers_install
make -j12 -C kernel KBUILD_RELSRC=$my_top_dir/kernel O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$cross KBUILD_BUILD_USER= KBUILD_BUILD_HOST= KCFLAGS=-mno-android
make -j12 -C kernel KBUILD_RELSRC=$my_top_dir/kernel O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$cross KBUILD_BUILD_USER= KBUILD_BUILD_HOST= KCFLAGS=-mno-android dtbs
make -j12 -C kernel KBUILD_RELSRC=$my_top_dir/kernel O=$kernel_out_dir ARCH=arm CROSS_COMPILE=$cross KBUILD_BUILD_USER= KBUILD_BUILD_HOST= KCFLAGS=-mno-android modules
make -j12 -C kernel KBUILD_RELSRC=$my_top_dir/kernel O=$kernel_out_dir INSTALL_MOD_PATH=$my_top_dir/out/target/product/generic INSTALL_MOD_STRIP="--strip-debug --remove-section=.note.gnu.build-id" ARCH=arm CROSS_COMPILE=$cross KBUILD_BUILD_USER= KBUILD_BUILD_HOST= modules_install
