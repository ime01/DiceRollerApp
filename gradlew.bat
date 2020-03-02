/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.build.gradle.internal.dsl;

import com.android.annotations.NonNull;
import com.google.common.collect.Sets;
import java.util.Set;
import javax.inject.Inject;
import org.gradle.api.tasks.Input;

/**
 * DSL object for configuring APK packaging options.
 *
 * <p>Packaging options are configured with three sets of paths: first-picks, merges and excludes:
 *
 * <dl>
 *   <dt>First-pick
 *   <dd>Paths that match a first-pick pattern will be selected into the APK. If more than one path
 *       matches the first-pick, only the first found will be selected.
 *   <dt>Merge
 *   <dd>Paths that match a merge pattern will be concatenated and merged into the APK. When merging
 *       two files, a newline will be appended to the end of the first file, if it doesn't end with
 *       a newline already. This is done for all files, regardless of the type of contents.
 *   <dt>Exclude
 *   <dd>Paths that match an exclude pattern will not be included in the APK.
 * </dl>
 *
 * To decide the action on a specific path, the following algorithm is used:
 *
 * <ol>
 *   <li>If any of the first-pick patterns match the path and that path has not been included in the
 *       FULL_APK, add it to the FULL_APK.
 *   <li>If any of the first-pick patterns match the path and that path has already been included in
 *       the FULL_APK, do not include the path in the FULL_APK.
 *   <li>If any of the merge patterns match the path and that path has not been included in the APK,
 *       add it to the APK.
 *   <li>If any of the merge patterns match the path and that path has already been included in the
 *       FULL_APK, conc