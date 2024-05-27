# Copyright 2018 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Rule adapter for kt_jvm_library."""

load(
    "//mobile_install:providers.bzl",
    "MIAndroidDexInfo",
    "MIJavaResourcesInfo",
    "providers",
)
load("//mobile_install:transform.bzl", "dex", "extract_jar_resources", "filter_jars")
load("@rules_java//java/common:java_info.bzl", "JavaInfo")
load(":base.bzl", "make_adapter")

def _aspect_attrs():
    """Attrs of the rule requiring traversal by the aspect."""
    return ["deps", "exports", "runtime_deps"]

def _adapt(target, ctx):
    """Adapts the rule and target data.

    Args:
      target: The target.
      ctx: The context.

    Returns:
      A list of providers.
    """
    if ctx.rule.attr.neverlink:
        return []

    return [
        providers.make_mi_android_dex_info(
            dex_shards = dex(
                ctx,
                filter_jars(
                    "empty.jar",
                    target[JavaInfo].runtime_output_jars,
                ),
                target[JavaInfo].transitive_compile_time_jars,
            ),
            deps = providers.collect(
                MIAndroidDexInfo,
                ctx.rule.attr.deps,
                ctx.rule.attr.runtime_deps,
                ctx.rule.attr.exports,
            ),
        ),
        providers.make_mi_java_resources_info(
            java_resources = extract_jar_resources(
                ctx,
                filter_jars(
                    "empty.jar",
                    target[JavaInfo].runtime_output_jars,
                ),
            ),
            deps = providers.collect(
                MIJavaResourcesInfo,
                ctx.rule.attr.deps,
                ctx.rule.attr.exports,
                ctx.rule.attr.runtime_deps,
            ),
        ),
    ]

kt_jvm_library = make_adapter(_aspect_attrs, _adapt)
