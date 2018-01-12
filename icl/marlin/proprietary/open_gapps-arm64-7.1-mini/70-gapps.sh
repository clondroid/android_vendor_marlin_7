#!/sbin/sh
# 
# /system/system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/CalculatorGooglePrebuilt/CalculatorGooglePrebuilt.apk
app/CalendarGooglePrebuilt/CalendarGooglePrebuilt.apk
app/FaceLock/FaceLock.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleExtShared/GoogleExtShared.apk
app/GoogleHome/GoogleHome.apk
app/GoogleTTS/GoogleTTS.apk
app/Maps/Maps.apk
app/Photos/Photos.apk
app/PrebuiltBugle/PrebuiltBugle.apk
app/PrebuiltDeskClockGoogle/PrebuiltDeskClockGoogle.apk
app/PrebuiltExchange3Google/PrebuiltExchange3Google.apk
app/PrebuiltGmail/PrebuiltGmail.apk
app/YouTube/YouTube.apk
etc/default-permissions/default-permissions.xml
etc/default-permissions/opengapps-permissions.xml
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/permissions/privapp-permissions-google.xml
etc/preferred-apps/google.xml
etc/sysconfig/dialer_experience.xml
etc/sysconfig/framework-sysconfig.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/whitelist_com.android.omadm.service.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libfilterpack_facedetect.so
lib64/libfacenet.so
lib64/libfilterpack_facedetect.so
lib64/libjni_latinimegoogle.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GmsCoreSetupPrebuilt/GmsCoreSetupPrebuilt.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleExtServices/GoogleExtServices.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleLoginService/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
priv-app/TagGoogle/TagGoogle.apk
priv-app/Turbo/Turbo.apk
priv-app/Velvet/Velvet.apk
usr/srec/en-US/APP_NAME.fst
usr/srec/en-US/APP_NAME.syms
usr/srec/en-US/CLG.prewalk.fst
usr/srec/en-US/CONTACT_NAME.fst
usr/srec/en-US/CONTACT_NAME.syms
usr/srec/en-US/SONG_NAME.fst
usr/srec/en-US/SONG_NAME.syms
usr/srec/en-US/am_phonemes.syms
usr/srec/en-US/app_bias.fst
usr/srec/en-US/c_fst
usr/srec/en-US/commands.abnf
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/config.pumpkin
usr/srec/en-US/confirmation_bias.fst
usr/srec/en-US/contacts.abnf
usr/srec/en-US/contacts_bias.fst
usr/srec/en-US/contacts_disambig.fst
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/dnn
usr/srec/en-US/embedded_class_denorm.mfar
usr/srec/en-US/embedded_normalizer.mfar
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_model
usr/srec/en-US/endpointer_model.mmap
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_portable_mean_stddev
usr/srec/en-US/ep_portable_model.uint8.mmap
usr/srec/en-US/g2p.data
usr/srec/en-US/g2p_fst
usr/srec/en-US/g2p_graphemes.syms
usr/srec/en-US/g2p_phonemes.syms
usr/srec/en-US/grammar.config
usr/srec/en-US/hmm_symbols
usr/srec/en-US/hmmlist
usr/srec/en-US/input_mean_std_dev
usr/srec/en-US/lexicon.U.fst
usr/srec/en-US/lstm_model.uint8.data
usr/srec/en-US/magic_mic.config
usr/srec/en-US/media_bias.fst
usr/srec/en-US/metadata
usr/srec/en-US/monastery_config.pumpkin
usr/srec/en-US/norm_fst
usr/srec/en-US/offensive_word_normalizer.mfar
usr/srec/en-US/offline_action_data.pb
usr/srec/en-US/phonelist
usr/srec/en-US/portable_lstm
usr/srec/en-US/portable_meanstddev
usr/srec/en-US/pumpkin.mmap
usr/srec/en-US/read_items_bias.fst
usr/srec/en-US/rescoring.fst.compact
usr/srec/en-US/semantics.pumpkin
usr/srec/en-US/skip_items_bias.fst
usr/srec/en-US/time_bias.fst
usr/srec/en-US/transform.mfar
usr/srec/en-US/voice_actions.config
usr/srec/en-US/voice_actions_compiler.config
usr/srec/en-US/word_confidence_classifier
usr/srec/en-US/wordlist.syms
vendor/lib/libfrsdk.so
vendor/lib64/libfrsdk.so
EOF
}

# Backup/Restore using /sdcard if the installed GApps size plus a buffer for other addon.d backups (204800=200MB) is larger than /tmp
installed_gapps_size_kb=$(grep "^installed_gapps_size_kb" /tmp/gapps.prop | cut -d '=' -f 2)
if [ ! "$installed_gapps_size_kb" ]; then
  installed_gapps_size_kb="$(cd /system; size=0; for n in $(du -ak $(list_files) | cut -f 1); do size=$((size+n)); done; echo "$size")"
  echo "installed_gapps_size_kb=$installed_gapps_size_kb" >> /tmp/gapps.prop
fi

free_tmp_size_kb=$(grep "^free_tmp_size_kb" /tmp/gapps.prop | cut -d '=' -f 2)
if [ ! "$free_tmp_size_kb" ]; then
  free_tmp_size_kb="$(echo $(df -k /tmp | tail -n 1) | cut -d ' ' -f 4)"
  echo "free_tmp_size_kb=$free_tmp_size_kb" >> /tmp/gapps.prop
fi

