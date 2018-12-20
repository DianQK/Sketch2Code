# Sketch2Code

> 先解决布局（位置和层级），再说样式和组件。

[![](https://img.youtube.com/vi/zi9Dsc5W2UM/0.jpg)](https://youtu.be/zi9Dsc5W2UM)

## 如何运行

首先编译运行 Sketch2Code，要来处理 Sketch 文件，生成代码。

参数建议：
使用 Xcode：
Arguments Passed On Launch 有两个：

```
$SRCROOT/Example/Example/UI.swift
$SRCROOT/OtherResources/Example.sketch
```

使用 swift build：
编译：

```
swift build -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.13"
```

运行：

```
.build/debug/Sketch2Code ./OtherResources/Example.sketch ./Example/Example/UI.swift
```

最后运行 Example 工程即可。

> 代码写的比较随意，还有 99% 的功能没写，欢迎 PR。