load("@bazel_tools//tools/jdk:default_java_toolchain.bzl", "default_java_toolchain")

default_java_toolchain(
    name = "toolchain_android_only",
    bootclasspath = [
        "//tools/android:android_jar",
        # TODO(b/175805830): Add this only when desugaring is enabled.
        "//tools/android:desugar_java8_extra_bootclasspath",
    ],
    visibility = ["//visibility:public"],
)

alias(
    name = "toolchain",
    actual = "@bazel_tools//tools/jdk:toolchain",
    visibility = ["//visibility:public"],
)

alias(
    name = "current_java_runtime",
    actual = "@bazel_tools//tools/jdk:current_java_runtime",
    visibility = ["//visibility:public"],
)

alias(
    name = "current_java_toolchain",
    actual = "@bazel_tools//tools/jdk:current_java_toolchain",
    visibility = ["//visibility:public"],
)

alias(
    name = "jdk",
    actual = "@bazel_tools//tools/jdk:jdk",
    visibility = ["//visibility:public"],
)

alias(
    name = "current_host_java_runtime",
    actual = "@bazel_tools//tools/jdk:current_host_java_runtime",
    visibility = ["//visibility:public"],
)
