##################
#   Phoenix-HMP  #
##################
# Clean old out folder
rm -rf '/home/kazu/android_kernel_xiaomi_lavender/out'
# Set defaults
cd "/home/kazu/android_kernel_xiaomi_lavender"
wd=$(pwd)
out=$wd/out
BUILD="/home/kazu/android_kernel_xiaomi_lavender"
# Set kernel source workspace
cd $BUILD
# Export ARCH <arm, arm64, x86, x86_64>
export ARCH=arm64
# Export SUBARCH <arm, arm64, x86, x86_64>
export SUBARCH=arm64
# Set kernal name
# export LOCALVERSION=-
# Export Username
export KBUILD_BUILD_USER=KazuDante
# Export Machine name
export KBUILD_BUILD_HOST=xdadevelopers
# Compiler String
CC=/home/kazu/platform_prebuilts_clang_host_linux-x86_clang_5900059/bin/clang
export KBUILD_COMPILER_STRING="$(${CC} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')"
# Make and Clean
make O=$out clean
make O=$out mrproper
# Make <defconfig>
make O=$out ARCH=arm64 lavender-perf_defconfig
# Build Kernel
make O=$out ARCH=arm64 \
CC="/home/kazu/platform_prebuilts_clang_host_linux-x86_clang_5900059/bin/clang" \
CROSS_COMPILE="/home/kazu/toolchain/toolchain64/bin/aarch64-linux-gnu-" \
CROSS_COMPILE_ARM32="/home/kazu/toolchain/toolchain32/bin/arm-linux-gnueabi-" \
-j$(nproc --all) Image.gz-dtb
