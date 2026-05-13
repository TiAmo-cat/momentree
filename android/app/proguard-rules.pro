# Flutter 核心
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Google Mobile Ads
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }

# SQLite / sqflite
-keep class org.sqlite.** { *; }
-keep class org.sqlite.database.** { *; }

# shared_preferences
-keep class androidx.preference.** { *; }

# flutter_local_notifications
-keep class com.dexterous.** { *; }

# Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Play Core (google_mobile_ads 依赖，AAB 环境下可忽略)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication

# 保留注解
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable


