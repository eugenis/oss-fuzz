#!/bin/bash -eux
#
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
cd /src/freetype2/

./autogen.sh
./configure
make clean all

$CXX $CXXFLAGS $FUZZER_LDFLAGS -std=c++11 \
  -I./include -I. \
  ./src/tools/ftfuzzer/ftfuzzer.cc -o /out/freetype2_fuzzer \
  ./objs/*.o /work/libfuzzer/*.o \
  /usr/lib/x86_64-linux-gnu/libarchive.a \
  ./objs/.libs/libfreetype.a
