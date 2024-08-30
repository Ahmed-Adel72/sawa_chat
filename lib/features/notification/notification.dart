import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:sawa_chat/core/constants/app_constants.dart';
import 'package:sawa_chat/core/helpers/cache_helper.dart';

class FirebaseAuthService {
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessagingToken() async {
    try {
      NotificationSettings settings = await fMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        final token = await fMessaging.getToken();
        if (token != null) {
          pushMyToken(token: token);
          CacheHelper.setData(key: 'myToken', value: token);
          print("Push Token: $token");
        } else {
          print("Failed to get FCM token");
        }
      } else {
        print("User declined or has not accepted permission");
      }
    } catch (e) {
      print("Error getting FCM token: $e");
    }
  }

  // Function to get the access token
  static Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "sawa-chat-30e8c",
      "private_key_id": "a2ff60d28f34d7cbefd137d23587849eb15bf386",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCpNU3RAXYHZLuQ\n1CWW8zC5HNdCByjPcOsY7sXCA0c109XdvIupf3WX0/RHrqW2UtHgtXsmQ9Dcuk6W\nC/5dbV7wb5HqRrioFgLgrrnI9vJwT1IAyYTVmz02rnHDGV4czofdpdQNhn7ZhJyu\nE3LJA956CMB7oIsleoWuLvMNX1fecKm77kqYCtBrHGNK5ag4X9ERL7nTzwWkOMr5\nkjganu7pg/myI9PauGQSRYzF22vdafnSlBbC2TAG2TxU7GpjxjVKAcGvwyry/kZ4\nPDPDCQl3eY3gHA1mNJin3aI0/DC8kSo5luslyk7rtK4QJuhAzzSMetC/MKqfqUDp\n/U5p3xcHAgMBAAECggEAHCZxDr92el5o0fxpUIae6X0B1stIH9LCWgCHR/KxqyPV\n5bDTb1x0HNE3R6GnkgCPSBoJJeGMYtxf7JiMNdDXRZraJKalW9llmymWYPesd8DK\nfLUJ81uDQJCe/n0+6f32HorTD3j7q4ZjZpZ3tzd8kMLZ+vdHjvGmQccvyl69SJUi\nVFsRs8gNSFwA/bWZMx9mPQX9Jv4vnRAC2olg+Sy0Ezv+dsihFVBbMv39sKrokkYn\nRFjyO0sQ7QiXKaVhm9KzqDiNAM9ODxPfvT2MOayoDBGtXxjIcts0XVl9FVti4fJm\nTWDfUOxLBXGHgAsEXk9VjTEKWq8uDMwQFS9x4o1G0QKBgQDdqHCl1CXpcO9gvIDC\nL01nsFcW69Bi/fu+V+gYkskmorj0Ulvj9GcqShnXqOuOybZCd9ixLzHeUeUV55v/\nuy8n+UOsWg9W2vviRU6cjRWMGEXOP3fEYBDvATvOnw/siHJ0sM6Bv7BCA0SL3whD\n0H0DcXsDzTaizKgJUzuezf8jbwKBgQDDbJBPBUSCqXgXD5Dm3SCPu/1Ivot/8L+l\nVMNIETMJw1oFGPy/CiMZcSx3XoaBFDOZDcKjcLtvqioUG3NrQ6SotNT4ikQ1bpSy\nvHFBGu2+ZNH97LZsHHoKI8hkw8SUeR7SF0cLmhhcdrBmJwLhLFql1aZIaIl5iY6v\nhIwgf+4Z6QKBgCOxMNpzC9vINLOWBwG9zjAJJCzrsfWOwk/HJfd3A272OuQUsvlE\n7KvRnNGuQKgQcQnI9JqrZ9NNyp65WdRXFuPP7oa9RcUNpAuub1ckHLkfW3Y3oBh+\nA5wIzdGaqVzEJ/IEWmxoKoCmuA3xzwnkc4zvZAibrdWPMOu3fF04/IF/AoGBAK3Y\n3UO+vuSx1+hD67bEzluvc7IL+FN3mzV8A0EQM+QiielxAh786J6QhGsohuU7UG9+\nw0DcX5IFwesjRHkOsuN2AuObNPSHi/a5FtNBHnA6hmiq9NmWN6bfkDy7vxwJ57Yk\nCQq0KanP2Dr3x2MDLxzJxGQzwuCA05MmifW7eNhJAoGAEhjEsYmW+WxF/NND1Zck\nbC5QrzbC0hEzF+7MtvmwndFFU5O4TasnV5waSMBZOH9Ieeltzummxje5S2Hc8dqq\nNf4uoht79Iu3FKqwUTCDR2+6rJjvql1eZhyqF8EStQxWw4RzF4gV+6qP55ekIZwh\niGPQ+uROR3/Mb3Pvbzcoc2o=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-8k22p@sawa-chat-30e8c.iam.gserviceaccount.com",
      "client_id": "113583392079762289757",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-8k22p%40sawa-chat-30e8c.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      print(
          "Access Tokeeeeeeeeeeeeen: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  static Future<void> pushMyToken({required String token}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).update({
        'pushToken': token,
      });
    } catch (error) {
      print(error.toString());
    }
  }

  static void sendNotification({
    required String name,
    required String lastMessage,
    required String userPushToken,
  }) async {
    // Attempt to get the access token
    String? accessTokenKey = await FirebaseAuthService.getAccessToken();

    if (accessTokenKey != null) {
      // Use the access token to make an authenticated request
      try {
        // Example: Sending a request to a Firebase function
        final response = await http.post(
          Uri.parse(urlEndPoint),
          headers: {
            'Authorization': 'Bearer $accessTokenKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "message": {
              "token": userPushToken,
              "notification": {
                "title": name,
                "body": lastMessage,
              },
              "android": {
                "notification": {
                  "notification_priority": "PRIORITY_MAX",
                  "sound": "default",
                }
              },
            },
          }), // JSON-encoded string
        );

        if (response.statusCode == 200) {
          // Handle the successful response
          print('Request successful: ${response.body}');
        } else {
          // Handle the unsuccessful response
          print('Request failed with status: ${response.statusCode}');
          print('Error response: ${response.body}');
        }
      } catch (e) {
        // Handle any errors during the HTTP request
        print('Error making authenticated request: $e');
      }
    } else {
      // Handle the error case where the access token could not be obtained
      print('Failed to get access token.');
    }
  }
}