buffer_size_kb=204800
if [ $((installed_gapps_size_kb + buffer_size_kb)) -ge "$free_tmp_size_kb" ]; then
  C=/sdcard/tmp-gapps
fi

case "$1" in
  backup)
    list_files | while read -r FILE DUMMY; do
      backup_file "$S"/"$FILE"
    done
  ;;
  restore)
    list_files | while read -r FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Remove Stock/AOSP apps (from GApps Installer)
    rm -rf /system/system/app/Calculator
    rm -rf /system/system/app/ExactCalculator
    rm -rf /system/system/app/FineOSCalculator
    rm -rf /system/system/app/Calendar
    rm -rf /system/system/app/FineOSCalendar
    rm -rf /system/system/priv-app/Calendar
    rm -rf /system/system/app/DeskClock
    rm -rf /system/system/app/DeskClock2
    rm -rf /system/system/app/FineOSDeskClock
    rm -rf /system/system/app/Exchange2
    rm -rf /system/system/priv-app/Exchange2
    rm -rf /system/system/priv-app/ExtServices
    rm -rf /system/system/app/Provision
    rm -rf /system/system/priv-app/Provision
    rm -rf /system/system/priv-app/Tag

    # Remove 'other' apps (per installer.data)
    rm -rf /system/app/BooksStub
    rm -rf /system/app/CalendarGoogle
    rm -rf /system/app/CloudPrint
    rm -rf /system/app/DeskClockGoogle
    rm -rf /system/app/EditorsDocsStub
    rm -rf /system/app/EditorsSheetsStub
    rm -rf /system/app/EditorsSlidesStub
    rm -rf /system/app/Gmail
    rm -rf /system/app/Gmail2
    rm -rf /system/app/GoogleCalendar
    rm -rf /system/app/GoogleCloudPrint
    rm -rf /system/app/GoogleHangouts
    rm -rf /system/app/GoogleKeep
    rm -rf /system/app/GoogleLatinIme
    rm -rf /system/app/GooglePlus
    rm -rf /system/app/Keep
    rm -rf /system/app/NewsWeather
    rm -rf /system/app/NewsstandStub
    rm -rf /system/app/PartnerBookmarksProvider
    rm -rf /system/app/PrebuiltBugleStub
    rm -rf /system/app/PrebuiltKeepStub
    rm -rf /system/app/QuickSearchBox
    rm -rf /system/app/Vending
    rm -rf /system/priv-app/GmsCore
    rm -rf /system/priv-app/GmsCore_update
    rm -rf /system/priv-app/GoogleHangouts
    rm -rf /system/priv-app/GoogleNow
    rm -rf /system/priv-app/GoogleSearch
    rm -rf /system/priv-app/OneTimeInitializer
    rm -rf /system/priv-app/QuickSearchBox
    rm -rf /system/priv-app/Velvet_update
    rm -rf /system/priv-app/Vending

    # Remove 'priv-app' apps from 'app' (per installer.data)
    rm -rf /system/app/CanvasPackageInstaller
    rm -rf /system/app/ConfigUpdater
    rm -rf /system/app/GoogleBackupTransport
    rm -rf /system/app/GoogleFeedback
    rm -rf /system/app/GoogleLoginService
    rm -rf /system/app/GoogleOneTimeInitializer
    rm -rf /system/app/GooglePartnerSetup
    rm -rf /system/app/GoogleServicesFramework
    rm -rf /system/app/OneTimeInitializer
    rm -rf /system/app/Phonesky
    rm -rf /system/app/PrebuiltGmsCore
    rm -rf /system/app/SetupWizard
    rm -rf /system/app/Velvet

    # Remove 'required' apps (per installer.data)
    rm -rf /system/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf /system/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf /system/lib/libjni_keyboarddecoder.so
    rm -rf /system/lib/libjni_latinimegoogle.so
    rm -rf /system/lib64/libjni_keyboarddecoder.so
    rm -rf /system/lib64/libjni_latinimegoogle.so

    # Remove 'user requested' apps (from gapps-config)

  ;;
  post-restore)
    # Recreate required symlinks (from GApps Installer)
    install -d "/system/system/app/FaceLock/lib/arm64"
    ln -sfn "/system/system/lib64/libfacenet.so" "/system/system/app/FaceLock/lib/arm64/libfacenet.so"
    install -d "/system/app/LatinIME/lib64/arm64"
    ln -sfn "/system/lib64/libjni_latinimegoogle.so" "/system/app/LatinIME/lib64/arm64/libjni_latinimegoogle.so"
    ln -sfn "/system/lib64/libjni_keyboarddecoder.so" "/system/app/LatinIME/lib64/arm64/libjni_keyboarddecoder.so"

    # Apply build.prop changes (from GApps Installer)
    sed -i "s/ro.error.receiver.system.apps=.*/ro.error.receiver.system.apps=com.google.android.gms/g" /system/system/build.prop

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in /system/app /system/priv-app /system/vendor/pittpatt /system/usr/srec; do
      if [ -d $i ]; then
        find $i -type d -exec rmdir -p '{}' \+ 2>/dev/null;
      fi
    done;
    # Fix ownership/permissions and clean up after backup and restore from /sdcard
    find /system/vendor/pittpatt -type d -exec chown 0:2000 '{}' \; # Change pittpatt folders to root:shell per Google Factory Settings
    for i in $(list_files); do
      chown root:root "/system/$i"
      chmod 644 "/system/$i"
      chmod 755 "$(dirname "/system/$i")"
    done
    rm -rf /sdcard/tmp-gapps
  ;;
esac
