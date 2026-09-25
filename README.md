# Löve2d Mobile Template

Build mobile apps and games using the **LÖVE 2D** – a powerful, lightweight Lua-based game engine optimized for rapid 2D graphics rendering and cross-platform mobile development.

See [Love2d.org](https://www.love2d.org) for more info.

## Example usage



## Design Philosophy

*If it's not drawing, it stays quiet.*

During the draw cycle, drawables add themselves to the **clickables** or **updateables** table. The table is cleared at the beginning of every draw frame. Therefore, any drawable that wants to receive update events must re-insert itself into the **updateables** table during each draw call.

Similarly, any drawable that wants to receive drag/press/release/click events must re-insert itself into the **clickables** table during each draw call.

*State

example
```lua
local self = { }
self.update = function(self, dt)
  -- not called unless self is inserted to updateables during draw
end

self.draw = function(self, w, h)
  table.insert(updateables, self)
end
```

## Requirements

- Love2d version 12.0 installed in your system path as `love`

- For Android build and deploy -- Android Studio version 21+

- For iOS build and deploy -- currently not supported

## Deploy to Mobile Devices

### Android

1. Edit **Application Id**, **version number** and **version code** from [android/gradle.properties](/android/gradle.properties).  

2. Edit App icon at [android/app/src/main/res/](/android/app/src/main/res/)
    - round icon: [android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml](/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml)
    - square icon: [android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml](/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml)

### iOS

# Troubleshooting Guide

## Android

---

### JAVA_HOME is not set correctly

`JAVA_HOME` must point to Android Studio's bundled JDK or another compatible Java installation.

Example:

```bash
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

Error:

```text
FAILURE: Build failed with an exception.

* What went wrong:
A problem occurred configuring root project 'LÖVE for Android'.
> Could not resolve all artifacts for configuration 'classpath'.
   > Could not resolve com.android.tools.build:gradle:8.13.2.
     Required by:
         root project :
      > Dependency requires at least JVM runtime version 11. This build uses a Java 8 JVM.
```

---

### ANDROID_HOME is not set

`ANDROID_HOME` must point to your Android SDK directory.

Example:

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
```

Error:

```text
FAILURE: Build failed with an exception.

* What went wrong:
A problem occurred configuring project ':app'.
> SDK location not found. Define a valid SDK location with an ANDROID_HOME environment variable or by setting the sdk.dir path in your project's local properties file at '/Users/heru/love2d-mobile-template/android/local.properties'.
```

---

### CMake or Ninja is missing

Install the required Android SDK tools in Android Studio:

- Settings / Preferences
  - Android SDK
  - SDK Tools
    - Android SDK Command-line Tools (latest)
    - CMake
    - NDK (Side by side)

Error:

```text
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:configureCMakeRelWithDebInfo[arm64-v8a]'.
> [CXX1416] Could not find Ninja on PATH or in SDK CMake bin folders.
```

---

### Android Platform Tools are missing

`adb` is part of the Android SDK Platform Tools package.

Install it from Android Studio:

- Settings / Preferences
  - Android SDK
  - SDK Tools
    - Android SDK Platform-Tools

You may also need to add it to your `PATH`.

Example:

```bash
export PATH="$ANDROID_HOME/platform-tools:$PATH"
```

Error:

```text
./scripts/run-android.sh: line 96: adb: command not found
```

---

### Gradle ran out of memory

Gradle does not have enough heap memory available to compile the Android Art Profile.

Increase the Gradle JVM heap size in:

```text
android/gradle.properties
```

Example:

```properties
org.gradle.jvmargs=-Xmx4096m -Dfile.encoding=UTF-8
```

Error:

```text
> Task :app:compileEmbedNoRecordReleaseArtProfile FAILED

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:compileEmbedNoRecordReleaseArtProfile'.
> A failure occurred while executing com.android.build.gradle.internal.tasks.CompileArtProfileTask$CompileArtProfileWorkAction
   > Java heap space
```
