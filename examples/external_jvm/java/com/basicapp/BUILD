load("@rules_android//android:rules.bzl", "android_binary", "android_library")

android_binary(
    name = "basic_app",
    manifest = "AndroidManifest.xml",
    deps = [":basic_lib"],
)

android_library(
    name = "basic_lib",
    srcs = ["BasicActivity.java"],
    manifest = "AndroidManifest.xml",
    resource_files = glob(["res/**"]),
    deps = [
        "@maven//:androidx_activity_activity",
        "@maven//:com_google_guava_guava",  # Otherwise ListenableFuture does not exist
    ],
)
