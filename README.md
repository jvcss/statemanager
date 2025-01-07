# statemanager background task

- AndroidManifest.xml

```xml

<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="statemanager"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
    <!--...-->
    <!-- The following line should be present to ensure that the WorkManager library is properly initialized. -->
        <provider
            android:name="androidx.startup.InitializationProvider"
            android:authorities="${applicationId}.androidx-startup"
            android:exported="false">
            <meta-data
                android:name="androidx.work.WorkManagerInitializer"
                android:value="androidx.work.impl.WorkManagerInitializer" />
        </provider>
    </application>
    <!--...-->
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <!--...-->
</manifest>

```
