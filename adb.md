1. Отобразить подключённый девайс в консоли.
`adb devices`

2. Установить .apk файл приложения Reminder на телефон с компьютера через ADB.
`adb install Reminder.apk`

3. Вывести адрес приложения (пакет) Reminder в системе Android.
`adb shell pm list packages | findstr reminder`

4. Отобразить весь список установленных приложений на телефоне.
`adb shell pm list packages`

5. Сделать скриншот запущенного приложения Reminder и сразу скопировать на компьютер в одной команде.
`adb shell screencap -p /sdcard/screen.png && adb pull /sdcard/screen.png`

6. Вывести в консоль логи приложения Reminder.
`adb logcat | findstr com.qrolic.reminderapp`

7. Скопировать логи приложения Reminder на компьютер.
`adb logcat -d | findstr com.qrolic.reminderapp > app_log.log`

8. Удалить приложение Reminder с телефона через ADB.
`adb uninstall com.qrolic.reminderapp`