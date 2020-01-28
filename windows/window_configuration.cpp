// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "window_configuration.h"

#include <windows.h>

const unsigned int x = GetSystemMetrics(SM_CXSCREEN);
const unsigned int y = GetSystemMetrics(SM_CYSCREEN);

const wchar_t *kFlutterWindowTitle = L"Slicer";
const unsigned int kFlutterWindowWidth = 400;
const unsigned int kFlutterWindowHeight = 500;
const unsigned int kFlutterWindowOriginX = (x/2) - (kFlutterWindowWidth/2);
const unsigned int kFlutterWindowOriginY = (y/2) - (kFlutterWindowHeight/2);
