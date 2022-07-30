// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_module_dlvn/webview/web_view.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Webview(
          url:
              'https://mobile.wellcare.vn/chat/621d18de05be85d1f60ab53f/621d18de05be85d1f60ab53f/?token=eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJmYjE4NDE2MC1jN2Y5LTQ5ZWItOTkxZC01OWNiOGI5OGIwZjEifQ.eyJleHAiOjE2NTk1OTEwNDMsImlhdCI6MTY1ODg5OTg0MywianRpIjoiOGVkZTMwMjYtYzFhYy00OGNiLWI5ZDMtOTlkOGI5ZjcyMDM1IiwiaXNzIjoiaHR0cHM6Ly9pYW0ud2VsbGNhcmUudm4vYXV0aC9yZWFsbXMvbWFzdGVyIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6ImViZGNlYWY5LTI5M2MtNGRlZi1hZGUzLTc3MzczYzM1YzkyOCIsInR5cCI6IkJlYXJlciIsImF6cCI6Im1oZWFsdGh2biIsInNlc3Npb25fc3RhdGUiOiJjNWIyNWVmYi03ZTA5LTRiYzktYWM1NC0xYmU0ZGNkODJhYzUiLCJhY3IiOiIxIiwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIndlbGxjYXJlOnVzZXIiLCJ3ZWxsY2FyZTphZG1pbiIsImRlZmF1bHQtcm9sZXMtbWFzdGVyIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoicHJvZmlsZSBlbWFpbCIsInNpZCI6ImM1YjI1ZWZiLTdlMDktNGJjOS1hYzU0LTFiZTRkY2Q4MmFjNSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoiODQzNTYyNzk1ODAiLCJ1c2VyaWQiOiI2MjFkMThkZTA1YmU4NWQxZjYwYWI1M2YifQ.Hew6eGV7JxYfAbS4E7zbHY7i-8RvmP9dAbu3iSSXskM'),
    ),
  );
}
