## Preface

This repository contains ICL vendor specific makefiles and binaries alone with some essential google and qcom vendor specific makefiles.

## Android vendor specific driver binaries

Due to license issues, the essential Android vendor specific driver binaries for Pixel XL are not included in this repository, you can down these files on [Pixel XL binaries for Android 7.1.2 \(NJH47B\)](https://developers.google.com/android/drivers#marlinnjh47b) and follow the steps below to complete the preparation of the vendor specific binaries.

Before we get started, for easier describe how to extract and locate vendor specific driver binaries to the right places, the following is my directory structure:

```shell
~/cba (root for working directory)
    ├── aosp-marlin-7.1.2_r17 (root for CBA checkout)
    │            ├── …
    │            ├── vendor
    │            └── ...
    ├──  Pixel-XL-binaries-for-Android-7.1.2-NJH47B
    │            ├── google_devices-marlin-njh47b-cd5b463a.tgz
    │            ├── extract-google_devices-marlin.sh
    │            ├── qcom-marlin-njh47b-c8f9d81f.tgz
    │            ├── extract-qcom-marlin.sh
    │            └── vendor
```

### Installing Steps
```shell
# Download vendor specific birnaies into ~/cba/Pixel-XL-binaries-for-Android-7.1.2-NJH47B

$ cd /cba/Pixel-XL-binaries-for-Android-7.1.2-NJH47B

# extract google_devices-marlin-njh47b-cd5b463a.tgz and qcom-marlin-njh47b-c8f9d81f.tgz
# execute extract-google_devices-marlin.sh and extract-qcom-marlin.sh which will extract themselves into ./vendor

# copy files to ~/cba/aosp-marlin-7.1.2_r17/vendor
$ cp -a vendor/google_devices/marlin/proprietary/vendor.img \
    ~/cba/aosp-marlin-7.1.2_r17/vendor/google_devices/marlin/proprietary/vendor.img
$ cp -a vendor/qcom ~/cba/aosp-marlin-7.1.2_r17/vendor/
```

## Licensing

This repository is licensed under the Apache License, Version 2.0. See [LICENSE](https://github.com/clondroid/android_vendor_marlin_7/blob/master/LICENSE) for the details.
