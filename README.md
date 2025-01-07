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


- Gradle Config 

```py
dependencies {
    def work_version = "2.9.1"

    // (Java only)
    implementation "androidx.work:work-runtime:$work_version"

    // Kotlin + coroutines
    implementation "androidx.work:work-runtime-ktx:$work_version"

    // optional - RxJava2 support
    implementation "androidx.work:work-rxjava2:$work_version"

    // optional - GCMNetworkManager support
    implementation "androidx.work:work-gcm:$work_version"

    // optional - Test helpers
    androidTestImplementation "androidx.work:work-testing:$work_version"

    // optional - Multiprocess support
    implementation "androidx.work:work-multiprocess:$work_version"
}
```