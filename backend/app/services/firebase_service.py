import os
import firebase_admin
from firebase_admin import credentials
from app.core.config import settings

def initialize_firebase():
    try:
        if not os.path.exists(settings.FIREBASE_CREDENTIALS_PATH):
            print(f"Warning: Firebase credentials file not found at {settings.FIREBASE_CREDENTIALS_PATH}")
            return

        cred = credentials.Certificate(settings.FIREBASE_CREDENTIALS_PATH)
        firebase_admin.initialize_app(cred)
        print("Firebase Admin SDK initialized successfully.")
    except ValueError:
        print("Firebase Admin SDK already initialized.")
    except Exception as e:
        print(f"Error initializing Firebase Admin SDK: {e}")
