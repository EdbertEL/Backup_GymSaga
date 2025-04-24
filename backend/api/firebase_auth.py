import firebase_admin
from firebase_admin import auth, credentials
from rest_framework import authentication, exceptions
from django.contrib.auth.models import User
from .models import UserProfile
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

cred = credentials.Certificate(BASE_DIR / "firebase-adminsdk.json")
firebase_admin.initialize_app(cred)

class FirebaseAuthentication(authentication.BaseAuthentication):
    def authenticate(self, request):
        auth_header = request.headers.get('Authorization')
        if not auth_header:
            return None

        try:
            token_type, token = auth_header.split()
            if token_type != 'Bearer':
                return None
            decoded_token = auth.verify_id_token(token)
            uid = decoded_token['uid']
        except Exception as e:
            raise exceptions.AuthenticationFailed('Invalid Firebase token')

        try:
            profile = UserProfile.objects.get(uid=uid)
            user = profile.user
        except UserProfile.DoesNotExist:
            raise exceptions.AuthenticationFailed('User not found for this Firebase UID')

        return (user, None)
