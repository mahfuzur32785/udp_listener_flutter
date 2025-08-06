# 📡 Flutter UDP Listener

A simple Flutter app to **listen to incoming UDP packets** using the [`udp`](https://pub.dev/packages/udp) package. Supports Android with required native permission configurations.

---

## 🔧 Features

- Bind to a specific UDP port
- Receive and display incoming UDP packets
- Cross-platform (with Android-specific permission setup)

---

## 🚀 Getting Started

### 1. Clone the Project

```bash
git clone https://github.com/your-username/flutter_udp_listener.git
cd flutter_udp_listener

Add this to your pubspec.yaml file:
  udp: ^2.1.0

Add Required Permissions in android/app/src/main/AndroidManifest.xml

<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE"/>


Update MainActivity.kt file twith this code

package com.yourpackage.name

import android.net.wifi.WifiManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private var multicastLock: WifiManager.MulticastLock? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val wifiManager = applicationContext.getSystemService(WIFI_SERVICE) as WifiManager
        multicastLock = wifiManager.createMulticastLock("udpLock")
        multicastLock?.setReferenceCounted(true)
        multicastLock?.acquire()
    }

    override fun onDestroy() {
        multicastLock?.release()
        super.onDestroy()
    }
}
