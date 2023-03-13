/**
 * Copyright 2022 Google LLC
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

resource "google_tags_tag_binding" "binding" {
  for_each = coalesce(var.tag_bindings, {})
  parent = (
    var.create_template
    ? "//compute.googleapis.com/${google_compute_instance_template.default.0.id}"
    : "//compute.googleapis.com/${google_compute_instance.default.0.id}"
  )
  tag_value = each.value
}

resource "google_tags_location_tag_binding" "network_binding" {
  for_each = coalesce(var.tag_bindings, {})
  location = local.region
  parent = (
    var.create_template
    ? "//compute.googleapis.com/${google_compute_instance_template.default.0.id}"
    : "//compute.googleapis.com/${google_compute_instance.default.0.id}"
  )
  tag_value = each.value
}
